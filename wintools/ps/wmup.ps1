[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$zDelayMs = 100
$zDelayMaxMs = 300000
$zDelayRunMs = Get-Random -Minimum $zDelayMs -Minimum $zDelayMaxMs
$zCount = 0
$zAbort = $false
$zKeyAbort = [System.ConsoleKey]::Escape

Write-Host "Wake Me Up! -- press $($zKeyAbort) to terminate..."

while (-not $zAbort) {
  $zKeyPressed = $false

  while ([System.Console]::KeyAvailable) {
    $zKeyPressed = $true
    $zDelayRunMs = Get-Random -Minimum $zDelayMs -Minimum $zDelayMaxMs  # reset

    [System.ConsoleKeyInfo] $zKeyInfo = [System.Console]::ReadKey($true)
    Write-Host -NoNewLine "."

    if ($zKeyInfo.Key -eq $zKeyAbort) {
      $zAbort = $true
    }
  }

  if (-not ($zKeyPressed -or ($zDelayRunMs -gt 0))) {
    $zDelayRunMs = Get-Random -Minimum $zDelayMs -Minimum $zDelayMaxMs  # reset

    try {
      [System.Windows.Forms.SendKeys]::SendWait("{SCROLLLOCK}")
      $zCount = $zCount + 1
    }
    catch {
      Write-Host -NoNewLine "x"
    }
  }

  $zDelayRunMs = $zDelayRunMs - $zDelayMs
  Start-Sleep -Milliseconds $zDelayMs
}
