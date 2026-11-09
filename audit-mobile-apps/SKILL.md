---
name: audit-mobile-apps
description: Use this skill whenever auditing, reviewing, evaluating, or checking mobile apps (Android or iOS) for quality, compliance, Google Play or App Store readiness, technical quality, privacy security, performance, maintainability, logging, error handling, unique naming, type consistency, and code reuse. Triggers include audit mobile app, review app code, Android iOS quality check, Play Store App Store compliance, production readiness audit, logging error handling review.
---

# Audit Mobile Apps Skill

Systematically evaluate Android (Kotlin/Jetpack Compose) and iOS (Swift/SwiftUI/Xcode) apps against official platform quality guidelines, store policies (Apple App Review Guidelines Oct 16 2026+ and Google Play Developer Program Policies), and coding best practices. Assess correctness, security, performance, maintainability (including DRY unified functions, unique naming, type consistency), observability (logging and error reporting), and store readiness. Produce structured findings with severity and actionable recommendations. Reference apple-app-store-guidelines skill for detailed iOS rules.

## Core Principles

- Prioritize: **Correctness > Security > Performance > Maintainability > Style**.
- Focus on production readiness. Be constructive and specific.
- Enforce unique function/variable names to avoid conflicts (descriptive, module-scoped or prefixed; avoid generic `data`, `result`, `temp`, `item`, `logger` in shared or large scopes).
- Prefer unified reusable functions over duplicated logic (DRY). Flag repeated error handling, logging, networking, validation, or formatting code that should be extracted to shared utilities.
- Require proper structured logging and error/warning reporting (no swallowed errors, no sensitive data in logs, remote crash reporting integrated).
- Enforce type consistency: sealed classes/Result for states/errors, exhaustive handling, no `!!` or force unwraps.

## 1. Correctness & Bugs

- Logic errors, edge cases, race conditions, concurrency issues (coroutines/actors, main thread work, Swift 6 strict concurrency).
- Error handling gaps: unhandled exceptions, force unwraps (`!!` in Kotlin, force unwrap in Swift), missing Result/sealed error types.
- Incorrect API usage, lifecycle issues (ViewModel leaks, missing cancellation).
- State management problems (impossible states, missing loading/empty/error states). Consistent types (data classes, non-null by default).

## 2. Security & Privacy

- Minimal permissions with runtime rationale and graceful degradation. Prefer system pickers (contacts, photos). New restrictions (local network, contacts) require declarations if used.
- Sensitive data only in Keychain/Keystore; no plaintext SharedPreferences/NSUserDefaults for secrets; no sensitive data in logs.
- HTTPS only + network security config, certificate pinning where appropriate, no hardcoded secrets. Platform crypto only (no custom algorithms).
- Strong crypto, Play Integrity / App Attest where relevant.
- Scoped storage, no non-resettable IDs. Component export flags correct.
- Compliance with Play User Data policy and App Store privacy policies (accurate privacy policy public + in-app, Data safety form matches reality, ATT if tracking, account deletion if accounts created).
- No malware, deceptive behavior, or hidden/dormant/undocumented features (Apple 2.5.19). UGC/AI content requires filtering (incl. nonconsensual intimate imagery), reporting, blocking.

## 3. Performance & Technical Quality

- Startup <2s to interactive or progress indicator. Baseline Profiles (Android), reportFullyDrawn.
- ≥60 FPS, no jank. Efficient rendering (avoid unnecessary recompositions in Compose/SwiftUI).
- Battery and network efficient. Respect Doze/App Standby, background limits.
- App size minimized (AAB, feature delivery). R8/ProGuard enabled for release.
- No crashes or ANRs. Monitor via Android Vitals / Crashlytics. Aim <0.1–0.2% crash rate. StrictMode clean.
- Target latest API levels (Android 16+/API 36+, Xcode 26+ / latest iOS SDK as of 2026). Upcoming memory thresholds (Feb 2027).
- Tools: Android Vitals, pre-launch reports, Instruments, Macrobenchmark, StrictMode.

## 4. Maintainability, Naming, Type Consistency & Code Reuse

