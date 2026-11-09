---
name: audit-mobile-apps
description: Use this skill whenever auditing, reviewing, evaluating, or checking mobile apps (Android or iOS) for quality, compliance, Google Play or App Store readiness, technical quality, privacy security, performance, maintainability, logging, error handling, unique naming, and code reuse. Triggers include audit mobile app, review app code, Android iOS quality check, Play Store App Store compliance, production readiness audit, logging error handling review.
---

# Audit Mobile Apps Skill

Systematically evaluate Android (Kotlin/Jetpack Compose) and iOS (Swift/SwiftUI/Xcode) apps against official platform quality guidelines, store policies, and coding best practices. Assess correctness, security, performance, maintainability (including DRY unified functions and unique naming), observability (logging and error reporting), and store readiness. Produce structured findings with severity and actionable recommendations.

## Core Principles

- Prioritize: **Correctness > Security > Performance > Maintainability > Style**.
- Focus on production readiness. Be constructive and specific.
- Enforce unique function/variable names to avoid conflicts (descriptive, module-scoped or prefixed; avoid generic `data`, `result`, `temp`, `item` in shared or large scopes).
- Prefer unified reusable functions over duplicated logic (DRY). Flag repeated error handling, logging, networking, validation, or formatting code that should be extracted to shared utilities.
- Require proper structured logging and error/warning reporting (no swallowed errors, no sensitive data in logs, remote crash reporting integrated).

## 1. Correctness & Bugs

- Logic errors, edge cases, race conditions, concurrency issues (coroutines/actors, main thread work).
- Error handling gaps: unhandled exceptions, force unwraps (`!!` in Kotlin, force unwrap in Swift), missing Result/sealed error types.
- Incorrect API usage, lifecycle issues (ViewModel leaks, missing cancellation).
- State management problems (impossible states, missing loading/empty/error states).

## 2. Security & Privacy

- Minimal permissions with runtime rationale and graceful degradation.
- Sensitive data only in Keychain/Keystore; no plaintext SharedPreferences/NSUserDefaults for secrets; no sensitive data in logs.
- HTTPS only, certificate pinning where appropriate, no hardcoded secrets.
- Strong crypto, Play Integrity / App Attest where relevant.
- Scoped storage, no non-resettable IDs.
- Compliance with Play User Data and App Store privacy policies (accurate privacy policy, Data safety form, ATT if tracking).
- No malware, deceptive behavior, or hidden features.

## 3. Performance & Technical Quality

- Startup <2s to interactive or progress indicator. Baseline Profiles (Android).
- ≥60 FPS, no jank. Efficient rendering (avoid unnecessary recompositions in Compose/SwiftUI).
- Battery and network efficient. Respect Doze/App Standby, background limits.
- App size minimized (AAB, feature delivery). R8/ProGuard enabled for release.
- No crashes or ANRs. Monitor via Android Vitals / Crashlytics. Aim <0.1–0.2% crash rate.
- Target latest API levels (Android 16+/API 36+, Xcode 26+ / iOS 26 SDK as of 2026).
- Tools: Android Vitals, pre-launch reports, Instruments, Macrobenchmark, StrictMode.

## 4. Maintainability, Naming & Code Reuse

- Modular feature-based architecture (not giant type-based folders). Layered (UI → Domain → Data) with unidirectional data flow.
- Unique, descriptive names: functions/variables clearly scoped (e.g., `AuthLogger`, `UserSessionRepository`, not shared `logger` or `data`).
- DRY: Extract common logic into unified shared utilities (central Logger, ErrorHandler, NetworkClient, validators). Flag duplicated blocks.
- Small focused files (<300–500 lines). Clear separation of concerns.
- Consistent error types (sealed classes/enums). No god functions.
- Documentation where non-obvious. Linting (SwiftLint, Android Lint, ktlint) clean.

## 5. Logging, Observability & Error Reporting

- Structured logging with stable event names (e.g., `auth.login_failed`), levels (debug/info/warn/error), and key-value context (session ID, screen, app version).
- Centralized logger that routes to console (debug) and remote (Crashlytics/Sentry) in release. No PII, tokens, or secrets.
- Non-fatal errors reported with custom keys/error codes for grouping.
- Breadcrumbs or session correlation so crashes include preceding events.
- Warnings for recoverable issues. Debug logging stripped from release builds.
- Analytics events consistent and documented.

## 6. Platform-Specific Checks

### Android
- Kotlin + Jetpack Compose + Material 3 preferred. Adaptive layouts for phones/tablets/foldables (edge-to-edge, no letterboxing).
- Touch targets ≥48dp, contrast ≥4.5:1, accessibility (content descriptions).
- Coroutines lifecycle-aware, no GlobalScope. Permissions runtime with rationale.
- R8 enabled, Baseline Profiles, reportFullyDrawn.
- Form factor tiers (Ready/Optimized/Differentiated) if targeting large screens.

### iOS / Xcode
- Swift + SwiftUI preferred. Follow Human Interface Guidelines.
- Modular structure (feature modules or SPM packages). Group by feature, not type.
- No force unwraps. Proper error handling with Result or throws.
- Accessibility, Dynamic Type, dark mode.
- App Store Review Guidelines compliance (completeness, no hidden features, accurate metadata, privacy labels, account deletion if applicable).
- Xcode 26+ builds, proper signing, TestFlight readiness.

## 7. Store Readiness

- Accurate store listing, screenshots, privacy policy, content rating, Data safety form.
- No crashes/bugs/placeholders. Demo account or demo mode if login required.
- Target SDK compliance. Phased rollouts recommended.
- Monetization (IAP) rules followed. No external payments for digital goods where prohibited.

## Output Format

**Summary**  
One paragraph on overall quality and key risks.

**Issues Found** (by severity)  
- **Critical**: Must fix before release (crashes, security holes, policy violations, swallowed errors that hide failures).  
- **Important**: Should fix (performance, maintainability, missing logging, name conflicts, duplicated logic).  
- **Minor**: Nice to improve (style, clarity).  

For each: location if possible, explanation of why it matters, specific suggested fix (with small code example when helpful).

**Positive Observations**  
What was done well.

**Suggestions for Improvement**  
Architectural or process recommendations (e.g., extract shared Logger utility, adopt error codes).

**Questions for the Author** (optional)

Always ask: "Would I be comfortable shipping this code?"
