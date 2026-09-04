<#
  fechar-fila.ps1  —  marca uma sessao da fila como processada.
  Deterministico. Chamado pelo agente depois de escrever no vault.
#>
param([Parameter(Mandatory=$true)][string]$SessionId)
$ErrorActionPreference = 'Stop'

$fila = 'C:\Users\m242522\Desktop\study-documentation\.claude\fila-de-sessoes.jsonl'
if (-not (Test-Path -LiteralPath $fila)) { Write-Output 'Fila vazia.'; exit 0 }

$hoje = Get-Date -Format 'yyyy-MM-dd'
$saida = New-Object System.Collections.Generic.List[string]
$achou = $false

foreach ($l in [System.IO.File]::ReadLines($fila)) {
  if ([string]::IsNullOrWhiteSpace($l)) { continue }
  $o = $null; try { $o = $l | ConvertFrom-Json } catch { $saida.Add($l); continue }
  if ($o.session_id -eq $SessionId -and -not $o.processado) {
    $o | Add-Member -NotePropertyName processado -NotePropertyValue $hoje -Force
    $achou = $true
    $saida.Add(($o | ConvertTo-Json -Compress))
  } else {
    $saida.Add($l)
  }
}

$enc = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($fila, ($saida -join "`r`n") + "`r`n", $enc)
if ($achou) { Write-Output "Fechado: $SessionId" } else { Write-Output "Nao encontrado ou ja processado: $SessionId" }
