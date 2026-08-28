---
nível: 2
duração: 2-3 semanas (contínuo)
status: não iniciado
perecibilidade: baixa-média
verificado: 2026-08-28
tags: [roadmap-ia, nivel-2]
---

# Nível 2 — Prompt engineering

**Objetivo:** técnicas estruturadas de instrução, com fontes primárias (a área é cheia de lixo publicado — "100 prompts mágicos" é ruído; docs oficiais resolvem 90%).
**Modelo mental:** prompt não é comando, é **condicionamento** — você altera P(saída | contexto) mudando o contexto. Exemplos condicionam mais forte que adjetivos.
**Evolução do termo:** context engineering é a progressão natural — curar e manter o conjunto ótimo de tokens durante a inferência, incluindo tudo que chega fora dos prompts. Não é fase que termina; vira a base do [[50 - Nivel 5 - Agentes e arquitetura]].

## Conceitos (em ordem de retorno sobre esforço)

- [ ] **Clareza e especificidade** — a técnica mais subestimada. "Estagiário no primeiro dia": instruções explícitas, formato, tamanho, público, critério de sucesso. Dizer o que fazer, não o que não fazer.
- [ ] **Delimitadores e tags XML** — separar instrução, contexto e dados. Primeira linha de defesa contra prompt injection.
- [ ] **Few-shot vs zero-shot** — tentar zero-shot antes (modelos novos inferem bem intenção); few-shot (1-5 exemplos) quando o formato precisa ser rígido. Conformidade de formato >95% com exemplos + estrutura explícita.
- [ ] **Chain-of-thought — e quando atrapalha** — "pense passo a passo" ajuda em modelos comuns, mas pode PIORAR modelos de raciocínio (a própria doc da OpenAI alerta). Detalhe que separa quem leu a doc de quem leu blog.
- [ ] **System prompt e role prompting** — separar o permanente do variável. ~69% dos tokens de entrada em sistemas agênticos de produção são system prompt.
- [ ] **Formatos de saída estruturada** — JSON/schema. A ponte entre "brinquei com IA" e "entreguei automação". Ver [[01 - Conceitos transversais]] (schema como contrato).
- [ ] **Prompt chaining** — decompor em chamadas encadeadas; mais confiável e depurável. Semente da orquestração do Nível 5.
- [ ] **Posicionamento e prompt caching** — documentos longos no topo, pergunta no final (até +30% de qualidade). Estático primeiro, variável por último: cache corta até 90% do custo e 85% da latência. Diferença entre margem e prejuízo em automação de alto volume.
- [ ] **Iteração medida (A/B de prompt)** — conjunto de teste rotulado, métrica definida, comparação entre versões. O item que quase ninguém faz. Diferencial estatístico.
- [ ] **Prompt injection (fundamentos)** — conteúdo vindo do usuário/cliente é *dado*, nunca instrução. Nunca concatenar entrada externa no bloco de instruções.
- [ ] **Context engineering** — ler ao final do nível; ponte para o Nível 5.

## Fontes

- **Tutorial interativo da Anthropic** — 9 capítulos + apêndice, com playground. ~6h. Comece aqui. https://github.com/anthropics/prompt-eng-interactive-tutorial
- **Prompting best practices (Anthropic)** — referência viva, consulta e não leitura linear. https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
- **Guia de prompt engineering da OpenAI** — 6 estratégias centrais; ler para separar o universal do específico de fornecedor. https://platform.openai.com/docs/guides/prompt-engineering
- **promptingguide.ai** — DAIR.AI, neutro, com links para papers. https://www.promptingguide.ai/
- **Papers (opcional, para "For Nerds"):** *Language Models are Few-Shot Learners* (Brown et al., 2020) · *Chain-of-Thought Prompting* (Wei et al., 2022)
- **Effective context engineering for AI agents** — Anthropic; ler no fim do nível. https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

## Plano (10h/semana)

- **Semana 1:** tutorial interativo caps. 1-5, escrevendo os prompts antes de olhar gabarito.
- **Semana 2:** caps. 6-9 + apêndice → guia OpenAI → best practices. Iniciar **biblioteca de prompts** no vault: um arquivo por tarefa, com versão, mudança e resultado observado.
- **Semana 3:** tarefa real (ex.: classificar mensagens de WhatsApp em 4 categorias), 30-50 casos rotulados à mão, 3 versões de prompt com acurácia medida. É o Ciclo 2 começando — primeiro artefato de portfólio.

## Teste de saída

1. Explicar por que few-shot funciona em termos de distribuição condicional.
2. Dizer em que situação chain-of-thought **atrapalha**.
3. Estruturar um prompt para aproveitar cache e justificar a ordem.
4. Ter um método para descobrir *por que* um prompt falha 20% das vezes, em vez de chutar mudanças.
5. Explicar como impedir que texto de cliente seja interpretado como instrução.
