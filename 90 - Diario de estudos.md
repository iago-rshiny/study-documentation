---
tipo: diario
iniciado: 2026-09-04
tags: [roadmap-ia, diario, estudos]
---

# Diário de estudos

Registro de cada sessão de estudo. **Diferente da [[80 - Biblioteca de fontes]]:** lá fica o que a fonte trouxe; aqui fica o que EU entendi, o que travou, e o que ficou aberto. A biblioteca é catálogo; o diário é processo.

## Por que existe

O teste de saída de cada nível pergunta se você consegue explicar um conceito **com suas palavras**. Este diário é onde essa explicação é escrita pela primeira vez — antes de estar boa. Reler entradas antigas mostra a evolução do entendimento, e é matéria-prima direta de roteiro para o quadro "For Nerds": o momento em que algo fez sentido é o momento mais didático de explicar.

## Regras

- **Escreva com suas palavras, não com as do vídeo.** Copiar a explicação da fonte derrota o propósito.
- **Registre as dúvidas, não só os acertos.** A dúvida de hoje é o roteiro de amanhã.
- Uma entrada por sessão, mesmo que curta. Sessão sem entrada é sessão que evapora.
- Ao fechar um conceito, marcar o checkbox correspondente na nota do nível e mudar o status lá para `aplicado em projeto` quando ele aparecer em código que rodou.

---

## Modelo de entrada

```markdown
## AAAA-MM-DD · Nível X · [Conceito]

**Fonte consumida:** [o que assisti/li nesta sessão]
**Tempo:** ~Xh

### O que entendi (minhas palavras)


### O que travou / dúvidas em aberto


### Ponte com o que já sei (estatística, trabalho, projetos)


### Próximo passo

- [ ]
```

---

## Sessões

## 2026-09-04 · Nível 1 · Predição do próximo token

**Fonte consumida:** Large Language Models explained briefly — 3Blue1Brown (~9 min)
**Tempo:**

### O que entendi (minhas palavras)

*(preencher)*

### Pergunta desta sessão

Se o modelo produz uma distribuição de probabilidade determinística para um dado contexto, por que a saída final não é determinística?

*(responder aqui antes de seguir para o próximo conceito)*

### O que travou / dúvidas em aberto


### Ponte com o que já sei

Classificação multiclasse com ~100k classes, treinada por máxima verossimilhança com cross-entropy. Mesma família da regressão logística multinomial; diferenças: escala, features aprendidas, e o loop autorregressivo.

### Próximo passo

- [ ] Responder a pergunta acima com minhas palavras
- [ ] Seguir para tokenização (Tiktokenizer, comparar PT vs EN)
