# TODO - Step-by-Step Development Tasks for Nested Accessibility Identifiers SPM

This TODO outlines the structured, hierarchical development process for the Nested Accessibility Identifiers package for SwiftUI. Each step is broken down into clearly defined subtasks for incremental progress.

---

## Phase A — Package Scaffold

- [ ] Create SPM structure  
- [ ] Define platforms & swift tools version  
- [ ] Add DocC documentation bundle  

---

## Phase B — Core API (Environment + Modifier)

- [ ] Create Environment key: `accessibilityPrefix` with default `""`  
- [ ] Implement ID composition utility with deduplication logic  
- [ ] Implement `AccessibilityIdentifierModifier` ViewModifier to apply IDs, set environment, and mark containers  
- [ ] Create public View extensions:
  - [ ] `nestedAccessibilityIdentifier(_:)`
  - [ ] `a11yRoot(_:)`
- [ ] Optional: Add conditional debug print hook enabled by `DEBUG && NESTED_A11Y_DEBUG`  

---

## Phase C — Tests & Sample

- [ ] Write unit tests covering:
  - [ ] Composition utility (concatenation and dedupe rules)  
  - [ ] Modifier behavior (environment updates, container marking)  
- [ ] Write UI test template to verify:
  - [ ] Queries by composed IDs resolve correctly (ex: `login.registration.button`)  
  - [ ] Special handling of SwiftUI Button caveat is documented and tested  
- [ ] Optional: Develop example app that:
  - [ ] Demonstrates usage of root and nested accessibility IDs  
  - [ ] Shows real-world ID composition such as `login.signin.title`  

---

## Phase D — Documentation & Compliance

- [ ] Author DocC pages describing:
  - [ ] Benefits of nested accessibility IDs vs flat  
  - [ ] API usage and examples  
  - [ ] Limitations and caveats (e.g. Button accessibility label behavior)  
- [ ] Write README with a quick start guide, showing an end-to-end example  
- [ ] Add license file and configure GitHub Actions CI to:
  - [ ] Run build, tests and DocC generation  
  - [ ] Ensure green build on all PRs  

---

## Acceptance Test Checklist (to validate final implementation)

- [ ] Root + child + leaf IDs compose correctly (e.g., `login.registration.title`)  
- [ ] Duplicate tail components in child IDs deduplicate properly  
- [ ] Deep nesting (100+ levels) composes correct stable ID  
- [ ] Buttons receive correct `.accessibilityIdentifier` without altering VoiceOver label  
- [ ] All containers with nested children are marked `.accessibilityElement(children: .contain)`  

---

This TODO provides clear milestones for tracking progress and ensuring feature completeness and quality of the Nested Accessibility Identifiers package.