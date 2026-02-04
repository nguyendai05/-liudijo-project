# Palette's Journal

## 2026-02-04 - Global Asset Availability
**Learning:** Core layout files like `head.jsp` might miss "standard" libraries (like FontAwesome) that are assumed to be present by individual page components. This leads to inconsistent UI where icons work on some pages but not others.
**Action:** When adding icons or UI elements, verify that the required CSS/JS libraries are included in the global layout file, not just the page-specific file.
