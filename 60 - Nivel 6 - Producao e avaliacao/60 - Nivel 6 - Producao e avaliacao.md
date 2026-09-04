---
nível: 6
duração: contínuo
status: não iniciado
perecibilidade: alta — revisar por trimestre
verificado: 2026-08-28
tags: [roadmap-ia, nivel-6]
---

# Nível 6 — Produção e avaliação

**Objetivo:** evals, monitoramento, custo, guardrails. **O maior diferencial competitivo:** quase ninguém neste mercado sabe medir se a automação funciona. Desenhar avaliação estatística vira argumento de venda ("eu provo o ROI com dados").

## Conceitos

- [ ] **Testing vs observability** — testing roda antes do deploy (pega regressão); observability roda depois (pega drift e degradação no tráfego real). Produção precisa das duas. APM tradicional não serve: mesmo prompt → saídas diferentes; retrieval errado com HTTP 200; agente queima milhares de tokens e erra com confiança.
- [ ] **Tracing e reprodução de falha** — capturar prompts, tool calls, retrieval, tokens, latência e custo de cada requisição para poder reproduzir. Uma linha de log não diz qual elo da cadeia quebrou.
- [ ] **Golden dataset** — casos rotulados à mão que definem sucesso. Sem isso, nada existe. 30-50 casos reais do cliente; toda falha em produção vira caso de teste. Versionado por cliente.
- [ ] **LLM-as-judge** — modelo avaliando saídas de outro. Funciona, mas é instrumento de medição com viés e variância próprios.
- [ ] **Calibração do juiz** — rubricas específicas + calibrar contra ~15 exemplos rotulados por humano antes de usar como gate. Concordância juiz-humano: Cohen's kappa, matriz de confusão. Ninguém no mercado faz.
- [ ] **Amostragem de traces em produção** — padrão: plataforma captura traces, job agendado amostra 1-5% e roda avaliadores, notas voltam ao trace; regressão roda como gate no PR.
- [ ] **Amostragem estratificada** — 1% aleatório subamostra os casos raros que quebram. Estratificar por tipo de intenção. Contribuição estatística direta.
- [ ] **Métricas de negócio** — taxa de resolução sem humano (contenção), taxa de alucinação, faithfulness, latência p50/p95, custo por conversa. Venda: contenção × custo do atendimento humano = ROI em reais.
- [ ] **Guardrails e escalonamento** — validação de saída, limite de escopo, detecção de injeção, caminho para humano (requisito contratual em PME).
- [ ] **Detecção de drift** — qualidade de LLM degrada silenciosamente; detectar queda antes do cliente reclamar é o pitch da mensalidade invertido.
- [ ] **Custo do próprio eval** — 10k traces/dia com juiz grande: ~US$ 200-600/mês (US$ 0,05-0,15/trace); juiz barato corta 60-80% com perda aceitável. Precificar na manutenção.
- [ ] **ROI com incerteza quantificada** — relatório mensal por cliente: contenção, custo por atendimento, comparativo com baseline humano, intervalo de confiança. Retenção + preço + conteúdo ao mesmo tempo.

## Stack mínimo

Convergência da área: **duas ferramentas** — um framework leve para gate em CI + uma plataforma de observabilidade/anotação.

- **Langfuse** — observabilidade open-source líder (MIT); liga cada trace à versão exata de prompt/modelo/dataset. Começar por aqui. https://langfuse.com/
- **DeepEval** — evals como testes pytest em CI (Apache 2.0). https://deepeval.com/
- **Ragas** — métricas RAG (Apache 2.0); se o RAG é componente de um agente maior, DeepEval encaixa melhor. https://docs.ragas.io/
- **Promptfoo** — regressão de prompt e red teaming; diff visual de casos que regrediram. https://promptfoo.dev/

**Notas de mercado (verificar validade):** Promptfoo adquirida pela OpenAI no início de 2026 (CLI open-source mantém licença); plataforma da Humanloop descontinuada em 2025 (time contratado pela Anthropic). O mercado consolida rápido — não casar com ferramenta.

## Plano de implantação (4 semanas, cabe nas 10h)

1. CI com Promptfoo disparado por mudança em arquivo de prompt (1-2h).
2. Instrumentar Langfuse, conectar versões de prompt aos traces; revisão semanal de qualidade (2-3h).
3. Varredura de segurança (Giskard) nos prompts de produção (2-3h).
4. LLM-as-judge com rubricas para os 3 prompts de maior risco, calibrado contra 15 rótulos humanos (3h).

Isso é, literalmente, um produto vendável como serviço avulso.

## Fontes

- Docs: Langfuse · DeepEval · Ragas · Promptfoo (links acima)
- **Panorama de plataformas 2026** — https://www.marktechpost.com/2026/08/09/top-llm-observability-and-evaluation-platforms-in-2026-langfuse-langsmith-braintrust-arize-and-more-compared/

## Teste de saída

1. Golden dataset versionado por cliente?
2. Juiz calibrado contra rótulo humano, com métrica de concordância declarada?
3. Detecta queda de qualidade antes do cliente reclamar?
4. Sabe o custo unitário por conversa, incluindo o custo do eval?
5. Apresenta ROI com incerteza quantificada, não número solto?
