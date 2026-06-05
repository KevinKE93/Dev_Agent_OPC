# Design Rubric

Use this rubric before customer-facing UI build.

## Required Checks

- Reference use: provided screenshots, apps, sites, Figma files, or competitor notes were inspected and translated into concrete patterns.
- Visual target: high-fidelity UI has a selected formal visual source; a
  confirmed brief or product-designer prose alone is not treated as build-ready.
- Information architecture: key screens, navigation, hierarchy, and primary actions are explicit.
- Interaction model: loading, empty, error, success, disabled, selected, long-content, and narrow-screen states are defined.
- Visual system: palette, typography, spacing, icon style, cards/panels, controls, and motion are specific enough to implement.
- Platform fit: iOS, Android, web, desktop, or embedded constraints are named when applicable.
- Accessibility: keyboard, focus, screen reader labels, touch targets, contrast, reduced motion, and error messaging are covered.
- Content realism: examples use realistic copy and data lengths, not filler text.
- Implementation handoff: `SCREEN_ACCEPTANCE.md` names the acceptance, monkey/exploratory, and visual comparison checks required before delivery, with screenshots only for exceptions or blocked flows.

## Blocking Issues

- No visual direction for customer-facing UI and no user delegation.
- High-fidelity build is about to start from a brief, sketch, local prototype,
  or prose-only design direction instead of a formal visual target.
- Generic AI aesthetic: purple-heavy gradients, decorative blobs, stock card grids, or nested card stacks that do not match the product.
- Missing mobile or narrow-screen behavior.
- Missing critical states such as loading, empty, error, permission denied, or long content.
- Visual requirements conflict with accessibility or platform conventions.
