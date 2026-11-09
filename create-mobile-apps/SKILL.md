---
name: create-mobile-apps
description: Use this skill whenever creating, building, developing, or planning mobile apps for iOS (Xcode/Swift/SwiftUI) or Android (Kotlin/Jetpack Compose). Enforces ordered workflow with file blueprints, unique descriptive function/variable names to avoid conflicts, unified reusable utility functions (Logger, ErrorHandler, NetworkClient), structured logging and proper error/warning reporting from the start, consistent type handling (sealed classes/Result, no force unwraps), modular architecture, platform guidelines, testing, and store readiness. Triggers include create mobile app, build Android iOS app, app development workflow, Xcode Swift app, Jetpack Compose app.
---

# Create Mobile Apps Skill

Follow this ordered workflow to design, plan, and implement high-quality mobile apps. Prefer Kotlin + Jetpack Compose for Android and Swift + SwiftUI for iOS. Target latest SDKs (Android API 36+/Android 16, Xcode 26+). Enforce unique naming, DRY via unified shared utilities, structured logging, robust error handling, and consistent type safety from day one. Reference file-blueprint-planner for detailed per-file plans, audit-mobile-apps for pre-release checks, apple-app-store-guidelines for iOS compliance, and official Google Play policies/quality guidelines for Android.

## 1. Requirements, Scope & Platform Choice

- Clarify target users, core value, platforms (iOS, Android, or both), constraints, offline needs, and monetization.
- Break large apps into small single-responsibility features/modules. Plan many small files rather than large ones (<300–500 lines preferred).
- Choose native for best performance, platform fidelity, and guideline compliance; document the decision. Support adaptive form factors (phones, tablets, foldables).

## 2. Architecture & Planning

- Use layered architecture (UI → Domain → Data) with unidirectional data flow. ViewModels or equivalent for state. Feature-based modules (not type-based folders).
- For each major file or module, generate a detailed blueprint using the file-blueprint-planner template (purpose, public API, dependencies, logic, naming rationale, risks).
- Plan shared utility modules **early** (before feature work):
  - **Logger**: Structured logging with levels, stable event names, and key-value context.
  - **Error types / Handler**: Sealed classes or Result types; central reporting to Crashlytics/Sentry.
  - **NetworkClient**: HTTPS only, timeouts, retry, idempotency keys, network security config.
  - **Validators**, formatters, and other repeated logic.
- Directory structure example:
  ```
  App/
  Core/ (Logger, Networking, Storage, ErrorHandling, DesignSystem)
  Features/ (Auth/, Dashboard/, ... each with View, ViewModel, Domain, Data)
  ```

## 3. Naming Conventions & Type Consistency to Avoid Conflicts

- Use descriptive, unique names. Functions are verb phrases; variables/types are noun phrases.
- Scope names to modules or features (e.g., `AuthSessionManager`, `DashboardLoadState`, `NetworkRequestLogger`). Avoid generic names (`data`, `result`, `temp`, `item`, `logger`, `obj`) in shared or large scopes.
- Prefix project-specific utilities if needed (e.g., `AppLogger`). Check existing code before adding new functions—reuse or extend unified ones.
- Consistent casing: camelCase for vars/funcs, PascalCase for types (Swift/Kotlin conventions).
- **Type handling**: Prefer sealed classes/enums for UI states and errors (exhaustive `when`/switch). Use Result or throws for operations that can fail. Avoid `!!` (Kotlin) and force unwraps (Swift). Consistent nullability (non-null by default). Data/value classes for models. No stringly-typed control flow.

## 4. Implementation Best Practices

- **DRY & Unified Functions**: Extract any logic used more than once (or likely to be) into shared utilities in Core. Do not duplicate error handling, logging wrappers, network calls, validation, or formatting. Implement shared utilities first.
- **Logging & Observability** (implement early):
  - Structured logs with stable event names (e.g., `auth.login_succeeded`) and key-value attributes (screen, session_id, duration_ms, app_version).
  - Levels: debug (dev only), info, warn, error.
  - Central logger routes to console in debug and Crashlytics/Sentry (or equivalent) in release. Never log PII, tokens, passwords, or secrets.
  - Attach context and breadcrumbs so crashes include preceding events. Use error codes for non-fatals. Strip debug logs in release.
- **Error Handling**:
  - Prefer sealed error types or Result. Never swallow exceptions (empty catch) or force-unwrap.
  - Propagate with context. Provide user-friendly messages; log technical details separately.
  - Report non-fatal errors to remote service with custom keys. Warnings for recoverable issues.
- **Security & Privacy**: Minimal permissions (request at runtime with rationale, prefer system pickers), Keychain/Keystore for secrets, HTTPS only + network security config, no sensitive data in logs or external storage. Accurate privacy policy and Data safety form / privacy labels from the start.
- **UI & UX**: Follow Material Design 3 (Android) and Human Interface Guidelines (iOS, including Liquid Glass where relevant). Adaptive layouts, accessibility (touch targets ≥48dp, contrast ≥4.5:1, content descriptions, Dynamic Type), light/dark support, all screen states (loading, empty, error, offline, success). Edge-to-edge.
- **Performance**: Fast startup (<2s to interactive or progress), ≥60 FPS, efficient state updates, Baseline Profiles (Android), reportFullyDrawn. R8 minification for release.
- Platform notes:
  - **Android**: Lifecycle-aware coroutines, no GlobalScope or `!!`. R8 for release. Edge-to-edge. Android Vitals awareness. Target API 36+. Prefer system intents for contacts/photos.
  - **iOS**: No force unwraps. @MainActor / Swift 6 strict concurrency (enable complete checking, Sendable) where needed. Modular SPM packages if large. Privacy manifests (PrivacyInfo.xcprivacy) for required-reason APIs. MARK sections for organization. No hidden/dormant features.

## 5. Testing & Quality Gates

- Unit tests for ViewModels, domain logic, repositories, and shared utilities.
- UI tests for critical flows (Compose testing APIs / XCTest).
- Run platform linters (Android Lint, ktlint, SwiftLint) and static analysis. StrictMode clean in debug.
- Test on real devices / form factors (phones, tablets, foldables).
- Integrate crash reporting and basic analytics before first beta.

## 6. Store Readiness & Release

- Complete privacy policy (public, accurate, covers collection/use/share/retention/security), Data safety form / privacy nutrition labels, content rating, accurate metadata and screenshots (actual app in use).
- Demo account or demo mode for review if login required. No placeholders.
- Target latest API / SDK (Android 16+/API 36+, Xcode 26+). Enable minification/obfuscation. App Bundles (.aab) for Android.
- No hidden features (Apple 2.5.19). UGC/AI content must have moderation (filter, report, block).
- Phased rollouts. Monitor Android Vitals / Crashlytics post-launch.
- Run full audit-mobile-apps skill (and apple-app-store-guidelines for iOS) before submission.

## Output When Using This Skill

When planning or implementing:
1. Restate scope and suggest modular breakdown.
2. Produce or request file blueprints for key modules.
3. Propose shared utility designs (Logger, ErrorHandler signatures) first.
4. Highlight naming, type consistency, and reuse decisions.
5. After implementation, recommend running the audit skill.

Always prioritize shipping correct, secure, observable, maintainable, and guideline-compliant code over speed. Reference official docs: developer.android.com/quality, developer.apple.com/app-store/review/guidelines/, developer.apple.com/design/human-interface-guidelines/.
