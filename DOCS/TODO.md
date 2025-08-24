# TODO - Step-by-Step Development Tasks for Nested Accessibility Identifiers SPM

This TODO outlines the structured, hierarchical development process for the Nested Accessibility Identifiers package for SwiftUI. Each step is broken down into clearly defined subtasks for incremental progress.

---

## Phase A — Package Scaffold

- [x] Create SPM structure  
- [x] Define platforms & swift tools version  
- [x] Add DocC documentation bundle  

---

## Phase B — Core API (Environment + Modifier)

- [x] Create Environment key: `accessibilityPrefix` with default `""`  
- [x] Implement ID composition utility with deduplication logic  
- [x] Implement `AccessibilityIdentifierModifier` ViewModifier to apply IDs, set environment, and mark containers  
- [x] Create public View extensions:
  - [x] `nestedAccessibilityIdentifier(_:)`
  - [x] `a11yRoot(_:)`
- [x] Optional: Add conditional debug print hook enabled by `DEBUG && NESTED_A11Y_DEBUG`  

---

## Phase C — Tests & Sample

- [x] Write unit tests covering:
  - [x] Composition utility (concatenation and dedupe rules)  
  - [x] Modifier behavior (environment updates, container marking)  
- [x] Write UI test template to verify:
  - [x] Queries by composed IDs resolve correctly (ex: `login.registration.button`)  
  - [x] Special handling of SwiftUI Button caveat is documented and tested  
- [x] Optional: Develop example app that:
  - [x] Demonstrates usage of root and nested accessibility IDs  
  - [x] Shows real-world ID composition such as `login.signin.title`  

---

## Phase D — Documentation & Compliance

- [x] Author DocC pages describing:
  - [x] Benefits of nested accessibility IDs vs flat  
  - [x] API usage and examples  
  - [x] Limitations and caveats (e.g. Button accessibility label behavior)  
- [x] Write README with a quick start guide, showing an end-to-end example  
- [x] Add license file and configure GitHub Actions CI to:
  - [x] Run build, tests and DocC generation  
  - [x] Ensure green build on all PRs  

---

## Acceptance Test Checklist (to validate final implementation)

- [x] Root + child + leaf IDs compose correctly (e.g., `login.registration.title`)  
- [x] Duplicate tail components in child IDs deduplicate properly  
- [x] Deep nesting (100+ levels) composes correct stable ID  
- [x] Buttons receive correct `.accessibilityIdentifier` without altering VoiceOver label  
- [x] All containers with nested children are marked `.accessibilityElement(children: .contain)`  

---

This TODO provides clear milestones for tracking progress and ensuring feature completeness and quality of the Nested Accessibility Identifiers package.