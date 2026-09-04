---
tipo: diario
nivel: 5
sessoes: 1
horas_acumuladas: 0
iniciado: 2026-09-04
tags: [roadmap-ia, diario, nivel-5]
---

# Diário — Nível 5: Agentes e arquitetura

Registro das sessões de estudo deste nível. Regras e modelo de entrada em [[02 - Metodo de estudo]].
Conteúdo do nível: [[50 - Nivel 5 - Agentes e arquitetura]]

**Diferente da [[80 - Biblioteca de fontes]]:** lá fica o que a fonte trouxe; aqui fica o que EU entendi, o que travou e o que ficou aberto.

---

## Sessões

## 2026-09-04 · Harness engineering (Agent = Model + Harness)

**Tópico:** [[50 - Nivel 5 - Agentes e arquitetura]] → `Harness engineering (Agent = Model + Harness)`
**Fonte consumida:** nenhuma fonte externa — sessão de construção. O sistema montado está descrito em [[90 - Como funciona a automacao]].
**Tempo:**

### Pergunta desta sessão

> "Se isso é apenas uma automação ou se existem agentes envolvidos no ecossistema."

Pergunta minha, ainda não respondida com minhas palavras. É o [[50 - Nivel 5 - Agentes e arquitetura|workflow vs agente]] aplicado a um sistema meu, em vez de a um caso de cliente.

### O que foi coberto na conversa

- **Automação determinística vs agente:** automação é entrada → saída por regra escrita (custo zero, erra sempre igual); agente recebe objetivo, tem ferramentas e decide os passos (custa token, erra diferente a cada vez).
- **Regra de projeto adotada:** se você consegue escrever a regra, não use agente.
- O harness montado tem quatro camadas: contrato (frontmatter do vault), conhecimento (skill), julgamento (agente), gatilho e índice (hook + scripts determinísticos).
- O hook `SessionEnd` é raso de propósito — só enfileira metadados, não sintetiza. Sintetizar ali gastaria token em toda sessão encerrada e escreveria no vault sem revisão.
- `/registrar` usa o agente principal (contexto já carregado); `/registrar --fila` usa subagente, porque transcripts antigos não devem entrar no contexto atual.
- Mapeamento com o vocabulário deste nível: a skill é um **guide** (convenção antes da ação), o indexador é um **sensor** (mede depois).
- Verificação do que o agente escreve: `git diff` antes do commit, já que o vault é versionado.
- Detalhe de plataforma: PowerShell 5.1 lê `.ps1` sem BOM como ANSI e quebra no primeiro acento; os scripts foram salvos em UTF-8 com BOM.

### O que entendi (minhas palavras)

> [!todo] Escrever com suas palavras
> (você ainda não formulou isto na conversa)
>
> Para responder à pergunta acima sem consultar a nota de arquitetura:
> - Neste sistema, onde um script bastaria e onde o modelo é inevitável? Por quê?
> - Por que o hook `SessionEnd` não sintetiza nada — só enfileira?
> - Por que `/registrar` não usa subagente e `/registrar --fila` usa?

### O que travou / dúvidas em aberto

- "Onde consigo verificar se os dados do que está sendo estudado e respondido estão sendo incluídos corretamente?" — respondido em parte: `git diff` antes do commit mostra linha a linha o que o agente escreveu no vault. Fica aberto o que nenhuma camada verifica hoje: **link quebrado**.
- Decisão pendente: construir ou não um `verificar-vault.ps1` — varredura determinística de wikilinks que não apontam para arquivo existente.

### Ponte com o que já sei (estatística, trabalho, projetos)

> [!todo] Escrever com suas palavras
> (você ainda não formulou isto na conversa)

### Próximo passo

- [ ] Responder a "Pergunta desta sessão" com minhas palavras
- [ ] Commit inicial de `90 - Sistema/` e `.claude/` — sem ele o `git diff` não funciona como verificação
- [ ] Decidir sobre o `verificar-vault.ps1`
- [ ] Reiniciar o Claude Code para o hook `SessionEnd` entrar em vigor
