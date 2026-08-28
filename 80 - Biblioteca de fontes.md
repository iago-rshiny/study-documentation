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
- O **cabeçalho da seção (H2) é o título da fonte** — assim ela aparece no painel de outline e vira âncora citável. Data, tipo e URL vão nos campos de metadados abaixo.
- **Categorizar o tipo** com uma tag no campo Tipo: `#video`, `#artigo`, `#paper`, `#livro`, `#podcast`, `#curso`, `#doc`, `#thread`, `#post`, `#outro`.
- **Insight ≠ resumo.** Registrar o que muda algo no seu trabalho ou pensamento; se um item não vai virar ação, prompt ou decisão, ele não precisa estar aqui.
- **Linkar insights às notas existentes do vault** quando houver ponte real. Usar alias com `[[nota|texto que aparece]]` quando o nome do arquivo for feio no meio da frase.
- Quando um insight vira ação executada, marcar com ✅ e linkar a nota do nível/projeto onde entrou. Ex.: `✅ aplicado em [[30 - Nivel 3 - APIs e codigo]]`.

---

## Me dê 28 minutos e eu vou te entregar 10.000 horas de conhecimento sobre Claude

**Fonte:** https://www.youtube.com/watch?v=H3VcxLmKF78
**Tipo:** `#video` · YouTube
**Data de consumo:** 2026-08-28
**Tema:** uso de IA com contexto, verbalização, engenharia de prompt

### Insights

- **Wispr Flow (ou Win+H / Fn no Mac)** — usar ditado por voz para alimentar contexto. Ganho duplo: velocidade de input e **verbalização como treino de oratória e clareza de explicação**. Falar o pensamento força a estrutura que a escrita esconde. Ler mais ajuda a construir repertório para verbalizar melhor *(minha sugestão)* — ver [[70 - Leituras paralelas]].
- **Teste de clareza** — se você não consegue verbalizar o problema de forma que a IA responda bem, você ainda não entendeu o problema. O prompt ruim é diagnóstico, não bug. Casa direto com **Clareza e especificidade** e **Iteração medida** em [[20 - Nivel 2 - Prompt engineering]], e com o transversal [[01 - Conceitos transversais|Medição e critério de sucesso]] — sem definição de sucesso, não há como diagnosticar o próprio prompt.
- **Heurística 40-40-20** — distribuição do esforço ao trabalhar com IA:
  - **40% construir o repertório** — ler, estudar, absorver casos e classes de solução do domínio. É a razão de existir de [[10 - Nivel 1 - Fundamentos]] e das [[70 - Leituras paralelas]].
  - **40% transformar imaginação em palavras** — verbalizar bem o que você quer, com contexto suficiente. Meta-habilidade transversal a todos os níveis.
  - **20% dominar técnicas de prompt** — a parte que os cursos vendem como 100%. É o [[20 - Nivel 2 - Prompt engineering]] inteiro: técnica sem repertório rende pouco.
- **A IA como expansora de repertório** — quando o próprio repertório trava, usar a IA para ampliá-lo com perguntas do tipo:
  - Quais classes de solução existem para este problema?
  - Quais mecanismos eu provavelmente ainda não conheço?
  - Quais critérios um especialista usaria para decidir?
  - Quais são as premissas e os riscos de cada alternativa?

  Essas quatro perguntas são um mini-`/grill-me` do domínio, antes de qualquer execução. Ver a seção **Criação de skills e comandos próprios** em [[50 - Nivel 5 - Agentes e arquitetura]].
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

  Isso é **context engineering aplicado ao próprio negócio**, não só ao produto — ver [[01 - Conceitos transversais|Janela de contexto]] e a discussão de context engineering em [[20 - Nivel 2 - Prompt engineering]]. Quando esse documento estiver estável, vira insumo direto de skills e agentes do [[50 - Nivel 5 - Agentes e arquitetura]] (o LLM aumentado precisa de contexto de negócio, não só de conhecimento). **Próxima ação:** criar `Contexto - Iago automação IA.md` como nota viva, seguindo essa estrutura.

### Ações pendentes desta fonte

- [ ] Instalar/testar Wispr Flow (ou nativo Win+H) por uma semana no fluxo de trabalho.
- [ ] Criar a nota `Contexto - Iago automação IA.md` com a estrutura de 10 blocos.
- [ ] Testar as 4 perguntas de expansão de repertório na próxima decisão de projeto.

---

## Modelo para novas entradas

```markdown
## Título da fonte (como o autor a chama)

**Fonte:** [URL ou referência]
**Tipo:** `#tag` · plataforma/publicação
**Data de consumo:** AAAA-MM-DD
**Tema:** o que a fonte trata em uma linha

### Insights

- **[Título do insight]** — o que ficou e por que importa. Linkar [[nota-relacionada]] quando houver ponte real.
- **[Outro insight]** — …

### Ações pendentes desta fonte

- [ ] Ação concreta 1
- [ ] Ação concreta 2
```

---

## Índice por tipo (crescer com o tempo)

- **Vídeos:** 2026-08-28 · YouTube · *Me dê 28 minutos e eu vou te entregar 10.000 horas de conhecimento sobre Claude*
- **Artigos:** —
- **Papers:** —
- **Livros:** —
- **Podcasts:** —
- **Cursos:** —
- **Documentações:** —
- **Threads / posts:** —
