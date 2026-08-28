---
nível: 4
duração: 3-4 semanas
status: não iniciado
perecibilidade: média
verificado: 2026-08-28
tags: [roadmap-ia, nivel-4]
---

# Nível 4 — RAG e memória

**Objetivo:** "IA que conhece os documentos da empresa do cliente" — requisito de quase todo projeto real.

## Conceitos

- [ ] **Por que RAG existe** — contexto é finito e caro; documento do cliente é grande e muda. Recuperar só o pedaço relevante na hora da pergunta.
- [ ] **Modos de falha do RAG ingênuo** — "chunk → embed → cosseno → prompt" é protótipo. Falhas previsíveis: chunking destrói contexto; similaridade ≠ relevância ("como reseto minha senha?" vs "política de reset de senha"); top-K é grosseiro; query crua sem transformação.
- [ ] **Vector stores** — onde os embeddings moram. Critério: Chroma para começar local; pgvector quando o cliente já tem Postgres (caso comum em PME — evita um serviço a mais).
- [ ] **Estratégias de chunking** — fixo, com overlap, semântico, hierárquico. Trade-off: pequeno fragmenta sentenças, grande traz contexto irrelevante. Baseline de referência: 256 tokens, overlap 50, top-4. Semântico compensa em manuais técnicos; fixo resolve conteúdo simples.
- [ ] **Padrão parent-child** — indexar filhos pequenos (~100 tokens, precisão), recuperar o documento pai inteiro (contexto). Precisão cirúrgica + geração rica.
- [ ] **BM25 e busca lexical** — imbatível para códigos de produto, termos jurídicos, siglas. Não morreu.
- [ ] **Busca híbrida e Reciprocal Rank Fusion** — vetorial + BM25 em paralelo, fusão com RRF (k=60 padrão). Sensível a hiperparâmetro → tunar com medição, não copiar de tutorial. É rank aggregation — terreno da estatística.
- [ ] **Reranking e cross-encoders** — recuperar top-100 barato, re-rankear, manter top 5-10. Melhora consistente de nDCG; trade-off de latência (num bot de WhatsApp, latência é UX).
- [ ] **Lost in the middle** — o modelo ignora informação enterrada no meio de listas longas. É o que o reranking elimina.
- [ ] **Contextual retrieval** — enriquecer cada chunk com contexto do documento antes de indexar ("a receita cresceu 3%" → de qual empresa? qual período?). Barato, ganho grande. Anthropic, set/2024.
- [ ] **Query rewriting multi-turno** — "e o preço?" depois de 3 mensagens não é query buscável. Reescrever antes de bater no índice. Caso WhatsApp.
- [ ] **Filtros por metadados** — filtrar por data/departamento/tipo antes da busca vetorial reduz ruído.
- [ ] **Métricas de RAG** — separar retrieval (precision/recall, nDCG@k) de geração (faithfulness). 80% dos problemas são de retrieval e as pessoas mexem no prompt. Padrão: Ragas (faithfulness, answer relevancy, context precision/recall).
- [ ] **Padrões operacionais** — cachear embeddings/rerank/respostas; fallback quando confiança baixa; logar quais chunks foram recuperados e se o usuário achou útil.
- [ ] **Memória de agente ≠ RAG** — RAG é conhecimento estático; memória é estado da conversa e do usuário. Não confundir no design.

## Fontes

- **Contextual Retrieval** — Anthropic, leitura obrigatória. https://www.anthropic.com/news/contextual-retrieval
- **Ragas docs** — métricas padrão. https://docs.ragas.io/
- **Searching for Best Practices in RAG** — ablações sistemáticas. https://arxiv.org/pdf/2407.01219
- **Reconstructing Context (chunking strategies)** — https://arxiv.org/pdf/2504.19754
- **Docs do Chroma** (local) e do **pgvector** (Postgres).

## Projeto (Ciclo 5)

Assistente sobre PDFs reais (manual, política de RH) em **duas versões** — ingênua e híbrido+rerank — **medindo a diferença**. O comparativo é conteúdo de LinkedIn pronto.

## Teste de saída

1. Dado um erro, você isola se foi retrieval ou geração?
2. Por que BM25 ainda importa?
3. Quando parent-child compensa a complexidade?
4. Como você mede o efeito de mudar o chunk size?
5. Quando o certo é *não* usar RAG e só colocar tudo no contexto?
