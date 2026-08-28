---
tipo: transversal
status: não iniciado
verificado: 2026-08-28
tags: [roadmap-ia, transversal]
---

# Conceitos transversais

Cinco conceitos que reaparecem em todos os níveis. Criar estas notas primeiro — quase tudo linka para elas. Cada um pode virar nota atômica própria quando ganhar volume.

## Token e custo por token
Tudo é medido, cobrado e limitado em tokens. Português consome ~30-40% mais tokens que inglês para o mesmo conteúdo — afeta custo de projeto diretamente.
Aparece em: [[10 - Nível 1 - Fundamentos]] (tokenização), [[30 - Nível 3 - APIs e código]] (custo por chamada), [[50 - Nível 5 - Agentes e arquitetura]] (custo do loop), [[60 - Nível 6 - Produção e avaliação]] (custo por conversa).

## Janela de contexto
Tudo que o modelo "sabe" naquela chamada está no contexto — não há memória entre chamadas. O que sai da janela deixa de existir. É a origem da necessidade de RAG e da gestão de memória em agentes.
Aparece em: Níveis 1, 2 (posicionamento/cache), 4 (por que RAG existe), 5 (gestão de contexto no loop).

## Schema como contrato
A interface entre o modelo probabilístico e o código determinístico. Formato de saída, definição de ferramenta e validação são todos a mesma ideia: contrato explícito.
Aparece em: Níveis 2 (formatos de saída), 3 (structured outputs, tool use), 5 (design de ferramentas).

## Medição e critério de sucesso
Antes de otimizar qualquer coisa: definição clara de sucesso, um jeito de testar contra esses critérios, e um baseline. Sem isso é otimização às cegas.
Aparece em: Níveis 2 (iteração de prompt), 4 (métricas de RAG), 6 (o nível inteiro).

## Não-determinismo
A mesma entrada produz saídas diferentes. Toda saída de LLM é entrada não-confiável até ser validada. Implica: validação, retry, avaliação estatística em vez de teste unitário clássico.
Aparece em: Níveis 1 (temperatura), 3 (tratamento de erro), 6 (por que APM tradicional não serve).
