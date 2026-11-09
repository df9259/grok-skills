---
name: apple-app-store-guidelines
description: Checks apps against current Apple App Store Review Guidelines (last updated October 16, 2026). Covers Safety including UGC/AI content moderation for nonconsensual imagery, Performance with hidden features (2.5.19) and creative assets (2.3.14), Business IAP rules, Design, Legal privacy and trafficking rules. Use for pre-submission review, metadata checks, and compliance guidance.
---

# Apple App Store Review Guidelines Skill

You are an expert reviewer for Apple App Store submissions. Use this skill to check apps, metadata, product pages, and features against the current App Review Guidelines (updated October 16, 2026). Always reference the official sources for the latest details: https://developer.apple.com/app-store/review/guidelines/

## Last Update
October 16, 2026. Key changes incorporated below. Upcoming: New age rating descriptors (Shared Location, Dating and Relationships) effective November 16, 2026; all apps must declare by January 12, 2027.

## Core Principles
- Safe, reliable, trustworthy experience for users.
- Apps reviewed for safety, performance, business model clarity, design quality, and legal compliance.
- Developers responsible for all code, including third-party SDKs.
- Living document; check Apple Developer News for updates.

## Before You Submit Checklist
- Test thoroughly for crashes/bugs on compatible devices (use XCTest, StoreKit Testing, TestFlight).
- Complete and accurate metadata (name ≤30 chars, description, keywords, screenshots/previews of actual app, category, age rating).
- Provide demo account or fully-featured demo mode + any needed resources in App Review notes.
- Enable backend services; live during review.
- Detailed App Review notes explaining non-obvious features, IAPs, and changes.
- Privacy Nutrition Label accurate; ATT implemented if tracking.
- In-app account deletion if accounts are created.
- Creative assets (2.3.14): Appropriate for all audiences, no prices/claims that are unverifiable.
- No hidden/dormant/undocumented features (2.5.19).

## Section 1: Safety
- **1.1 Objectionable Content**: No offensive, discriminatory, violent, sexual, or false content. No realistic violence targeting real groups. No facilitating illegal weapons or drugs.
- **1.2 User-Generated Content / AI Content Creation** (Updated Oct 16 2026): Apps that let users create, generate, upload, or share content (including AI tools) must:
  - Filter objectionable material, **explicitly including nonconsensual intimate imagery (AI-generated or otherwise)**.
  - Provide reporting mechanism, user blocking, and published contact information.
  - Proactively prevent and remove violations. Failure to implement safeguards or remediate after notice may violate Developer Code of Conduct → app removal and account termination.
- **1.3 Kids Category**: Parental gates for links/purchases. No third-party analytics/ads (limited exceptions with human review). No PII/device info to third parties. Age bands: 5 and under, 6-8, 9-11.
- **1.4 Physical Harm**: Accurate medical info; no unvalidated claims. No encouragement of drugs, reckless activities.
- **1.5–1.7**: Easy contact info. Secure data. Criminal reporting apps must involve law enforcement.

## Section 2: Performance
- **2.1 App Completeness**: Final version, tested on-device, no placeholders. Demo access. IAPs complete and functional.
- **2.2**: Use TestFlight for betas; no betas on App Store.
- **2.3 Accurate Metadata**: Specific descriptions. Screenshots show app in use. Honest age ratings. Unique name. **2.3.14 (New)**: Creative assets for product page headers and search results must be appropriate for all audiences and accurately represent the app. No specific or discounted prices; no unverifiable claims.
- **2.5 Software Requirements**: Public APIs only. No viruses. WebKit for browsing (with regional exceptions). 
  - **2.5.19 (New, Oct 16 2026)**: Do not include hidden, dormant, or undocumented features. App functionality must be clear to users and App Review. Attempting to hide features (e.g., via code obfuscation or other methods) is grounds for removal from the App Store and termination of the developer account. (Clarifies and moves former 2.3.1 policy.)

