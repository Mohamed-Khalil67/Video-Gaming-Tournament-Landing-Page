# Bootstrap 5 — Most Used Classes Reference
> Quick cheat sheet for the GameArena project
> website to duplicate :  https://game-arena-theta.vercel.app/

---

## Layout

| Class | What it does |
|-------|-------------|
| `container` | Fixed-width centered wrapper |
| `container-fluid` | Full-width wrapper |
| `row` | Flex row — wraps columns |
| `col` | Auto-width column |
| `col-{n}` | Fixed column span (1–12) |
| `col-{bp}-{n}` | Responsive column (sm/md/lg/xl/xxl) |
| `g-{n}` | Gap between row columns (gutters) |
| `gy-{n}` | Vertical gap only |
| `gx-{n}` | Horizontal gap only |
| `offset-{n}` | Push column right by n columns |

### Common column patterns used in this project
```html
col-12 col-md-6          <!-- half width on md+ -->
col-12 col-lg-6          <!-- half width on lg+ -->
col-lg-4 col-md-6        <!-- 3-col on lg, 2-col on md -->
col-lg-3 col-md-6        <!-- 4-col on lg, 2-col on md -->
col-lg-5 / col-lg-7      <!-- asymmetric split (contact section) -->
```

---

## Flexbox Utilities

| Class | What it does |
|-------|-------------|
| `d-flex` | `display: flex` |
| `d-inline-flex` | `display: inline-flex` |
| `flex-column` | Stack children vertically |
| `flex-wrap` | Allow wrapping |
| `align-items-center` | Vertical center |
| `align-items-start/end` | Top / bottom align |
| `justify-content-center` | Horizontal center |
| `justify-content-between` | Space between |
| `justify-content-end` | Push to right |
| `gap-{n}` | Space between flex children (0–5) |
| `ms-auto` | Push element to right (margin-start auto) |
| `mx-auto` | Center horizontally |

---

## Spacing (margin / padding)

Pattern: `{property}{side}-{size}` — size is 0–5 or `auto`

| Property | Side |
|----------|------|
| `m` = margin | `t` top, `b` bottom, `s` start, `e` end, `x` horizontal, `y` vertical |
| `p` = padding | same sides |

```html
mt-3    <!-- margin-top -->
mb-5    <!-- margin-bottom -->
me-2    <!-- margin-end (right in LTR) -->
ms-3    <!-- margin-start (left in LTR) -->
px-3    <!-- padding left + right -->
py-5    <!-- padding top + bottom -->
p-3     <!-- padding all sides -->
```

---

## Display & Visibility

| Class | What it does |
|-------|-------------|
| `d-none` | Hide element |
| `d-block` | Show as block |
| `d-{bp}-none` | Hide at breakpoint and up |
| `d-{bp}-flex` | Show as flex at breakpoint and up |
| `d-lg-none` | Hide on lg+ (mobile-only elements) |
| `d-none d-lg-flex` | Hide on mobile, flex on lg+ (desktop-only) |

---

## Navbar

| Class | What it does |
|-------|-------------|
| `navbar` | Base navbar component |
| `navbar-expand-{bp}` | Expand at breakpoint (lg = expand on desktop) |
| `fixed-top` | Stick to top of viewport |
| `navbar-brand` | Logo / brand link |
| `navbar-toggler` | Hamburger button |
| `navbar-collapse` | Collapsible wrapper |
| `navbar-nav` | The `<ul>` of nav links |
| `nav-item` | Each `<li>` |
| `nav-link` | Each `<a>` |
| `collapse` | Hidden by default (toggled by JS) |

**Toggle wiring:**
```html
<button data-bs-toggle="collapse" data-bs-target="#navMenu">
<div class="collapse navbar-collapse" id="navMenu">
```

---

## Buttons

| Class | What it does |
|-------|-------------|
| `btn` | Base button |
| `btn-primary` | Filled primary color |
| `btn-outline-light` | Outlined, light border |
| `btn-outline-primary` | Outlined primary color |
| `btn-lg` | Large size |
| `btn-sm` | Small size |
| `w-100` | Full width button |
| `py-{n}` | Control vertical padding |
| `px-{n}` | Control horizontal padding |

---

## Position Utilities

| Class | What it does |
|-------|-------------|
| `position-relative` | `position: relative` |
| `position-absolute` | `position: absolute` |
| `top-0` | `top: 0` |
| `start-0` | `left: 0` |
| `bottom-0` | `bottom: 0` |
| `end-0` | `right: 0` |
| `translate-middle` | Center via transform |
| `translate-middle-y` | Center vertically via transform |
| `z-3` | z-index: 3 (Bootstrap z-index layers: 1, 2, 3) |

---

## Sizing

| Class | What it does |
|-------|-------------|
| `w-100` | Width 100% |
| `h-100` | Height 100% |
| `min-vh-100` | Min height = 100vh |
| `vw-100` | Width = 100vw |

---

## Colors & Backgrounds

| Class | What it does |
|-------|-------------|
| `bg-dark` | Dark background |
| `bg-primary` | Primary color background |
| `bg-opacity-50` | 50% opacity on bg (pair with bg-*) |
| `text-white` | White text |
| `text-primary` | Primary color text |
| `text-secondary` | Muted gray text |
| `text-muted` | Lighter muted text |

---

## Typography

| Class | What it does |
|-------|-------------|
| `text-center` | Center align text |
| `text-start` | Left align |
| `text-end` | Right align |
| `fw-bold` | `font-weight: 700` |
| `fw-light` | `font-weight: 300` |
| `fs-4` | Font size scale (1=largest, 6=smallest) |
| `small` | 0.875em text |
| `mb-0` | Remove bottom margin (common on `<p>`) |
| `list-unstyled` | Remove bullets and padding from `<ul>` |

