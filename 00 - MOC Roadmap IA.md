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

| Nível | Nota | Duração | Perecibilidade |
|---|---|---|---|
| 1 — Fundamentos conceituais | [[10 - Nível 1 - Fundamentos]] | 2-4 semanas | Baixa (estável por anos) |
| 2 — Prompt engineering | [[20 - Nível 2 - Prompt engineering]] | 2-3 semanas, contínuo | Baixa-média |
| 3 — APIs e código | [[30 - Nível 3 - APIs e código]] | 4-6 semanas | Média |
| 4 — RAG e memória | [[40 - Nível 4 - RAG e memória]] | 3-4 semanas | Média |
| 5 — Agentes e arquitetura | [[50 - Nível 5 - Agentes e arquitetura]] | 6-8 semanas | **Alta — revisar por trimestre** |
| 6 — Produção e avaliação | [[60 - Nível 6 - Produção e avaliação]] | Contínuo | **Alta — revisar por trimestre** |

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

## Convenções do vault

- **Status por conceito:** `não iniciado` → `estudando` → `aplicado em projeto`. Um conceito só vira `aplicado em projeto` quando apareceu em código que rodou.
- **Sinal de alerta:** muitas notas em `estudando` e nenhuma em `aplicado` = o estudo virou fim em si.
- **Campo `verificado`:** data da última checagem de validade. Obrigatório nos Níveis 5 e 6.
- Em cada conceito, registrar o **"por que importa comercialmente"** — é o que transforma nota de estudo em roteiro de conteúdo depois.
