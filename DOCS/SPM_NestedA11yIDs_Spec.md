
# Swift Package Spec — Nested Accessibility Identifiers for SwiftUI (Swift 6.0 / 5.9)

> Execution‑ready, dependency‑aware spec for an SPM package that brings **hierarchical (nested) accessibility identifiers** to SwiftUI via an Environment‑powered API, as described in the attached document.

---

## 1) Scope & Intent

**Objective (precise):**  
Deliver a Swift Package that provides a **zero‑boilerplate, nested accessibility identifier propagation** mechanism for SwiftUI views using an Environment key + ViewModifier/extension. The API must (a) generate stable, deduplicated dot‑separated paths (e.g., `login.registration.button`), (b) propagate the composed prefix down the view tree, (c) mark containers correctly for accessibility, and (d) remain test‑friendly.

**Primary deliverables:**
- SPM library target `NestedA11yIDs` (source + DocC)  
- Public SwiftUI API:  
  - `View.nestedAccessibilityIdentifier(_ id: String)` (container/leaf)  
  - `View.a11yRoot(_ id: String)` (root convenience)  
  - `EnvironmentValues.accessibilityPrefix: String` (public read‑only)  
- Reference examples app (optional target)  
- XCTest (+ UI tests template) verifying concatenation, propagation, deduplication, and button caveat coverage

**Success criteria:**
- Developers can set a single root ID at the top of a component; descendants automatically compose correct dot‑paths **without manual string concatenation**.
- No duplicate suffixes when the child repeats the parent’s tail (e.g., applying `"button"` inside `"…button"` keeps the final ID stable).
- All containers with nested elements are marked with `.accessibilityElement(children: .contain)`.
- API improves readability/maintainability vs. flat IDs; enables easy refactors and unique roots per embedding context.

**Constraints & assumptions:**
- **Swift tools:** 5.9+ (Swift 5.9 / Swift 6‑mode compatible)  
- **Platforms (minimum):** iOS 15, macOS 12, tvOS 15, watchOS 8 (SwiftUI availability)  
- **Limitations:** SwiftUI **Button** label still drives the *accessibility label/identifier for accessibility*, though the custom `.accessibilityIdentifier` remains queryable in UI tests—document and test this explicitly.

---

## 2) Structured, Hierarchical TODO Plan

### Phase A — Package Scaffold
1. **Create SPM structure**
2. **Define platforms & Swift version**
3. **Add DocC bundle**

### Phase B — Core API (Environment + Modifier)
4. **Environment key**
5. **Composition utility**
6. **ViewModifier `AccessibilityIdentifierModifier`**
7. **Public View extensions**
8. **(Optional) Debug print hook**

### Phase C — Tests & Sample
9. **Unit tests (XCTest)**
10. **UI tests template (XCUITest)**
11. **Example app (optional)**

### Phase D — Documentation & Compliance
12. **DocC pages**
13. **README**
14. **License & CI**

---

## 3) Execution Metadata (per subtask)

| # | Task | Priority | Effort | Tools/Deps | Acceptance Criteria |
|---|---|---|---|---|---|
| A1 | SPM skeleton | High | S | SwiftPM | `swift build` succeeds; targets present |
| A2 | Platforms & tools set | High | XS | SwiftPM | `Package.swift` exposes correct platforms |
| A3 | DocC bundle added | Med | S | DocC | `swift build` includes DocC bundle |
| B1 | Env key | High | XS | SwiftUI | `EnvironmentValues.accessibilityPrefix` exists & defaults to `""` |
| B2 | Composer util | High | S | N/A | Unit tests prove composition & dedupe rules |
| B3 | Modifier implementation | High | M | SwiftUI | Applies ID, sets env, marks `.contain` |
| B4 | Public extensions | High | XS | SwiftUI | `nestedAccessibilityIdentifier` & `a11yRoot` compile & work |
| B5 | Debug logging flag | Low | XS | N/A | Logs only under `DEBUG && NESTED_A11Y_DEBUG` |
| C1 | Unit tests | High | M | XCTest | ≥ 90% coverage of composer+modifier; container mark present |
| C2 | UI test template | Med | M | XCUITest | Queries by composed IDs succeed; Button caveat explained |
| C3 | Example app | Low | M | SwiftUI | Demo shows ids `login.signin.title` etc. |
| D1 | DocC | High | M | DocC | Guides include benefits & limitation sections |
| D2 | README | Med | S | Markdown | Quick start works end‑to‑end |
| D3 | License & CI | Med | S | GitHub Actions | CI green on PR; license included |

---

## 4) PRD‑Like Section

### Feature Description & Rationale
- **Feature:** Hierarchical IDs for SwiftUI views with automatic prefix propagation.  
- **Why:** Flat identifiers are brittle to refactors and error‑prone; nested IDs improve readability, avoid collisions, and centralize renames.

### Functional Requirements
1. **Composition**
2. **Container semantics**
3. **Diagnostics**
4. **Button caveat**

### Non‑Functional Requirements
- **Performance:** O(1) string ops per application  
- **Scalability:** Works with deeply nested trees  
- **Stability:** Deterministic id composition  
- **Security/Privacy:** No PII  
- **Accessibility compliance aid**

### User Interaction Flow
1. Annotate root container with `a11yRoot("login")`.  
2. Annotate subcontainers/leaves with `nestedAccessibilityIdentifier("…")`.  
3. Run UI tests: query `XCUIApplication().buttons["login.registration.button"]`.  
4. Inspect trees via Xcode Accessibility Inspector or Reveal.

### Edge Cases & Failure Scenarios
- **Empty child id:** Treat as no‑op  
- **Child id contains dots:** Allowed  
- **Duplicate tail:** Dedup  
- **Multiple roots:** Independent prefixes  
- **Buttons:** Custom ID visible in UI tests only

---

## 5) Package Layout

```
NestedA11yIDs/
├─ Package.swift
├─ Sources/
│  └─ NestedA11yIDs/
│     ├─ Environment/AccessibilityPrefixKey.swift
│     ├─ Internal/IDComposer.swift
│     ├─ Public/NestedAccessibilityModifier.swift
│     ├─ Public/View+NestedA11y.swift
│     └─ NestedA11yIDs.docc/
├─ Tests/
│  └─ NestedA11yIDsTests/
│     ├─ CompositionTests.swift
│     ├─ PropagationTests.swift
│     ├─ ContainerSemanticsTests.swift
│     └─ ButtonCaveatTests.swift
└─ Examples/
   └─ LoginDemo/
      └─ LoginScene.swift
```

---

## 6) Public API Sketch

```swift
public extension EnvironmentValues {
  @Entry var accessibilityPrefix: String
}

public extension View {
  func a11yRoot(_ id: String) -> some View
  func nestedAccessibilityIdentifier(_ id: String) -> some View
}
```

---

## 7) Acceptance Test Matrix

| Scenario | Setup | Expectation |
|---|---|---|
| Root + child + leaf | `VStack.a11yRoot("login")…` | Final id: `login.registration.title` |
| Dedup tail | Parent `"…button"`, child `"button"` | No duplicate suffix |
| Deep nesting | 100 levels | Correct composed ID |
| Button behavior | `Button("SIGN IN").nested("button")` | UI test finds id, VoiceOver label unaffected |
| Container semantics | Any container | `.accessibilityElement(children: .contain)` applied |
