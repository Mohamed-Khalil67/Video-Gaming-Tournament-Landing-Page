# Web Project Setup Guide

## Quickest way — use the script

```powershell
.\setup.ps1
```

That's it. The script handles everything: analysis, selection, install, copy, cleanup.

---

## What the script does (step by step)

```
Step 1 — Ask for a URL (optional)
         Fetches the page and detects which packages it uses

Step 2 — Show each available package
         Pre-selects detected ones, you confirm or skip each

Step 3 — Ask which fonts you need + which weights
         Pre-selects fonts detected from Google Fonts links

Step 4 — Summary — shows what will be installed, asks to confirm

Step 5 — Runs npm install (only selected packages)

Step 6 — Copies the files you need to vendor/ and fonts/
         Keeps only .min files and .woff2 fonts

Step 7 — Deletes node_modules, package-lock.json, package.json
         Project is fully offline after this step
```

---

## Available packages

### CSS / JS Libraries

| Package | What it gives you | When to use it |
|---|---|---|
| **Bootstrap 5** | Grid, components, utilities | Almost every project |
| **Font Awesome 6 Free** | 2000+ icons via `fas fa-*`, `fab fa-*` | When you need icons |
| **Bootstrap Icons** | 2000+ icons via `bi bi-*` | Lighter alternative to Font Awesome |
| **Animate.css** | Ready-made CSS entrance/exit animations | Hero sections, alerts |
| **AOS** | Scroll-triggered animations via `data-aos=""` | Elements that animate as you scroll |
| **Swiper** | Touch-friendly slider / carousel | Image sliders, testimonials |
| **GLightbox** | Lightbox for images and videos | Portfolios, galleries |

### Fonts (offline Google Fonts via @fontsource)

| Font | Style | Best for |
|---|---|---|
| **Orbitron** | Futuristic / geometric | Gaming, tech, sci-fi headings |
| **Inter** | Clean / neutral | Body text, UI, dashboards |
| **Roboto** | Modern / friendly | General purpose |
| **Open Sans** | Humanist / readable | Long-form text |
| **Poppins** | Geometric / bold | Landing pages, marketing |
| **Montserrat** | Strong / elegant | Headings, logos |
| **Raleway** | Thin / stylish | Fashion, luxury |
| **Nunito** | Rounded / soft | Apps, children's sites |
| **Lato** | Corporate / clean | Business, reports |
| **Oswald** | Condensed / strong | Posters, bold headings |
| **Playfair Display** | Serif / editorial | Blogs, editorial |
| **Merriweather** | Serif / readable | Long articles, books |
| **Ubuntu** | Technical / clean | Developer tools, tech |
| **Noto Sans** | Universal | Multi-language support |
| **Source Sans Pro** | Adobe / clean | Documentation |

**Weights:** 100 (Thin) · 200 · 300 (Light) · 400 (Regular) · 500 (Medium) · 600 (Semi-Bold) · 700 (Bold) · 800 · 900 (Black)

---

## What gets copied to your project

```
vendor/
├── bootstrap/
│   ├── css/bootstrap.min.css
│   └── js/bootstrap.bundle.min.js      ← includes Popper.js
├── fontawesome/
│   ├── css/all.min.css
│   └── webfonts/*.woff2
├── bootstrap-icons/
│   ├── css/bootstrap-icons.min.css
│   └── fonts/bootstrap-icons.woff2
├── animate/
│   └── animate.min.css
├── aos/
│   ├── aos.css
│   └── aos.js
├── swiper/
│   ├── swiper-bundle.min.css
│   └── swiper-bundle.min.js
└── glightbox/
    ├── glightbox.min.css
    └── glightbox.min.js

fonts/
├── orbitron/
│   └── orbitron-latin-{weight}-normal.woff2
└── inter/
    └── inter-latin-{weight}-normal.woff2
```

---

## How to link files in HTML

```html
<head>
  <!-- Bootstrap -->
  <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">

  <!-- Font Awesome (if installed) -->
  <link rel="stylesheet" href="vendor/fontawesome/css/all.min.css">

  <!-- Bootstrap Icons (if installed) -->
  <link rel="stylesheet" href="vendor/bootstrap-icons/css/bootstrap-icons.min.css">

  <!-- Animate.css (if installed) -->
  <link rel="stylesheet" href="vendor/animate/animate.min.css">

  <!-- AOS (if installed) -->
  <link rel="stylesheet" href="vendor/aos/aos.css">

  <!-- Swiper (if installed) -->
  <link rel="stylesheet" href="vendor/swiper/swiper-bundle.min.css">

  <!-- GLightbox (if installed) -->
  <link rel="stylesheet" href="vendor/glightbox/glightbox.min.css">

  <!-- Your CSS (always last) -->
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  ...

  <!-- Bootstrap JS (always before closing body) -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- AOS init (if installed) -->
  <script src="vendor/aos/aos.js"></script>
  <script>AOS.init();</script>

  <!-- Swiper (if installed) -->
  <script src="vendor/swiper/swiper-bundle.min.js"></script>

  <!-- GLightbox (if installed) -->
  <script src="vendor/glightbox/glightbox.min.js"></script>

  <!-- Your JS -->
  <script src="js/main.js"></script>
</body>
```

---

## How to use fonts in CSS

```css
/* 1. Declare the font */
@font-face {
  font-family: 'Orbitron';
  src: url('../fonts/orbitron/orbitron-latin-700-normal.woff2') format('woff2');
  font-weight: 700;
  font-display: swap;
}

/* 2. Use it */
h1 {
  font-family: 'Orbitron', sans-serif;
  font-weight: 700;
}
```

---

## Key rules to remember

| Rule | Why |
|---|---|
| Your `style.css` link goes **after** all vendor CSS | So your overrides win |
| `bootstrap.bundle.min.js` not `bootstrap.min.js` | The bundle includes Popper (needed for dropdowns, tooltips) |
| `woff2` only — no need for `woff` | All modern browsers support woff2 |
| `node_modules` is deleted after setup | Everything needed is already in `vendor/` and `fonts/` |
| Run `setup.ps1` again for any new project | It always starts clean |
