<#
  capturar-sessao.ps1  —  hook SessionEnd
  Automacao pura: nao interpreta nada, nao chama modelo, nao custa token.
  Recebe o JSON do hook em stdin e enfileira UMA linha por sessao encerrada.
  Quem julga se aquilo virou aprendizado e o agente, depois, via /registrar --fila.
#>
$ErrorActionPreference = 'SilentlyContinue'

$vault = 'C:\Users\m242522\Desktop\study-documentation'
$fila  = Join-Path $vault '.claude\fila-de-sessoes.jsonl'

$raw = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($raw)) { exit 0 }
try { $ev = $raw | ConvertFrom-Json } catch { exit 0 }

$transcript = [string]$ev.transcript_path
if ([string]::IsNullOrWhiteSpace($transcript)) { exit 0 }
if (-not (Test-Path -LiteralPath $transcript)) { exit 0 }

# Filtro deterministico: sessao curta demais nao e sessao de estudo.
$linhas = 0
try { $linhas = @([System.IO.File]::ReadLines($transcript)).Count } catch { exit 0 }
if ($linhas -lt 6) { exit 0 }

$sid = [string]$ev.session_id
if ([string]::IsNullOrWhiteSpace($sid)) { $sid = [System.IO.Path]::GetFileNameWithoutExtension($transcript) }

# Deduplica: a mesma sessao nao entra duas vezes na fila.
if (Test-Path -LiteralPath $fila) {
  if (Select-String -LiteralPath $fila -SimpleMatch -Pattern $sid -Quiet) { exit 0 }
}

# Primeira mensagem do usuario: torna a fila legivel sem abrir o transcript.
$assunto = ''
try {
  foreach ($l in [System.IO.File]::ReadLines($transcript)) {
    if ($l -notmatch '"type"\s*:\s*"user"') { continue }
    $o = $null; try { $o = $l | ConvertFrom-Json } catch { continue }
    $c = $o.message.content
    if ($c -is [string]) { $assunto = $c }
    elseif ($c) { $assunto = [string]($c | Where-Object { $_.type -eq 'text' } | Select-Object -First 1).text }
    if (-not [string]::IsNullOrWhiteSpace($assunto)) { break }
  }
} catch { }
$assunto = ($assunto -replace '\s+', ' ').Trim()
if ($assunto.Length -gt 160) { $assunto = $assunto.Substring(0,160) + '...' }

$item = [ordered]@{
  session_id = $sid
  data       = (Get-Date -Format 'yyyy-MM-dd')
  hora       = (Get-Date -Format 'HH:mm')
  cwd        = [string]$ev.cwd
  transcript = $transcript
  eventos    = $linhas
  assunto    = $assunto
}

try {
  $dir = Split-Path -Parent $fila
  if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  $enc = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::AppendAllText($fila, ($item | ConvertTo-Json -Compress) + "`r`n", $enc)
} catch { }

exit 0
