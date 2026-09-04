---
tipo: MOC
criado: 2026-08-28
verificado: 2026-08-28
tags: [roadmap-ia, moc]
---

# Roadmap de aprendizado — IA para automação de PMEs

Mapa de conteúdo do roadmap completo. Cada nível tem nota própria; os conceitos que atravessam todos os níveis estão em [[01 - Conceitos transversais]].

## Princípios

1. **Serviço primeiro, conteúdo como consequência.** Casos reais entregues geram a pauta; o canal vem depois.
2. **Aprender-aplicar.** Cada nível termina com algo funcional. Nível sem projeto rodando não está concluído.
3. **Medir é o diferencial.** Quase ninguém neste mercado sabe provar que a automação funciona. A estatística é o argumento de venda ("eu provo o ROI com dados").
4. **Do Nível 3 em diante a proporção inverte:** 70% prática / 30% estudo. Documentação vira material de consulta durante a construção, não leitura prévia.

## Os seis níveis

Cada nível é uma pasta com a nota de conteúdo, o diário de sessões e uma subpasta `conceitos/` para notas atômicas criadas sob demanda. Método e modelos em [[02 - Metodo de estudo]].

| Nível | Conteúdo | Diário | Duração | Perecibilidade |
|---|---|---|---|---|
| 1 — Fundamentos | [[10 - Nivel 1 - Fundamentos]] | [[10 - Diario - Nivel 1]] | 2-4 semanas | Baixa |
| 2 — Prompt engineering | [[20 - Nivel 2 - Prompt engineering]] | [[20 - Diario - Nivel 2]] | 2-3 semanas | Baixa-média |
| 3 — APIs e código | [[30 - Nivel 3 - APIs e codigo]] | [[30 - Diario - Nivel 3]] | 4-6 semanas | Média |
| 4 — RAG e memória | [[40 - Nivel 4 - RAG e memoria]] | [[40 - Diario - Nivel 4]] | 3-4 semanas | Média |
| 5 — Agentes e arquitetura | [[50 - Nivel 5 - Agentes e arquitetura]] | [[50 - Diario - Nivel 5]] | 6-8 semanas | **Alta — rever/trimestre** |
| 6 — Produção e avaliação | [[60 - Nivel 6 - Producao e avaliacao]] | [[60 - Diario - Nivel 6]] | Contínuo | **Alta — rever/trimestre** |

Total realista: **6-8 meses até nível profissional**, estudando em paralelo com os primeiros projetos (os projetos são o estudo a partir do Nível 3).

**Em paralelo aos níveis:** [[70 - Leituras paralelas]] — Ousterhout, Pragmatic Programmer, Brooks, DDD, Kent Beck. O contrapeso que não envelhece: a stack de IA muda por trimestre; design de software não.

## Correspondência com os ciclos aprender-aplicar

| Ciclo | Projeto | Nível coberto |
|---|---|---|
| 1 | Script que resume CSV em linguagem natural (Olist) | 1 → 3 |
| 2 | Classificador de e-mails/mensagens com saída JSON | 2 → 3 |
| 3 | Automação ponta a ponta com n8n — 1º item de portfólio | 5 (low-code) |
| 4 | Refazer o bot do ciclo 3 em Python com function calling | 3 → 5 |
| 5 | Assistente que responde sobre PDFs | 4 |
| 6 | Loop ReAct do zero + avaliação com taxa de acerto medida | 5 → 6 |

## Cronograma de negócio

- **Meses 0-3:** fundamentos + prompt engineering + n8n. Primeira automação real funcionando (idealmente no trabalho atual).
- **Meses 3-6:** Python/APIs + 2-3 projetos para negócios locais quase de graça. Começa a postar no LinkedIn.
- **Meses 6-10:** RAG + agentes. Primeiros clientes pagantes. Lança o YouTube com "For Business" primeiro (é o que converte), usando os casos como pauta.
- **Meses 10-14:** arquitetura avançada + evals. "For Nerds" entra aqui. Precificação recorrente estruturada.
- **Ano 2:** produtização e escala.

## Notas de apoio

- [[02 - Metodo de estudo]] — estrutura do vault, regras do diário, modelo de entrada, quando criar nota de conceito.
- [[01 - Conceitos transversais]] — os 5 conceitos que atravessam todos os níveis.
- [[70 - Leituras paralelas]] — livros lidos em paralelo.
- [[80 - Biblioteca de fontes]] — catálogo do que consumi, com insights e links para os níveis.

## Convenções do vault

- **Status por conceito:** `não iniciado` → `estudando` → `aplicado em projeto`. Um conceito só vira `aplicado em projeto` quando apareceu em código que rodou.
- **Sinal de alerta:** muitas notas em `estudando` e nenhuma em `aplicado` = o estudo virou fim em si.
- **Campo `verificado`:** data da última checagem de validade. Obrigatório nos Níveis 5 e 6.
- Em cada conceito, registrar o **"por que importa comercialmente"** — é o que transforma nota de estudo em roteiro de conteúdo depois.
