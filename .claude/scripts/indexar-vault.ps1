<#
  indexar-vault.ps1  —  painel de progresso do vault
  Automacao pura: le o frontmatter de todas as notas e agrega. Zero julgamento,
  zero token. Contar e comparar datas tem regra; regra que se escreve nao precisa
  de modelo.
  Regenera "90 - Sistema/91 - Painel de progresso.md" por completo.
#>
$ErrorActionPreference = 'Stop'

$vault = 'C:\Users\m242522\Desktop\study-documentation'
$saida = Join-Path $vault '90 - Sistema\91 - Painel de progresso.md'
$fila  = Join-Path $vault '.claude\fila-de-sessoes.jsonl'
$hoje  = Get-Date

function Get-Frontmatter([string]$path) {
  $fm = @{}
  try { $linhas = [System.IO.File]::ReadAllLines($path) } catch { return $fm }
  if ($linhas.Count -eq 0) { return $fm }
  if ($linhas[0].Trim() -ne '---') { return $fm }
  for ($i = 1; $i -lt $linhas.Count; $i++) {
    $l = $linhas[$i]
    if ($l.Trim() -eq '---') { break }
    if ($l -match '^\s*([^:]+):\s*(.*)$') {
      $k = $Matches[1].Trim().ToLower()
      $v = $Matches[2].Trim().Trim('"').Trim("'")
      $fm[$k] = $v
    }
  }
  return $fm
}

$niveis = [ordered]@{}
foreach ($n in 1..6) {
  $niveis["$n"] = [ordered]@{
    sessoes = 0; horas = 0.0; estudando = 0; aplicado = 0; naoiniciado = 0
    topTotal = 0; topFeitos = 0
    feitos  = (New-Object System.Collections.Generic.List[string])
    abertos = (New-Object System.Collections.Generic.List[string])
  }
}
$vencidas = New-Object System.Collections.Generic.List[string]

