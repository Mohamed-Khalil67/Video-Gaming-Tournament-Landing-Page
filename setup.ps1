# =============================================================
#  setup.ps1 — Interactive Web Project Setup
#  Analyzes a URL (optional) then installs + copies only what
#  you confirm, then cleans up node_modules automatically.
# =============================================================

Set-StrictMode -Off
$ErrorActionPreference = "SilentlyContinue"

# ── Helpers ───────────────────────────────────────────────────

function Write-Title  { param($t) Write-Host "`n$t" -ForegroundColor Cyan }
function Write-Ok     { param($t) Write-Host "  [OK]  $t" -ForegroundColor Green }
function Write-Warn   { param($t) Write-Host "  [!]   $t" -ForegroundColor Yellow }
function Write-Info   { param($t) Write-Host "        $t" -ForegroundColor Gray }
function Write-Found  { param($t) Write-Host "  [+]   $t" -ForegroundColor Magenta }

# ── Package catalogue ─────────────────────────────────────────
# Each entry: key, label, npm package, detect patterns (regex on raw HTML)

$catalogue = @(
  [PSCustomObject]@{
    Key      = "bootstrap"
    Label    = "Bootstrap 5  (CSS grid, components, utilities)"
    Npm      = "bootstrap"
    Patterns = @("bootstrap", 'class="[^"]*\b(container|navbar|btn|card|col-|row\b|d-flex|form-control)')
  },
  [PSCustomObject]@{
    Key      = "fontawesome"
    Label    = "Font Awesome 6 Free  (icons: fas, fab, far)"
    Npm      = "@fortawesome/fontawesome-free"
    Patterns = @("font.awesome", "fontawesome", 'class="[^"]*\b(fas|fab|far|fa-)\w')
  },
  [PSCustomObject]@{
    Key      = "bootstrap-icons"
    Label    = "Bootstrap Icons  (icons: bi-*)"
    Npm      = "bootstrap-icons"
    Patterns = @("bootstrap-icons", 'class="[^"]*\bbi-\w')
  },
  [PSCustomObject]@{
    Key      = "animate"
    Label    = "Animate.css  (CSS entrance/exit animations)"
    Npm      = "animate.css"
    Patterns = @("animate\.css", "animate__animated", 'class="[^"]*animate__')
  },
  [PSCustomObject]@{
    Key      = "aos"
    Label    = "AOS  (Animate On Scroll)"
    Npm      = "aos"
    Patterns = @("aos\.js", "aos\.css", 'data-aos=')
  },
  [PSCustomObject]@{
    Key      = "swiper"
    Label    = "Swiper  (touch slider / carousel)"
    Npm      = "swiper"
    Patterns = @("swiper", 'class="[^"]*\bswiper\b')
  },
  [PSCustomObject]@{
    Key      = "glightbox"
    Label    = "GLightbox  (image / video lightbox)"
    Npm      = "glightbox"
    Patterns = @("glightbox")
  }
)

# ── Supported @fontsource fonts ───────────────────────────────

$fontMap = @{
  "Orbitron"    = "orbitron"
  "Inter"       = "inter"
  "Roboto"      = "roboto"
  "Open Sans"   = "open-sans"
  "Poppins"     = "poppins"
  "Montserrat"  = "montserrat"
  "Raleway"     = "raleway"
  "Nunito"      = "nunito"
  "Lato"        = "lato"
  "Oswald"      = "oswald"
  "Source Sans Pro" = "source-sans-pro"
  "Ubuntu"      = "ubuntu"
  "Noto Sans"   = "noto-sans"
  "Playfair Display" = "playfair-display"
  "Merriweather" = "merriweather"
}

# ── URL analysis ──────────────────────────────────────────────

function Analyze-Url {
  param([string]$url)

  Write-Title "Fetching $url ..."

  try {
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 15
    $html = $response.Content
  } catch {
    Write-Warn "Could not fetch URL. Skipping analysis."
    return @{ Packages = @(); Fonts = @() }
  }

  Write-Ok "Page fetched  ($([math]::Round($html.Length / 1kb, 1)) KB)"

  $detected  = @()
  $detFonts  = @()

  # Check each package's patterns against the HTML
  foreach ($pkg in $catalogue) {
    foreach ($pat in $pkg.Patterns) {
      if ($html -match $pat) {
        $detected += $pkg.Key
        break
      }
    }
  }

  # Google Fonts — extract family names from link tags
  $gfMatches = [regex]::Matches($html, 'fonts\.googleapis\.com/css[^"'']+')
  foreach ($m in $gfMatches) {
    $raw = [System.Uri]::UnescapeDataString($m.Value)
    $familyMatches = [regex]::Matches($raw, 'family=([A-Za-z0-9+]+)')
    foreach ($f in $familyMatches) {
      $name = $f.Groups[1].Value -replace '\+', ' '
      if ($fontMap.ContainsKey($name) -and $detFonts -notcontains $name) {
        $detFonts += $name
      }
    }
  }

  return @{ Packages = $detected; Fonts = $detFonts }
}

# ── Copy helpers ──────────────────────────────────────────────