---

## Borders & Rounded

| Class | What it does |
|-------|-------------|
| `border` | 1px solid border |
| `border-top` | Top border only |
| `border-secondary` | Secondary color border |
| `rounded` | Small border-radius |
| `rounded-3` | Medium border-radius |
| `rounded-4` | Large border-radius |
| `rounded-circle` | Perfect circle |

---

## Shadows

| Class | What it does |
|-------|-------------|
| `shadow` | Default box shadow |
| `shadow-sm` | Small shadow |
| `shadow-lg` | Large shadow |

---

## Forms

| Class | What it does |
|-------|-------------|
| `form-control` | Styled input / textarea |
| `form-select` | Styled `<select>` |
| `form-check` | Checkbox/radio wrapper |
| `form-check-input` | The input itself |
| `form-check-label` | The label |

---

## Badges

| Class | What it does |
|-------|-------------|
| `badge` | Base badge/pill |
| `bg-primary` / `bg-secondary` | Color variants |
| `rounded-pill` | Fully rounded badge |

---

## Images & Object Fit

| Class | What it does |
|-------|-------------|
| `img-fluid` | Responsive image (max-width: 100%) |
| `object-cover` | `object-fit: cover` |
| `rounded-4` | Rounded corners on image |

---

## Breakpoint Reference

| Prefix | Min-width | Typical use |
|--------|-----------|-------------|
| _(none)_ | < 576px | Mobile first |
| `sm` | ≥ 576px | Large phones |
| `md` | ≥ 768px | Tablets |
| `lg` | ≥ 992px | Desktops |
| `xl` | ≥ 1200px | Large desktops |
| `xxl` | ≥ 1400px | Wide screens |

---

## Icons quick ref
- **Font Awesome:** `<i class="fas fa-{name}">` (solid), `far` (regular), `fab` (brands)
- **Bootstrap Icons:** `<i class="bi bi-{name}">`

---

# Diagnostic — Hero & Navbar Sections

## Navbar — Score: 8.5/10

### What you got right
- `navbar navbar-expand-lg fixed-top` — correct classes, navbar expands at the right breakpoint
- `container` inside nav — proper centering
- Brand, toggler, collapse structure is textbook Bootstrap
- `data-bs-toggle="collapse"` and `data-bs-target="#navMenu"` correctly wired — burger will work
- `d-none d-lg-flex` for desktop icons — solid responsive pattern
- `d-lg-none` on mobile-only items — correct hide/show logic
- `btn btn-outline-light btn-sm` on Sign In — right component usage
- `gap-3`, `mx-auto` on `navbar-nav` — good flex spacing

### Issues to fix
1. **`<div>` inside `<ul>`** (line 43) — you put a `<div class="d-flex flex-column ...">` directly inside `<ul class="navbar-nav">`. A `<div>` is not a valid child of `<ul>`. Wrap the mobile-only items in a `<li>` or move the `<div>` outside the `<ul>`.
2. **`mt-3` on `navbar-nav`** — since the nav is `fixed-top`, this shifts items down on desktop. Use responsive spacing (`mt-3 mt-lg-0`) or handle only for mobile.
3. **`border-top border-secondary` on the inner div** — semantically fine, but overridden in CSS to `--color-border`, so `border-secondary` class is redundant. Minor.

---

## Hero — Score: 7.5/10

### What you got right
- `min-vh-100 pt-5 position-relative` on section — full viewport height with offset for fixed navbar
- `hero-overlay` with `position-absolute top-0 start-0 w-100 h-100` — correct overlay technique
- `position-relative z-3` on the container — content sits above overlay
- `row align-items-center gy-5` — vertical centering with responsive gap
- `col-12 col-md-6` for text / `col-12 col-lg-6` for image — valid responsive columns
- `d-flex flex-wrap gap-3` on CTA buttons — flexible button group
- `btn btn-primary btn-lg` and `btn btn-outline-light btn-lg` — correct pairing
- `bg-primary rounded-4 p-1` image frame — nice accent border trick
- `rounded-4 w-100 object-cover` on `<img>` — correct fit
- `position-absolute bottom-0 start-0 translate-middle-y` stat badge — correct absolute positioning pattern

### Issues to fix
1. **Missing closing `</div>` for `.container`** (line 109) — the `<section>` closes but the inner `<div class="container">` is never closed. This will break layout in later sections.
2. **`style="height: 400px"` inline style** (line 94) — move this to CSS as `.hero-img { height: 400px; }` to keep styling consistent with your `style.css` approach.
3. **`col-12 col-md-6` vs `col-12 col-lg-6`** — the text col breaks at `md` (768px) but the image col breaks at `lg` (992px). Between 768–991px the text is 6-wide but the image is still 12-wide (stacked). Likely unintentional — make both `col-md-6` or both `col-lg-6` to match.
4. **`bg-dark bg-opacity-50` on overlay** — Bootstrap's `bg-opacity` requires `bg-dark` to be set as a Bootstrap utility bg class. This works but you're overriding it in CSS (`background-color: var(--color-bg)`), so the overlay color may not match the design. Consider setting the overlay color directly in CSS instead.
5. **`.hero-content`, `.hero-tagline`, `.hero-badge` are empty in style.css** — you'll need to fill these in to match the target site's typography/spacing.

---

## Overall Progress
You have the HTML structure and Bootstrap scaffolding right. The main things holding you back are:
- One unclosed `<div>` in hero (structural bug)
- Invalid `<div>` inside `<ul>` in navbar (HTML validity)
- Inconsistent breakpoints on the two hero columns
- CSS placeholder rules not yet filled in