$arquivos = Get-ChildItem -LiteralPath $vault -Filter *.md -Recurse -File |
  Where-Object {
    $p = $_.FullName
    -not ($p.Contains('\.git\') -or $p.Contains('\.obsidian\') -or $p.Contains('\.claude\') -or $p.Contains('\90 - Sistema\'))
  }

foreach ($a in $arquivos) {
  $fm = Get-Frontmatter $a.FullName
  if ($fm.Count -eq 0) { continue }

  $rel = $a.FullName.Substring($vault.Length).TrimStart('\')

  # Nivel: primeiro do frontmatter (aceita "nivel" e "nível"), senao da pasta.
  $nv = $null
  foreach ($k in @('nivel', 'nível')) { if ($fm.ContainsKey($k) -and $fm[$k] -match '^\d$') { $nv = $fm[$k]; break } }
  if (-not $nv -and $rel -match '^\d0 - Nivel (\d)') { $nv = $Matches[1] }
  if (-not $nv -or -not $niveis.Contains($nv)) { continue }

  $tipo = if ($fm.ContainsKey('tipo')) { $fm['tipo'] } else { '' }

  # Checklist de topicos: so nas notas de nivel, nunca nos diarios.
  if ($a.Name -match '^\d0 - Nivel \d') {
    foreach ($l in [System.IO.File]::ReadAllLines($a.FullName)) {
      if ($l -match '^\s*-\s*\[( |x|X)\]\s*(.*)$') {
        $marcado = ($Matches[1] -ne ' ')
        $resto   = $Matches[2]
        if ($resto -match '^\*\*(.+?)\*\*') { $nome = $Matches[1] }
        else { $nome = ($resto -split ' . ')[0].Trim() }
        if ($nome.Length -gt 70) { $nome = $nome.Substring(0, 70) + '...' }
        $niveis[$nv].topTotal++
        if ($marcado) { $niveis[$nv].topFeitos++; $niveis[$nv].feitos.Add($nome) }
        else { $niveis[$nv].abertos.Add($nome) }
      }
    }
  }

  if ($tipo -eq 'diario') {
    if ($fm.ContainsKey('sessoes') -and $fm['sessoes'] -match '^\d+$') { $niveis[$nv].sessoes += [int]$fm['sessoes'] }
    if ($fm.ContainsKey('horas_acumuladas') -and $fm['horas_acumuladas'] -match '^[\d.,]+$') {
      $niveis[$nv].horas += [double]($fm['horas_acumuladas'] -replace ',', '.')
    }
  }

  if ($tipo -eq 'conceito') {
    switch -Regex (($fm['status'] + '')) {
      'aplicado'  { $niveis[$nv].aplicado++    ; break }
      'estudando' { $niveis[$nv].estudando++   ; break }
      default     { $niveis[$nv].naoiniciado++ }
    }
  }

  # Perecibilidade: niveis 5 e 6 exigem revisao trimestral do campo "verificado".
  if (($nv -eq '5' -or $nv -eq '6') -and $fm.ContainsKey('verificado') -and $fm['verificado']) {
    try {
      $d = [datetime]::ParseExact($fm['verificado'], 'yyyy-MM-dd', $null)
      $dias = [int]($hoje - $d).TotalDays
      if ($dias -gt 90) { $vencidas.Add("- [[$([System.IO.Path]::GetFileNameWithoutExtension($a.Name))]] — verificado ha $dias dias") }
    } catch { }
  }
}

$pend = 0
if (Test-Path -LiteralPath $fila) {
  foreach ($l in [System.IO.File]::ReadLines($fila)) {
    if ([string]::IsNullOrWhiteSpace($l)) { continue }
    if ($l -notmatch '"processado"') { $pend++ }
  }
}

$totEst = 0; $totApl = 0; $totSes = 0; $totHrs = 0.0
$totTopTotal = 0; $totTopFeitos = 0
foreach ($n in $niveis.Keys) {
  $totEst += $niveis[$n].estudando; $totApl += $niveis[$n].aplicado
  $totSes += $niveis[$n].sessoes;   $totHrs += $niveis[$n].horas
  $totTopTotal += $niveis[$n].topTotal; $totTopFeitos += $niveis[$n].topFeitos
}

$nomes = @{ '1'='Fundamentos'; '2'='Prompt engineering'; '3'='APIs e codigo'; '4'='RAG e memoria'; '5'='Agentes e arquitetura'; '6'='Producao e avaliacao' }

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('---')
[void]$sb.AppendLine('tipo: painel')
[void]$sb.AppendLine("atualizado: $($hoje.ToString('yyyy-MM-dd HH:mm'))")
[void]$sb.AppendLine('tags: [roadmap-ia, sistema, gerado]')
[void]$sb.AppendLine('---')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('# Painel de progresso')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('> [!warning] Nota gerada')
[void]$sb.AppendLine('> Regenerada por `.claude/scripts/indexar-vault.ps1` a partir do frontmatter das notas.')
[void]$sb.AppendLine('> Editar aqui nao adianta — edite o frontmatter da nota de origem. Ver [[90 - Como funciona a automacao]].')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('| Nivel | Topicos | Sessoes | Horas | Conceitos estudando | Conceitos aplicados |')
[void]$sb.AppendLine('|---|:-:|---:|---:|---:|---:|')
foreach ($n in $niveis.Keys) {
  $d = $niveis[$n]
  $tp = if ($d.topTotal -gt 0) { "$($d.topFeitos)/$($d.topTotal)" } else { '-' }
  [void]$sb.AppendLine("| $n — $($nomes[$n]) | $tp | $($d.sessoes) | $($d.horas.ToString('0.#')) | $($d.estudando) | $($d.aplicado) |")
}
[void]$sb.AppendLine("| **Total** | **$totTopFeitos/$totTopTotal** | **$totSes** | **$($totHrs.ToString('0.#'))** | **$totEst** | **$totApl** |")
[void]$sb.AppendLine('')

[void]$sb.AppendLine('## Avanco por topico')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('Detalhe apenas dos niveis em andamento. A lista completa esta na nota de cada nivel.')
[void]$sb.AppendLine('')
foreach ($n in $niveis.Keys) {
  $d = $niveis[$n]
  if ($d.topTotal -eq 0) { continue }
  $pct = [int](100 * $d.topFeitos / $d.topTotal)
  [void]$sb.AppendLine("### Nivel $n — $($nomes[$n]) · $($d.topFeitos)/$($d.topTotal) ($pct%)")
  [void]$sb.AppendLine('')
  if ($d.topFeitos -eq 0) {
    [void]$sb.AppendLine('Nao iniciado.')
    [void]$sb.AppendLine('')
    continue
  }
  [void]$sb.AppendLine('**Concluidos:**')
  [void]$sb.AppendLine('')
  foreach ($t in $d.feitos) { [void]$sb.AppendLine("- [x] $t") }
  [void]$sb.AppendLine('')
  if ($d.abertos.Count -gt 0) {
    [void]$sb.AppendLine("**Proximos** ($($d.abertos.Count) em aberto):")
    [void]$sb.AppendLine('')
    $i = 0
    foreach ($t in $d.abertos) {
      if ($i -ge 5) { break }
      [void]$sb.AppendLine("- [ ] $t")
      $i++
    }
    if ($d.abertos.Count -gt 5) { [void]$sb.AppendLine("- *(+$($d.abertos.Count - 5) na nota do nivel)*") }
    [void]$sb.AppendLine('')
  }
}

[void]$sb.AppendLine('## Sinal de alerta')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('Do Nivel 3 em diante a proporcao correta e 70% pratica / 30% estudo. Muitos conceitos em `estudando` e nenhum em `aplicado em projeto` significa que o estudo virou fim em si — ver [[00 - MOC Roadmap IA]].')
[void]$sb.AppendLine('')
if ($totEst -eq 0 -and $totApl -eq 0) {
  [void]$sb.AppendLine('**Estado:** nenhuma nota de conceito criada ainda. Nada a alertar.')
} elseif ($totApl -eq 0 -and $totEst -ge 3) {
  [void]$sb.AppendLine("**ALERTA:** $totEst conceitos em ``estudando`` e nenhum em ``aplicado em projeto``.")
} else {
  $r = if ($totApl -gt 0) { ($totEst / [double]$totApl).ToString('0.0') } else { 'n/a' }
  [void]$sb.AppendLine("**Estado:** $totEst estudando / $totApl aplicados (razao $r). Saudavel enquanto a razao cai com o tempo.")
}
[void]$sb.AppendLine('')

[void]$sb.AppendLine('## Notas vencidas (niveis 5 e 6, revisao trimestral)')
[void]$sb.AppendLine('')
if ($vencidas.Count -eq 0) {
  [void]$sb.AppendLine('Nenhuma nota com `verificado` acima de 90 dias.')
} else {
  foreach ($v in $vencidas) { [void]$sb.AppendLine($v) }
}
[void]$sb.AppendLine('')

[void]$sb.AppendLine('## Fila de sessoes')
[void]$sb.AppendLine('')
if ($pend -eq 0) {
  [void]$sb.AppendLine('Nenhuma sessao pendente de registro.')
} else {
  [void]$sb.AppendLine("**$pend sessao(oes) capturada(s) e ainda nao registrada(s).** Rode ``/registrar --fila`` para processar.")
}

$dirSaida = Split-Path -Parent $saida
if (-not (Test-Path -LiteralPath $dirSaida)) { New-Item -ItemType Directory -Path $dirSaida -Force | Out-Null }
$enc = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($saida, $sb.ToString(), $enc)

Write-Output "Painel atualizado: $totTopFeitos/$totTopTotal topicos, $totSes sessoes, $totEst estudando, $totApl aplicados, $pend na fila."
