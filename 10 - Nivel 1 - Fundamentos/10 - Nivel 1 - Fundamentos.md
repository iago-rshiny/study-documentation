---
nível: 1
duração: 2-4 semanas
status: não iniciado
perecibilidade: baixa
verificado: 2026-08-28
tags: [roadmap-ia, nivel-1]
---

# Nível 1 — Fundamentos conceituais

**Objetivo:** entender como um LLM funciona de verdade. Terreno familiar: é estatística aplicada.
**Conceito-raiz:** o LLM é um classificador probabilístico rodando em loop — recebe tokens, produz uma distribuição de probabilidade sobre o vocabulário para o próximo token, amostra, anexa, repete. É classificação multiclasse (~100k classes) treinada por máxima verossimilhança com cross-entropy.

## Conceitos

- [x] **Predição do próximo token como classificação multiclasse** — a ponte com regressão logística multinomial; a diferença é escala e features aprendidas.
- [x] **Tokenização e BPE** — texto vira IDs inteiros de "pedaços" definidos por frequência no corpus. Explica por que o modelo erra ao contar letras.
- [x] **Custo de tokens PT vs EN** — português consome ~30-40% mais tokens. Impacto direto no custo dos projetos.
- [ ] **Embeddings e similaridade por cosseno** — vetores em alta dimensão onde direções correspondem a significado. Intuição de PCA/análise fatorial, com dimensões aprendidas. Pré-requisito do Nível 4.
- [ ] **Mecanismo de atenção (query, key, value)** — softmax sobre produtos internos; cada token atualiza seu vetor com base nos outros. Custo quadrático no contexto.
- [ ] **Camadas MLP e armazenamento de fatos** — onde o "conhecimento" fica. Ajuda a entender por que o modelo sabe fatos mas não sabe *que* sabe.
- [ ] **Temperatura e amostragem (top-p, top-k)** — temperatura é o T no softmax: dividir logits por T antes de normalizar. Reescalar a variância da distribuição.
- [ ] **Janela de contexto** — ver [[01 - Conceitos transversais]].
- [ ] **Alucinação como fenômeno estatístico** — treino e avaliação recompensam o chute em vez do reconhecimento de incerteza; alucinações se originam como erros de classificação binária. Taxa de alucinação ≥ 2× taxa de erro de classificação (menos correções).
- [ ] **Calibração e o incentivo ao chute** — minimizar cross-entropy garante calibração (probabilidades alinham com acerto), não verdade. Quando "não sei" pontua igual a erro, o chute é incentivado. Brier score, curva de calibração, trade-off precisão/abstenção — terreno da estatística.

## Fontes

- **Large Language Models explained briefly** — 3Blue1Brown, ~9 min. Comece aqui. Vídeo: https://www.youtube.com/watch?v=LPZh9BOjkQs · Página: https://www.3blue1brown.com/lessons/mini-llm/
- **Deep Dive into LLMs like ChatGPT** — Karpathy, 3h31. *O* recurso do nível; dividir em 5-6 sessões. https://www.youtube.com/watch?v=7xTGNNLPyMI
- **Tiktokenizer** — comparar contagem PT vs EN na prática. https://tiktokenizer.vercel.app/
- **Let's build the GPT Tokenizer** — Karpathy, ~2h, BPE do zero (opcional). https://www.youtube.com/watch?v=zduSFxRajkE
- **Transformers, the tech behind LLMs** — 3Blue1Brown, cap. 5 (~27 min): estrutura geral, word embeddings, unembedding e **softmax com temperatura**. Cobre dois conceitos deste nível de uma vez. https://www.3blue1brown.com/lessons/gpt/
- **Attention in transformers, step-by-step** — 3Blue1Brown, cap. 6 (~26 min): query/key/value, produto interno como medida de similaridade, softmax, multi-head. https://www.3blue1brown.com/lessons/attention/
- **How might LLMs store facts** — 3Blue1Brown, cap. 7 (~23 min): camadas MLP; usa o exemplo de armazenar "Michael Jordan joga basquete". https://www.3blue1brown.com/lessons/mlp/
- **The Illustrated Transformer** — Jay Alammar (texto + diagrama). https://jalammar.github.io/illustrated-transformer/
- **LLM Visualization** — Brendan Bycroft, GPT 3D navegável. https://bbycroft.net/llm
- **Attention Is All You Need** — paper original; ler depois dos vídeos. https://arxiv.org/abs/1706.03762
- **Why Language Models Hallucinate** — OpenAI (post + paper, set/2025). https://openai.com/index/why-language-models-hallucinate/ · paper: https://arxiv.org/pdf/2509.04664
- **Anthropic, OpenAI Should Not Be Allowed to IPO — Ed Zitron** — assistir logo no início, como **contraponto crítico**: a visão cética sobre a economia do setor (custos, receita, sustentabilidade das empresas de IA). Importante para quem vai construir negócio em cima dessa infraestrutura: entender o risco do fornecedor faz parte do fundamento, e evita discurso de vendedor deslumbrado com o cliente. https://www.youtube.com/watch?v=v4F1gFy-hqg

## Plano (10h/semana)

- **Semana 1 — intuição:** vídeo de 9 min → Tiktokenizer (1h) → primeiras 1h30 do Karpathy.
- **Semana 2 — mecânica:** 3B1B caps. 5-7 (76 min de vídeo, 4-5h com pausas) → Bycroft → restante do Karpathy.
- **Semana 3 — consolidação:** post da OpenAI sobre alucinação → experimentos com temperatura na API → resumo próprio de 2 páginas em linguagem de estatística (primeiro rascunho de roteiro "For Nerds").

## Teste de saída

1. Por que o mesmo prompt dá respostas diferentes duas vezes?
2. Por que um texto em português custa mais que o mesmo em inglês?
3. Por que o modelo inventa uma referência bibliográfica com confiança total?
4. Por que "colar o manual inteiro no prompt" não escala, e o que resolve isso?
5. O que exatamente muda quando eu baixo a temperatura para 0?
