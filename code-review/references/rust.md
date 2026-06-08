# Rust Code Review Reference

Use this guide when reviewing Rust code. Focus on these areas in addition to general best practices.

## 1. Unsafe Code

**Red Flags:**
- Use of `unsafe` blocks without clear justification and documentation
- `static mut` (almost always avoid — use `OnceLock`, `LazyLock`, or `std::sync` primitives instead)
- Raw pointer manipulation without clear safety invariants
- FFI code without proper safety documentation

**Good Practice:**
```rust
// BAD
static mut COUNTER: i32 = 0;

// GOOD
use std::sync::atomic::{AtomicI32, Ordering};
static COUNTER: AtomicI32 = AtomicI32::new(0);
```

## 2. Ownership & Cloning

**Common Issues:**
- Unnecessary `.clone()` or `.to_owned()` (especially in hot paths)
- Cloning large data structures when references or `Cow` would work
- Moving values into closures when borrowing is sufficient

**Questions to ask:**
- Can this be borrowed instead of owned?
- Is the clone necessary, or is it masking a design issue?
- Would `Cow<'_, T>` or `Arc` be more appropriate?

## 3. Error Handling

**Red Flags:**
- `.unwrap()` or `.expect()` in production/library code (except in tests or truly impossible cases)
- Swallowing errors with `let _ = ...`
- Using `panic!` for recoverable errors
- Inconsistent error types across a module/crate

**Preferred Patterns:**
- Use `?` operator aggressively
- Define custom error types with `thiserror` or `anyhow` (depending on context)
- Return `Result<T, E>` from fallible functions

## 4. Performance & Allocations

**Watch for:**
- Allocations inside hot loops
- `format!()` when `write!()` to a buffer would suffice
- Unnecessary `String` creation when `&str` is sufficient
- `Vec::new()` + repeated `push` when capacity is known
- Boxing trait objects when static dispatch is possible

**Good signals:**
- Use of `SmallVec`, `ArrayVec`, or `tinyvec` where appropriate
- `#[inline]` usage on small hot functions
- Proper use of iterators instead of indexed loops

## 5. Idiomatic Patterns (2024+)

| Pattern                    | Preferred                  | Avoid                          |
|---------------------------|----------------------------|--------------------------------|
| Error handling            | `thiserror` + `?`          | Manual `From` impls everywhere |
| Async                     | `tokio::spawn` + structured| Spawning without JoinHandle    |
| Globals                   | `OnceLock` / `LazyLock`    | `static mut`                   |
| String building           | `write!` / `format_args!`  | Repeated `format!` + `+`       |
| Iteration                 | Iterators                  | Manual index loops             |
| Defaults                  | `Default` derive           | Manual `impl Default`          |

## 6. Useful Clippy Lints to Consider

Run these mentally or suggest enabling them:

- `clippy::unwrap_used`
- `clippy::expect_used`
- `clippy::panic`
- `clippy::clone_on_copy`
- `clippy::unnecessary_clone`
- `clippy::redundant_clone`
- `clippy::inefficient_to_string`
- `clippy::manual_map`
- `clippy::or_fun_call`
- `clippy::single_match_else`

## 7. Concurrency

**Check for:**
- Data races via shared mutable state
- Blocking operations inside async functions
- Use of `std::thread::spawn` when `tokio::spawn` or `rayon` would be better
- Missing `Send + Sync` bounds where needed
- Improper use of `Mutex` vs `RwLock`

## 8. Async & Tokio

**Common Issues:**
- Blocking operations inside async functions (use `tokio::task::spawn_blocking` for CPU-bound work)
- Spawning tasks without handling the `JoinHandle`
- Shared state without proper synchronization (`Mutex`, `RwLock`, or `tokio::sync` types)
- Using `std::sync::Mutex` inside async code (can cause deadlocks)
- Not using `tokio::select!` or cancellation tokens for graceful shutdown
- Capturing references across `.await` points incorrectly

**Good Practices:**
- Prefer `tokio::sync::Mutex` / `RwLock` in async contexts
- Use `Arc` for shared ownership across tasks
- Structure tasks with proper cancellation and error propagation
- Consider `tokio::spawn` + `JoinSet` for managing multiple tasks

**Review Questions:**
- Is any blocking I/O or heavy computation happening directly in an async function?
- Are tasks being properly awaited or joined?
- Is shared state protected correctly?

## 9. Serde

**Watch For:**
- Deriving `Serialize`/`Deserialize` on types containing secrets
- Using `#[serde(flatten)]` excessively (can hurt performance and clarity)
- Missing `#[serde(default)]` when fields might be absent
- Using `String` for IDs instead of newtypes
- Inefficient serialization of large data (consider `serde_json::to_writer` + buffering)

**Good Patterns:**
- Use newtype wrappers for domain IDs with custom `Serialize`/`Deserialize`
- Prefer `#[serde(rename_all = "camelCase")]` or `snake_case` consistently
- Use `#[serde(skip_serializing_if = "Option::is_none")]` where appropriate
- Consider `serde_with` for complex transformations

## 10. Working with External Crates (mistralrs, etc.)

When reviewing code that uses crates like **mistralrs**, **tokio**, or other heavy dependencies:

- Check that expensive operations (model loading, inference) are properly offloaded or managed
- Ensure model handles / clients are wrapped in `Arc` when shared across tasks
- Verify that long-running operations (inference) don't block the async runtime
- Look for proper error handling around external crate calls
- Check resource cleanup (especially important with LLM inference engines)

**mistralrs Specific:**
- Model loading should ideally happen once at startup
- Inference calls can be expensive — consider offloading to a dedicated task or using channels
- Be mindful of memory usage when holding model instances

## Quick Decision Framework

When reviewing Rust code, ask:

1. **Is it safe?** (No `unsafe` without reason, no `static mut`)
2. **Is it efficient?** (Reasonable allocations, good algorithms, non-blocking async)
3. **Is it idiomatic?** (Uses modern patterns, good error handling, proper ownership)
4. **Is shared state handled correctly?** (Especially in async + multi-threaded code)
5. **Would clippy complain?** 

**Tip:** When in doubt, suggest running:
```bash
cargo clippy -- -D warnings
cargo audit
```