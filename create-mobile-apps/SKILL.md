---
name: create-mobile-apps
description: Use this skill whenever creating, building, developing, or planning mobile apps for iOS (Xcode/Swift/SwiftUI) or Android (Kotlin/Jetpack Compose). Enforces workflow with file blueprints, unique function/variable names to avoid conflicts, unified reusable utility functions (logging, error handling, networking), structured logging and proper error/warning reporting from the start, type consistency, modular architecture, platform guidelines, testing, and store readiness. Triggers include create mobile app, build Android iOS app, app development workflow, Xcode Swift app, Jetpack Compose app.
---

# Create Mobile Apps Skill

Follow this ordered workflow to design, plan, and implement high-quality mobile apps. Prefer Kotlin + Jetpack Compose for Android and Swift + SwiftUI for iOS. Target latest SDKs (Android 16+/API 36+, Xcode 26+/iOS 26). Enforce unique naming, DRY via unified shared utilities, structured logging, robust error handling, and type consistency from day one. Reference file-blueprint-planner for detailed per-file plans and audit-mobile-apps for pre-release checks. Cross-reference apple-app-store-guidelines for deep Apple compliance.

## 1. Requirements, Scope & Platform Choice

- Clarify target users, core value, platforms (iOS, Android, or both), constraints, and offline needs.
- Break large apps into small single-responsibility features/modules. Plan many small files rather than large ones.
- Choose native for best performance and platform fidelity; document the decision.

## 2. Architecture & Planning

- Use layered architecture (UI → Domain → Data) with unidirectional data flow. ViewModels or equivalent for state. Feature-based modules (not type-based folders). Use actual folders for groups.
- For each major file or module, generate a detailed blueprint using the file-blueprint-planner template (purpose, public API, dependencies, logic, naming rationale, risks).
- Plan and implement shared utility modules in Core **first**, before features:
  - **Logger**: Structured logging with levels and context (Timber on Android or central equivalent; os.Logger on iOS with privacy annotations).
  - **Error types / Handler**: Sealed classes or Result types; central reporting to Crashlytics/Sentry.
  - **NetworkClient**: HTTPS, timeouts, retry, idempotency keys, network security config.
  - **Validators**, formatters, and other repeated logic.
- Directory structure example:
  ```
  App/
  Core/ (Logger, Networking, Storage, ErrorHandling, DesignSystem)
  Features/ (Auth/, Dashboard/, ... each with View, ViewModel, Domain, Data)
  ```
- For large apps, use SPM packages (iOS) or Gradle feature modules (Android).

## 3. Naming Conventions to Avoid Conflicts

- Use descriptive, unique names. Functions are verb phrases; variables/types are noun phrases.
- Scope names to modules or features (e.g., `AuthSessionManager`, `DashboardLoadState`, `NetworkRequestLogger`). Avoid generic names (`data`, `result`, `temp`, `item`, `logger`) in shared or large scopes.
- Prefix project-specific utilities if needed (e.g., `AppLogger`). Check existing code before adding new functions—reuse or extend unified ones.
- Consistent casing: camelCase for vars/funcs, PascalCase for types (Swift/Kotlin conventions). No obscure abbreviations.

## 4. Implementation Best Practices

- **Type Handling & Consistency**: Prefer sealed classes/enums for states and errors (exhaustive when/switch). Use Result or throws. Avoid `!!` (Kotlin) and force unwraps/try! (Swift). Consistent non-null by default, data/value classes. No stringly-typed control flow or magic numbers/strings. Strong type hierarchy for errors.
- **DRY & Unified Functions**: Extract any logic used more than once (or likely to be) into shared utilities. Do not duplicate error handling, logging wrappers, network calls, or validation.
- **Logging & Observability** (implement early):
  - Structured logs with stable event names (e.g., `auth.login_succeeded`) and key-value attributes (screen, session_id, duration_ms, app_version).
  - Levels: debug (dev only), info, warn, error.
  - Central logger routes to console in debug and Crashlytics/Sentry (or equivalent) in release. Never log PII, tokens, passwords, or secrets. Use privacy: .private on iOS. Strip debug logs in release (R8/Swift).
  - Attach context and breadcrumbs so crashes include preceding events. Use error codes for non-fatals. Warnings for recoverable issues.
- **Error Handling**:
  - Prefer sealed error types or Result. Never swallow exceptions (empty catch) or force-unwrap.
  - Propagate with context. Provide user-friendly messages; log technical details separately.
  - Report non-fatal errors to remote service with custom keys.
- **Security & Privacy**: Minimal permissions (request at runtime with rationale, prefer system pickers), Keychain/Keystore for secrets, HTTPS only + network security config, no sensitive data in logs or external storage. Privacy manifests (PrivacyInfo.xcprivacy) for required-reason APIs on iOS. Credential Manager where applicable.
- **UI & UX**: Follow Material Design 3 (Android) and Human Interface Guidelines (iOS). Adaptive layouts (edge-to-edge, predictive back on API 36+), accessibility (touch targets ≥48dp/44pt, contrast ≥4.5:1, content descriptions, Dynamic Type, VoiceOver), light/dark support, all screen states (loading, empty, error, offline, success).
- **Performance**: Fast startup (<2s or progress indicator), 60 FPS, efficient state updates (avoid unnecessary recompositions), Baseline Profiles (Android), reportFullyDrawn. Respect Doze/App Standby.
- Platform notes:
  - **Android**: Lifecycle-aware coroutines, no GlobalScope or `!!`. R8 for release. Edge-to-edge. Android Vitals awareness. Timber or structured logging. ktlint/Android Lint clean.
  - **iOS**: No force unwraps. @MainActor / actors for Swift 6 strict concurrency. Modular SPM packages if large. Privacy manifests. MARK sections for organization. os.Logger. SwiftLint clean. Instruments for profiling.

## 5. Testing & Quality Gates

- Unit tests for ViewModels, domain logic, repositories, and shared utilities.
- UI tests for critical flows (XCTest, Espresso).
- Run platform linters (Android Lint, ktlint, SwiftLint) and static analysis. Enable Swift 6 strict concurrency checking.
- Test on real devices / form factors (phones, tablets, foldables). Use StrictMode, Instruments.
- Integrate crash reporting and basic analytics before first beta. StoreKit Testing for IAP.

## 6. Store Readiness & Release

- Complete privacy policy (public URL + in-app), Data safety form / privacy labels (accurate to actual collection/SDKs), content rating, accurate metadata and screenshots. No placeholders.
- Demo account or demo mode for review if login required. Turn on backends.
- Target latest API / SDK (Android 16+/API 36+, Xcode 26+). Enable minification/obfuscation. App Bundles (AAB).
- Account deletion in-app if accounts created. No hidden/dormant features (Apple 2.5.19).
- Phased rollouts. Monitor Android Vitals / Crashlytics post-launch. Aim <0.1–0.2% crash rate.
- Run full audit-mobile-apps skill before submission. Reference apple-app-store-guidelines for Apple deep dive.

## Output When Using This Skill

When planning or implementing:
1. Restate scope and suggest modular breakdown.
2. Produce or request file blueprints for key modules.
3. Propose shared utility designs (Logger, ErrorHandler signatures) and implement them first.
4. Highlight naming, type consistency, and reuse decisions.
5. After implementation, recommend running the audit skill.

Always prioritize shipping correct, secure, observable, type-safe, and maintainable code over speed.
