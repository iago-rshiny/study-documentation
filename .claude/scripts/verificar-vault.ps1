<#
  verificar-vault.ps1  —  checagem de integridade do vault
  Automacao pura: sem LLM, sem token. Responde "o que foi escrito esta correto?"
  para as classes de erro que tem regra:
    1. wikilink apontando para nota inexistente
    2. nota que ninguem linka (orfa)
    3. entrada de diario sem ancora de topico (formato antigo)
  Sai com codigo 1 se encontrar problema, 0 se estiver limpo.
#>
$ErrorActionPreference = 'Stop'

$vault = 'C:\Users\m242522\Desktop\study-documentation'

$arquivos = Get-ChildItem -LiteralPath $vault -Filter *.md -Recurse -File |
  Where-Object {
    $p = $_.FullName
    -not ($p.Contains('\.git\') -or $p.Contains('\.obsidian\') -or $p.Contains('\.claude\'))
  }

# Mapa de notas existentes, por nome de arquivo sem extensao.
$existentes = @{}
foreach ($a in $arquivos) { $existentes[[System.IO.Path]::GetFileNameWithoutExtension($a.Name)] = $true }

$quebrados = New-Object System.Collections.Generic.List[string]
$citados   = @{}
$semTopico = New-Object System.Collections.Generic.List[string]

foreach ($a in $arquivos) {
  $nome  = [System.IO.Path]::GetFileNameWithoutExtension($a.Name)
  $texto = [System.IO.File]::ReadAllText($a.FullName)

  # Modelos dentro de bloco de codigo nao sao links — Obsidian nao os renderiza.
  $semCodigo = [regex]::Replace($texto, '(?s)```.*?```', '')
  $semCodigo = [regex]::Replace($semCodigo, '`[^`\r\n]*`', '')

  # 1 e 2 — wikilinks. Captura ate o primeiro ']', '|' ou '#'.
  foreach ($m in [regex]::Matches($semCodigo, '\[\[([^\]\|#]+)')) {
    $alvo = $m.Groups[1].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($alvo)) { continue }
    $citados[$alvo] = $true
    if (-not $existentes.ContainsKey($alvo)) {
      $quebrados.Add("  $nome  ->  [[$alvo]]")
    }
  }

  # 3 — entradas de diario precisam de ancora de topico.
  if ($nome -match 'Diario') {
    foreach ($m in [regex]::Matches($texto, '(?m)^##\s+(\d{4}-\d{2}-\d{2}[^\r\n]*)')) {
      $cab = $m.Groups[1].Value.Trim()
      $ini = $m.Index
      $fim = $texto.IndexOf("`n## ", $ini + 3)
      if ($fim -lt 0) { $fim = $texto.Length }
      $bloco = $texto.Substring($ini, $fim - $ini)
      if ($bloco -notmatch '\*\*T.pico:\*\*') {
        $semTopico.Add("  $nome  ->  $cab")
      }
    }
  }
}

# Orfas: notas que ninguem cita. O MOC e a raiz do grafo, nao conta.
$orfas = New-Object System.Collections.Generic.List[string]
foreach ($a in $arquivos) {
  $nome = [System.IO.Path]::GetFileNameWithoutExtension($a.Name)
  if ($nome -eq '00 - MOC Roadmap IA') { continue }
  if (-not $citados.ContainsKey($nome)) { $orfas.Add("  $nome") }
}

$problemas = $quebrados.Count + $semTopico.Count

Write-Output "Notas analisadas: $($arquivos.Count)"
Write-Output ''

Write-Output "[1] Links quebrados: $($quebrados.Count)"
if ($quebrados.Count -gt 0) { foreach ($q in $quebrados) { Write-Output $q } }
Write-Output ''

Write-Output "[2] Notas orfas (ninguem linka): $($orfas.Count)"
if ($orfas.Count -gt 0) { foreach ($o in $orfas) { Write-Output $o } }
Write-Output '    (orfa nao e erro: pode ser nota nova ainda nao referenciada)'
Write-Output ''

Write-Output "[3] Entradas de diario sem ancora de topico: $($semTopico.Count)"
if ($semTopico.Count -gt 0) { foreach ($s in $semTopico) { Write-Output $s } }
Write-Output ''

if ($problemas -eq 0) {
  Write-Output 'RESULTADO: sem problemas de integridade.'
  exit 0
} else {
  Write-Output "RESULTADO: $problemas problema(s) a corrigir."
  exit 1
}
