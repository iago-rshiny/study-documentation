---
tipo: biblioteca
criado: 2026-08-28
atualizado: 2026-08-28
tags: [roadmap-ia, biblioteca, insights]
---

# Biblioteca de fontes consumidas

Registro do que consumo ao longo do tempo — vídeos, artigos, papers, podcasts, cursos, livros, posts, threads. Cada entrada traz a fonte, o tipo, a data e os **insights próprios** (o que ficou, não o que a fonte disse). O objetivo é que essa nota vire matéria-prima: para roteiro de conteúdo, para prompts, para decisões de projeto.

## Como usar

- **Uma seção por fonte**, na ordem cronológica inversa (mais recente no topo).
- **Categorizar o tipo** com uma tag no cabeçalho da entrada: `#video`, `#artigo`, `#paper`, `#livro`, `#podcast`, `#curso`, `#doc`, `#thread`, `#post`, `#outro`.
- **Insight ≠ resumo.** Registrar o que muda algo no seu trabalho ou pensamento; se um item não vai virar ação, prompt ou decisão, ele não precisa estar aqui.
- Quando um insight vira ação executada, marcar com ✅ e linkar a nota do nível/projeto onde entrou. Ex.: `✅ aplicado em [[30 - Nivel 3 - APIs e codigo]]`.

---

## 2026-08-28 · Vídeo · YouTube

**Fonte:** https://www.youtube.com/watch?v=H3VcxLmKF78
**Tipo:** `#video`
**Tema:** uso de IA com contexto, verbalização, engenharia de prompt

### Insights

- **Wispr Flow (ou Win+H / Fn no Mac)** — usar ditado por voz para alimentar contexto. Ganho duplo: velocidade de input e **verbalização como treino de oratória e clareza de explicação**. Falar o pensamento força a estrutura que a escrita esconde. Ler mais ajuda a construir repertório para verbalizar melhor *(minha sugestão)*.
- **Teste de clareza** — se você não consegue verbalizar o problema de forma que a IA responda bem, você ainda não entendeu o problema. O prompt ruim é diagnóstico, não bug.
- **Heurística 40-40-20** — distribuição do esforço ao trabalhar com IA:
  - **40% construir o repertório** — ler, estudar, absorver casos e classes de solução do domínio.
  - **40% transformar imaginação em palavras** — verbalizar bem o que você quer, com contexto suficiente.
  - **20% dominar técnicas de prompt** — a parte que os cursos vendem como 100%. Conecta com [[20 - Nivel 2 - Prompt engineering]]: técnica sem repertório rende pouco.
- **A IA como expansora de repertório** — quando o próprio repertório trava, usar a IA para ampliá-lo com perguntas do tipo:
  - Quais classes de solução existem para este problema?
  - Quais mecanismos eu provavelmente ainda não conheço?
  - Quais critérios um especialista usaria para decidir?
  - Quais são as premissas e os riscos de cada alternativa?
  Essas quatro perguntas são um mini-`/grill-me` do domínio, antes de qualquer execução. Ver [[50 - Nivel 5 - Agentes e arquitetura]].
- **Contexto organizado** — em vez de refazer o contexto a cada chamada, manter um documento vivo com estrutura fixa. Estrutura inicial sugerida:
  - Identidade e negócio
  - Posicionamento
  - Cliente ideal
  - Estratégia atual
  - Prioridades
  - Decisões vigentes
  - Exemplos aprovados
  - Processos
  - Reuniões relevantes
  - Índice de localização
  Isso é context engineering aplicado ao próprio negócio, não só ao produto. Conecta com [[01 - Conceitos transversais|Janela de contexto]] e com [[20 - Nivel 2 - Prompt engineering|Context engineering]]. **Próxima ação:** criar `Contexto - Iago automação IA.md` como nota viva do próprio negócio, seguindo essa estrutura.

### Ações pendentes desta fonte

- [ ] Instalar/testar Wispr Flow (ou nativo Win+H) por uma semana no fluxo de trabalho.
- [ ] Criar a nota `Contexto - Iago automação IA.md` com a estrutura de 10 blocos.
- [ ] Testar as 4 perguntas de expansão de repertório na próxima decisão de projeto.

---

## Modelo para novas entradas

```markdown
## AAAA-MM-DD · [Tipo] · [Fonte curta / autor]

**Fonte:** [URL ou referência]
**Tipo:** `#tag`
**Tema:** o que a fonte trata em uma linha

### Insights

- **[Título do insight]** — o que ficou e por que importa. Linkar [[nota-relacionada]] quando houver ponte.
- **[Outro insight]** — …

### Ações pendentes desta fonte

- [ ] Ação concreta 1
- [ ] Ação concreta 2
```

---

## Índice por tipo (crescer com o tempo)

- **Vídeos:** 2026-08-28 · YouTube · H3VcxLmKF78
- **Artigos:** —
- **Papers:** —
- **Livros:** —
- **Podcasts:** —
- **Cursos:** —
- **Documentações:** —
- **Threads / posts:** —