function Copy-Bootstrap {
  New-Item -ItemType Directory -Force -Path "vendor\bootstrap\css", "vendor\bootstrap\js" | Out-Null
  Copy-Item "node_modules\bootstrap\dist\css\bootstrap.min.css"      "vendor\bootstrap\css\"
  Copy-Item "node_modules\bootstrap\dist\js\bootstrap.bundle.min.js" "vendor\bootstrap\js\"
  Write-Ok "Bootstrap copied → vendor\bootstrap\"
}

function Copy-FontAwesome {
  New-Item -ItemType Directory -Force -Path "vendor\fontawesome\css", "vendor\fontawesome\webfonts" | Out-Null
  Copy-Item "node_modules\@fortawesome\fontawesome-free\css\all.min.css" "vendor\fontawesome\css\"
  Copy-Item "node_modules\@fortawesome\fontawesome-free\webfonts\*.woff2" "vendor\fontawesome\webfonts\"
  Write-Ok "Font Awesome copied → vendor\fontawesome\"
}

function Copy-BootstrapIcons {
  New-Item -ItemType Directory -Force -Path "vendor\bootstrap-icons\css", "vendor\bootstrap-icons\fonts" | Out-Null
  Copy-Item "node_modules\bootstrap-icons\font\bootstrap-icons.min.css" "vendor\bootstrap-icons\css\"
  Copy-Item "node_modules\bootstrap-icons\font\fonts\*.woff2"           "vendor\bootstrap-icons\fonts\"
  Write-Ok "Bootstrap Icons copied → vendor\bootstrap-icons\"
}

function Copy-Animate {
  New-Item -ItemType Directory -Force -Path "vendor\animate" | Out-Null
  Copy-Item "node_modules\animate.css\animate.min.css" "vendor\animate\"
  Write-Ok "Animate.css copied → vendor\animate\"
}

function Copy-AOS {
  New-Item -ItemType Directory -Force -Path "vendor\aos" | Out-Null
  Copy-Item "node_modules\aos\dist\aos.css"     "vendor\aos\"
  Copy-Item "node_modules\aos\dist\aos.js"      "vendor\aos\"
  Write-Ok "AOS copied → vendor\aos\"
}

function Copy-Swiper {
  New-Item -ItemType Directory -Force -Path "vendor\swiper" | Out-Null
  Copy-Item "node_modules\swiper\swiper-bundle.min.css" "vendor\swiper\"
  Copy-Item "node_modules\swiper\swiper-bundle.min.js"  "vendor\swiper\"
  Write-Ok "Swiper copied → vendor\swiper\"
}

function Copy-GLightbox {
  New-Item -ItemType Directory -Force -Path "vendor\glightbox" | Out-Null
  Copy-Item "node_modules\glightbox\dist\css\glightbox.min.css" "vendor\glightbox\"
  Copy-Item "node_modules\glightbox\dist\js\glightbox.min.js"   "vendor\glightbox\"
  Write-Ok "GLightbox copied → vendor\glightbox\"
}

function Copy-Font {
  param([string]$displayName, [string]$npmSlug, [string[]]$weights)

  $dest = "fonts\$npmSlug"
  New-Item -ItemType Directory -Force -Path $dest | Out-Null

  $srcBase = "node_modules\@fontsource\$npmSlug\files"

  if (-not (Test-Path $srcBase)) {
    Write-Warn "Font files not found for $npmSlug"
    return
  }

  if ($weights.Count -eq 0) {
    # Default: copy 400 normal latin woff2 only
    $weights = @("400")
  }

  foreach ($w in $weights) {
    $file = "$srcBase\$npmSlug-latin-$w-normal.woff2"
    if (Test-Path $file) {
      Copy-Item $file $dest
    } else {
      Write-Warn "Weight $w not found for $npmSlug, skipping."
    }
  }

  Write-Ok "$displayName ($( $weights -join ', ' )) → $dest\"
}

# ── Ask yes/no helper ─────────────────────────────────────────

function Ask-YesNo {
  param([string]$question, [bool]$default = $true)
  $hint = if ($default) { "[Y/n]" } else { "[y/N]" }
  $ans = Read-Host "$question $hint"
  if ($ans -eq "") { return $default }
  return $ans -match '^[Yy]'
}

# ── Ask for weights helper ────────────────────────────────────

function Ask-Weights {
  param([string]$fontName)
  Write-Info "Common weights: 100 200 300 400 500 600 700 800 900"
  $raw = Read-Host "    Weights for $fontName (space-separated, Enter = 400 700)"
  if ($raw.Trim() -eq "") { return @("400", "700") }
  return ($raw.Trim() -split '\s+')
}

# ══════════════════════════════════════════════════════════════
#  MAIN
# ══════════════════════════════════════════════════════════════

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Web Project Setup Script" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# ── Step 1: Optional URL analysis ────────────────────────────

Write-Title "STEP 1 — Website Analysis (optional)"
$url = Read-Host "Enter a website URL to analyze (or press Enter to skip)"

$suggested = @{ Packages = @(); Fonts = @() }

