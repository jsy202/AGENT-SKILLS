# Usage: .\install.ps1 [claude|codex|antigravity|all]   (default: all targets whose root dir exists)
param([string]$Target = 'all')

$targets = @{
  claude      = "$HOME\.claude\skills"
  codex       = "$HOME\.codex\skills"
  antigravity = "$HOME\.gemini\antigravity\skills"  # unverified path, adjust if your install differs
}
$dsts = $targets.GetEnumerator() | Where-Object {
  ($Target -eq $_.Key) -or ($Target -eq 'all' -and (Test-Path (Split-Path $_.Value)))
} | ForEach-Object Value

$tmp = Join-Path $env:TEMP "agent-skills-$PID"
foreach ($line in Get-Content "$PSScriptRoot\skills.txt") {
  if ($line -match '^\s*(#|$)') { continue }
  $repo, $path = $line -split '\s+'
  $dir = Join-Path $tmp ($repo -replace '/', '__')
  if (-not (Test-Path $dir)) { git clone -q --depth 1 "https://github.com/$repo" $dir }
  $p = Join-Path $dir $path
  $skills = if (Test-Path "$p\SKILL.md") { Get-Item $p }
            else { Get-ChildItem $p -Directory | Where-Object { Test-Path "$($_.FullName)\SKILL.md" } }
  foreach ($d in $dsts) {
    New-Item -ItemType Directory -Force $d | Out-Null
    foreach ($s in $skills) { Copy-Item $s.FullName $d -Recurse -Force; "$($s.Name) -> $d" }
  }
}
Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
