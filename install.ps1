# Usage: .\install.ps1 [claude|codex|antigravity|all]   (default: all targets whose root dir exists)
param([string]$Target = 'all')

$targets = @{
  claude      = "$HOME\.claude\skills"
  codex       = "$HOME\.codex\skills"
  antigravity = "$HOME\.gemini\antigravity\skills"  # unverified path, adjust if your install differs
}
$src = Join-Path $PSScriptRoot 'skills'

foreach ($name in $targets.Keys) {
  if ($Target -ne 'all' -and $Target -ne $name) { continue }
  $dst = $targets[$name]
  if ($Target -eq 'all' -and -not (Test-Path (Split-Path $dst))) { continue }
  New-Item -ItemType Directory -Force $dst | Out-Null
  Copy-Item "$src\*" $dst -Recurse -Force
  "installed -> $dst"
}