## Section 3: Business
- **3.1.1 In-App Purchase**: Required for unlocking digital content, features, subscriptions, consumables, non-consumables, auto-renewable subscriptions. Apple handles payments. Credits don't expire. Restore purchases. Loot boxes must disclose odds. NFT viewing ok; sales via IAP.
- **3.1.1(a) External Purchase Links** (Updated): StoreKit External Purchase Link Entitlements (Music Streaming folded in). Links only to permitted destinations; no misleading practices.
- **3.1.2 Subscriptions**: Ongoing value, clear terms, easy cancellation, multi-device. No scams or forced ratings.
- **3.1.3 Other Purchase Methods**: Allowed for reader apps, multiplatform services, enterprise, person-to-person, physical goods. Free companions ok.
- **3.1.5 Crypto**: Licensed exchanges only. No on-device mining. No ICOs without approval.
- **3.2**: No spam, chart manipulation, forced ratings, high-APR loans, unlicensed gambling.

## Section 4: Design
- **4.1 Copycats**: Original; no impersonation of Apple or others. No copying UI or names without permission.
- **4.2 Minimum Functionality**: Must be more than a website wrapper or template. Provide unique value. No spam variants (4.3).
- Follow Human Interface Guidelines. Support accessibility. Appropriate for age rating.

## Section 5: Legal
- **5.1 Privacy**: Privacy policy required. Consent for data collection. Minimize data. Purpose strings for sensitive APIs (camera, location, etc.). ATT for tracking. Account deletion in-app. Kids data special rules. Privacy manifests (PrivacyInfo.xcprivacy) for required reason APIs.
- **5**: Apps that facilitate human trafficking or exploitation of children (including CSAM) will be removed from the App Store **and blocked from alternative distribution**. (Strengthened Oct 16 2026.)
- Intellectual property: No unauthorized use of trademarks. Gaming/gambling must be licensed and geo-restricted.

## Upcoming Requirements
- Age rating content descriptors: Starting November 16, 2026, declare **Shared Location** and **Dating and Relationships**. All apps by January 12, 2027. Dating features → minimum 18+. Brazil has stricter local ratings.
- SDK: Apps must be built with Xcode 26+ and latest SDKs. Minimum deployment targets rising (check Upcoming Requirements page).

## Common Rejection Reasons
- 2.1 Completeness: Crashes, placeholders, incomplete info, no demo access.
- Metadata inaccuracies (screenshots, description, age rating).
- UGC moderation failures (especially now for AI/nonconsensual imagery).
- IAP violations (external payments for digital goods).
- Hidden features or bait-and-switch (2.5.19).
- Privacy issues (missing labels, no ATT, poor purpose strings).
- Minimum functionality or copycat design.

## Key Resources (from Get Started & Resources pages)
- App Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- App Store Connect Help: https://developer.apple.com/help/app-store-connect/
- Upcoming Requirements: https://developer.apple.com/news/upcoming-requirements/
- User Privacy and Data Use: https://developer.apple.com/app-store/user-privacy-and-data-use/
- Kids: https://developer.apple.com/kids/
- Submitting: https://developer.apple.com/app-store/submitting/
- TestFlight: https://developer.apple.com/testflight/
- Marketing Guidelines: https://developer.apple.com/app-store/marketing/guidelines/
- Business Models / IAP: https://developer.apple.com/in-app-purchase/ and https://developer.apple.com/app-store/subscriptions/

## How to Use This Skill
When reviewing an app or preparing a submission:
1. Identify app type (UGC/AI, Kids, Games, Subscription, etc.).
2. Run through the Before You Submit checklist.
3. Check relevant section rules, especially new 1.2, 2.3.14, 2.5.19.
4. Verify privacy labels, ATT, account deletion.
5. Flag any potential issues with severity and suggested fixes.
6. Recommend official documentation links for the developer.

Source: Distilled from Apple Developer pages (Get Started, Resources, App Review Guidelines, news posts as of November 2026). Always verify against the live guidelines as they are a living document.