- Modular feature-based architecture (not giant type-based folders). Layered (UI → Domain → Data) with unidirectional data flow. SPM packages or Gradle modules for large apps.
- Unique, descriptive names: functions/variables clearly scoped (e.g., `AuthLogger`, `UserSessionRepository`, not shared `logger` or `data`). Verb phrases for funcs, noun for types.
- DRY: Extract common logic into unified shared utilities (central Logger, ErrorHandler, NetworkClient, validators). Flag duplicated blocks.
- Small focused files (<300–500 lines). Clear separation of concerns. No god functions.
- **Type consistency**: Sealed UiState / error types, exhaustive `when`/switch, Result or throws, data/value classes, consistent nullability. Avoid stringly-typed control flow.
- Documentation where non-obvious. Linting (SwiftLint, Android Lint, ktlint) clean. MARK sections (iOS).

## 5. Logging, Observability & Error Reporting

- Structured logging with stable event names (e.g., `auth.login_failed`), levels (debug/info/warn/error), and key-value context (session ID, screen, app version).
- Centralized logger that routes to console (debug) and remote (Crashlytics/Sentry) in release. No PII, tokens, or secrets. Privacy annotations where applicable (os.Logger).
- Non-fatal errors reported with custom keys/error codes for grouping.
- Breadcrumbs or session correlation so crashes include preceding events.
- Warnings for recoverable issues. Debug logging stripped from release builds.
- Analytics events consistent and documented.

## 6. Platform-Specific Checks

### Android (Google Play)
- Kotlin + Jetpack Compose + Material 3 preferred. Adaptive layouts for phones/tablets/foldables (edge-to-edge, no letterboxing). Form factor tiers if targeting large screens.
- Touch targets ≥48dp, contrast ≥4.5:1, accessibility (content descriptions).
- Coroutines lifecycle-aware, no GlobalScope. Permissions runtime with rationale.
- R8 enabled, Baseline Profiles, reportFullyDrawn. Target API 36+.
- Policies: accurate Data safety form, privacy policy, no restricted content, SDK compliance, accurate metadata. No crashes/ANRs. Upcoming memory/DEX thresholds.

### iOS / Xcode (App Store)
- Swift + SwiftUI preferred. Follow Human Interface Guidelines (accessibility, Dynamic Type, dark mode, Liquid Glass).
- Modular structure (feature modules or SPM packages). Group by feature, not type.
- No force unwraps. Proper error handling with Result or throws. Swift 6 strict concurrency (SWIFT_STRICT_CONCURRENCY=complete, @MainActor, Sendable). Privacy manifests. os.Logger with privacy levels.
- App Store Review Guidelines compliance (2.1 completeness: no crashes/placeholders/demo access; 2.3 accurate metadata/creative assets 2.3.14; 2.5.19 no hidden features; 5.1 privacy; UGC/AI moderation per 1.2).
- Xcode 26+ builds, proper signing, privacy manifests, TestFlight readiness. Account deletion if applicable.

## 7. Store Readiness

- Accurate store listing, screenshots (actual app), privacy policy, content rating, Data safety form / privacy labels.
- No crashes/bugs/placeholders. Demo account or demo mode if login required.
- Target SDK compliance. Phased rollouts recommended.
- Monetization (IAP) rules followed. No external payments for digital goods where prohibited. No spam or copycat design.
- For Apple: No hidden features, proper UGC safeguards. For Google: User Data policy compliance.

## Output Format

**Summary**  
One paragraph on overall quality and key risks.

**Issues Found** (by severity)  
- **Critical**: Must fix before release (crashes, security holes, policy violations such as hidden features or inaccurate Data safety, swallowed errors that hide failures).  
- **Important**: Should fix (performance, maintainability, missing logging, name conflicts, duplicated logic, type inconsistencies).  
- **Minor**: Nice to improve (style, clarity).  

For each: location if possible, explanation of why it matters, specific suggested fix (with small code example when helpful).

**Positive Observations**  
What was done well.

**Suggestions for Improvement**  
Architectural or process recommendations (e.g., extract shared Logger utility, adopt sealed error types, add Baseline Profiles).

**Questions for the Author** (optional)

Always ask: "Would I be comfortable shipping this code?"

Key official references: developer.android.com/quality (core and adaptive), support.google.com/googleplay/android-developer policies, developer.apple.com/app-store/review/guidelines/, developer.apple.com/design/human-interface-guidelines/. Guidelines evolve — verify latest versions. Re-test after fixes.
