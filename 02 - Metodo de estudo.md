---
tipo: metodo
criado: 2026-09-04
tags: [roadmap-ia, metodo]
---

# Método de estudo

Regras e modelos que valem para todos os níveis. Cada nível tem seu próprio diário; as convenções ficam aqui para não se repetirem seis vezes.

## Estrutura do vault

```
00 - MOC Roadmap IA          ← índice geral, comece aqui
01 - Conceitos transversais  ← os 5 conceitos que atravessam tudo
02 - Metodo de estudo        ← esta nota
70 - Leituras paralelas      ← livros
80 - Biblioteca de fontes    ← catálogo do que consumi + insights

10 - Nivel 1 - Fundamentos/
    ├── 10 - Nivel 1 - Fundamentos.md   ← conceitos, fontes, teste de saída
    ├── 10 - Diario - Nivel 1.md        ← sessões deste nível
    └── conceitos/                       ← notas atômicas, criadas sob demanda
(idem para os níveis 2 a 6)
```

## As três camadas de nota — e o que vai em cada uma

| Camada | O que registra | Quando escrever |
|---|---|---|
| **Nota do nível** | o mapa: conceitos, fontes, plano, teste de saída | já pronta; só marcar checkboxes |
| **Diário do nível** | o processo: o que entendi, o que travou, dúvidas | a cada sessão de estudo |
| **Nota de conceito** (`conceitos/`) | o entendimento consolidado de UM conceito | quando o conceito fecha |
| **Biblioteca de fontes** | o que a fonte trouxe + insights + ações | ao terminar uma fonte |

A distinção que importa: **diário é rascunho datado, nota de conceito é a versão limpa**. O diário nunca é reescrito — é histórico. A nota de conceito é revisada quantas vezes precisar.

## Regras do diário

- **Escreva com suas palavras, não com as da fonte.** Copiar a explicação derrota o propósito — o teste de saída de cada nível pergunta exatamente isso.
- **Registre as dúvidas, não só os acertos.** A dúvida de hoje é o roteiro de vídeo de amanhã.
- **Uma entrada por sessão**, mesmo curta. Sessão sem entrada é sessão que evapora.
- Preencher `sessoes` e `horas_acumuladas` no frontmatter do diário — é o dado que mostra se o cronograma do roadmap é realista para você.

## Modelo de entrada no diário

```markdown
## AAAA-MM-DD · [Conceito]

**Fonte consumida:**
**Tempo:** ~Xh

### O que entendi (minhas palavras)


### O que travou / dúvidas em aberto


### Ponte com o que já sei (estatística, trabalho, projetos)


### Próximo passo

- [ ]
```

## Quando criar nota de conceito

Não crie as notas de `conceitos/` antecipadamente — 60 notas vazias são ruído no grafo e peso morto. Crie quando o conceito **fecha**: você consegue explicá-lo sem consultar, e ele já tem pelo menos uma entrada de diário por trás.

Nome do arquivo: sem acento e sem cedilha (ex.: `Tokenizacao e BPE.md`, `Temperatura e amostragem.md`). É o que evita links quebrados no Obsidian.

Estrutura mínima de uma nota de conceito:

```markdown
---
tipo: conceito
nivel: X
status: estudando | aplicado em projeto
verificado: AAAA-MM-DD
---

# [Conceito]

## O que é

## Por que importa comercialmente

## Ponte com estatística

## Onde apareceu

- Diário: [[X0 - Diario - Nivel X]] (sessão de AAAA-MM-DD)
- Projeto: [[...]]
```

## Status e sinal de alerta

`não iniciado` → `estudando` → `aplicado em projeto`. Um conceito só chega ao terceiro estágio quando apareceu em código que rodou.

**Sinal de alerta:** muitos conceitos em `estudando` e nenhum em `aplicado` significa que o estudo virou fim em si. A partir do Nível 3 a proporção correta é 70% prática / 30% estudo.

## Ritmo de revisão

- Diários e notas de conceito dos **Níveis 1 e 2**: estáveis, não precisam revisão.
- **Níveis 5 e 6**: revisar `verificado` a cada trimestre — nomes de framework e ferramentas de eval mudaram várias vezes só em 2026.

## Dica de configuração do Obsidian

Configurações → Arquivos e links → **"Local padrão para novas notas" → "Na pasta do arquivo atual"**. Assim, ao criar uma nota estando dentro da pasta do Nível 1, ela nasce no lugar certo em vez de na raiz.