if ($url.Trim() -ne "") {
  if ($url -notmatch '^https?://') { $url = "https://$url" }
  $suggested = Analyze-Url -url $url

  if ($suggested.Packages.Count -gt 0 -or $suggested.Fonts.Count -gt 0) {
    Write-Title "Detected on the page:"
    foreach ($k in $suggested.Packages) {
      $pkg = $catalogue | Where-Object { $_.Key -eq $k }
      Write-Found $pkg.Label
    }
    foreach ($f in $suggested.Fonts) {
      Write-Found "Google Font: $f  (@fontsource/$($fontMap[$f]))"
    }
  } else {
    Write-Warn "Nothing detected automatically. You can still pick manually below."
  }
}

# ── Step 2: Package selection ─────────────────────────────────

Write-Title "STEP 2 — Confirm packages to install"
Write-Info "(Suggested packages are pre-selected. You can add or skip any.)"

$toInstall  = @()   # npm package names
$toCopy     = @()   # internal keys

foreach ($pkg in $catalogue) {
  $isSuggested = $suggested.Packages -contains $pkg.Key
  $label = if ($isSuggested) { "$($pkg.Label)  ← detected" } else { $pkg.Label }
  if (Ask-YesNo "  Install $label ?" $isSuggested) {
    $toInstall += $pkg.Npm
    $toCopy    += $pkg.Key
  }
}

# ── Step 3: Font selection ────────────────────────────────────

Write-Title "STEP 3 — Fonts  (@fontsource — offline Google Fonts)"

$fontsToInstall = @()   # @{name; slug; weights}

# Pre-select detected fonts
foreach ($name in $suggested.Fonts) {
  $slug = $fontMap[$name]
  Write-Found "$name detected on page"
  if (Ask-YesNo "  Install $name (@fontsource/$slug) ?" $true) {
    $weights = Ask-Weights -fontName $name
    $fontsToInstall += @{ Name = $name; Slug = $slug; Weights = $weights }
    $toInstall += "@fontsource/$slug"
  }
}

# Let user add more fonts manually
Write-Info ""
Write-Info "Available fonts you can add:"
$i = 1
$fontKeys = $fontMap.Keys | Sort-Object
foreach ($k in $fontKeys) {
  $already = $fontsToInstall | Where-Object { $_.Name -eq $k }
  if (-not $already) {
    Write-Info "  $i. $k"
    $i++
  }
}

$extra = Read-Host "`n  Type font names to add (comma-separated) or press Enter to skip"
if ($extra.Trim() -ne "") {
  $extraNames = $extra -split ',' | ForEach-Object { $_.Trim() }
  foreach ($name in $extraNames) {
    if ($fontMap.ContainsKey($name)) {
      $slug = $fontMap[$name]
      $weights = Ask-Weights -fontName $name
      $fontsToInstall += @{ Name = $name; Slug = $slug; Weights = $weights }
      $toInstall += "@fontsource/$slug"
    } else {
      Write-Warn "'$name' not in catalogue. Skipping."
    }
  }
}

# ── Step 4: Summary + confirm ─────────────────────────────────

Write-Title "STEP 4 — Summary"

if ($toInstall.Count -eq 0) {
  Write-Warn "Nothing selected. Exiting."
  exit
}

Write-Info "Will install:"
foreach ($p in ($toInstall | Select-Object -Unique)) { Write-Info "  npm install $p" }

if (-not (Ask-YesNo "`nProceed?" $true)) {
  Write-Warn "Cancelled."
  exit
}

# ── Step 5: npm init + install ────────────────────────────────

Write-Title "STEP 5 — Installing packages ..."

if (-not (Test-Path "package.json")) { npm init -y | Out-Null }

$uniquePackages = $toInstall | Select-Object -Unique
npm install @($uniquePackages)

# ── Step 6: Copy to vendor/ and fonts/ ───────────────────────

Write-Title "STEP 6 — Copying files to vendor/ and fonts/ ..."

if ($toCopy -contains "bootstrap")       { Copy-Bootstrap }
if ($toCopy -contains "fontawesome")     { Copy-FontAwesome }
if ($toCopy -contains "bootstrap-icons") { Copy-BootstrapIcons }
if ($toCopy -contains "animate")         { Copy-Animate }
if ($toCopy -contains "aos")             { Copy-AOS }
if ($toCopy -contains "swiper")          { Copy-Swiper }
if ($toCopy -contains "glightbox")       { Copy-GLightbox }

foreach ($f in $fontsToInstall) {
  Copy-Font -displayName $f.Name -npmSlug $f.Slug -weights $f.Weights
}

# ── Step 7: Cleanup ───────────────────────────────────────────

Write-Title "STEP 7 — Cleaning up ..."

if (Test-Path "node_modules")    { Remove-Item -Recurse -Force "node_modules";    Write-Ok "node_modules removed" }
if (Test-Path "package-lock.json") { Remove-Item -Force "package-lock.json";      Write-Ok "package-lock.json removed" }
if (Test-Path "package.json")    { Remove-Item -Force "package.json";             Write-Ok "package.json removed" }

# ── Done ──────────────────────────────────────────────────────

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "   Setup complete. Project is offline-ready." -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
