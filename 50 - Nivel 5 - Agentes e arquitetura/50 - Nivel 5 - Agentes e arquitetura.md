---
nível: 5
duração: 6-8 semanas
status: não iniciado
perecibilidade: alta — revisar por trimestre
verificado: 2026-08-28
tags: [roadmap-ia, nivel-5]
---

# Nível 5 — Agentes e arquitetura

**Objetivo:** construir um loop ReAct do zero, depois tool use, orquestração, e só então frameworks. Low-code (n8n, Make) entra aqui — para cliente PME, muitas vezes entrega mais rápido que código puro.

## Conceitos

- [ ] **Workflow vs agente** — a distinção que organiza o nível. Workflows: LLMs e ferramentas orquestrados por caminhos de código pré-definidos. Agentes: o LLM dirige dinamicamente o próprio processo. A fronteira determina custo, previsibilidade e depurabilidade. **Para ~90% dos clientes PME, a resposta é workflow.**
- [ ] **LLM aumentado** — retrieval + ferramentas + memória: o substrato sobre o qual tudo é construído.
- [ ] **Padrão: prompt chaining** — passos sequenciais com checkpoints programáticos. Troca latência por acurácia.
- [ ] **Padrão: routing** — classifica a entrada e despacha para prompt especializado. Separação de responsabilidades.
- [ ] **Padrão: parallelization** — voting (mesma tarefa N vezes, saídas diversas → ensemble; você sabe raciocinar variância de estimadores agregados) e sectioning (subtarefas independentes em paralelo).
- [ ] **Padrão: orchestrator-workers** — decompõe em runtime e despacha subtarefas dinâmicas.
- [ ] **Padrão: evaluator-optimizer** — gerador + crítico iterando até um limiar de qualidade.
- [ ] **Loop ReAct construído à mão** — `while` + histórico + condição de parada. Antes de qualquer framework.
- [ ] **Condição de parada e orçamento** — teto de iterações e de gasto por execução. Sem isso o agente entra em loop e queima US$ 40 numa madrugada. Ninguém coloca por você.
- [ ] **Design de ferramentas como contrato** — nome, descrição e schema são prompt. Poucas ferramentas bem descritas > muitas mal descritas.
- [ ] **Gestão de contexto no loop** — histórico cresce a cada passo. Sumarizar passos antigos, truncar observações, guardar estado fora do contexto.
- [ ] **MCP** — padrão de facto para interoperabilidade agente-ferramenta (todos os grandes frameworks suportam). Permite reaproveitar integrações entre clientes → economia de escala.
- [ ] **Agent Skills** — pacotes portáteis de expertise de domínio (SKILL.md) carregados sob demanda, em vez de um agente sob medida por vertical.
- [ ] **Human-in-the-loop** — checkpoints de aprovação humana. Para PME, "quando passa pro humano" é requisito contratual.
- [ ] **Frameworks: quando entrar** — orientação primária: começar pelas APIs diretas (muitos padrões cabem em poucas linhas); frameworks obscurecem prompts e tentam à complexidade. Cenário 2026: Claude Agent SDK, Strands, LangGraph, OpenAI Agents SDK, CrewAI, AG2. LangGraph é o mais forte para produção com estado durável/checkpointing/HITL, mas custa 2-3 semanas de rampa — desnecessário em caso simples de agente único.
- [ ] **n8n / Make vs código** — critério objetivo: se o difícil é conectar sistemas (WhatsApp, Calendar, planilha), low-code; se o difícil é raciocínio ou volume, código. Comparar n8n e Make na prática (preço, nós de LLM, hospedagem).

## Design de software para a era dos agentes

- [ ] **Deep modules vs shallow modules** (Ousterhout, *A Philosophy of Software Design* — ver [[70 - Leituras paralelas]]) — módulo **profundo**: muita funcionalidade, interface simples, esconde complexidade. Módulo **raso**: pouca funcionalidade, interface complexa, expõe complexidade. A imagem mental: uma grade de dezenas de caixinhas idênticas e rasas (todo mundo conversa com todo mundo, nada esconde nada) versus meia dúzia de caixas grandes e profundas com interfaces enxutas entre elas. **Meta de refatoração: transformar a primeira na segunda** — menos módulos, mais profundos.
- [ ] **`/improve-codebase-architecture` (aprofundar módulos)** — comando/skill recorrente: pedir ao agente para analisar o código e propor consolidações que aumentem profundidade — fundir caixinhas rasas relacionadas, simplificar interfaces, mover complexidade para dentro. Rodar periodicamente, não só quando dói: é o "invest in the design every day" do Kent Beck operacionalizado.
- [ ] **Por que isso importa dobrado com IA** — agente de código gera caixinha rasa por padrão (cada pedido vira mais um arquivo/função solta). Sem pressão deliberada por profundidade, a codebase degrada mais rápido do que na era manual. Design de módulos é o trabalho que sobra para o humano.
- [ ] **Harness engineering (Agent = Model + Harness)** — o agente é o sistema completo: modelo + harness. O harness é a camada de execução em volta do modelo — ferramentas, permissões, contexto, estado, testes, traces, retries, aprovações e evals — que torna o comportamento inspecionável, testável e restringível. Distinção de escopo: prompt engineering ([[20 - Nivel 2 - Prompt engineering]]) escreve instruções para um turno; harness engineering constrói o sistema que governa o agente ao longo de todos os turnos. Genealogia: termo atribuído a Mitchell Hashimoto (fev/2026), formalizado em post da OpenAI dias depois. O vault já cobria a substância sem o nome: loop com orçamento, design de ferramentas, gestão de contexto (este nível); feedback loops e TDD como guardrail ([[30 - Nivel 3 - APIs e codigo]]); tracing, evals e guardrails ([[60 - Nivel 6 - Producao e avaliacao]]).
- [ ] **O princípio do Hashimoto** — quando o agente erra, construir uma solução que garanta que aquele erro específico nunca se repita. É o "todo bug vira teste" do Nível 3 elevado a filosofia de sistema: o harness acumula as lições, o modelo não precisa lembrar.
- [ ] **Artefatos do harness** — AGENTS.md (documento de codebase: o que o agente pode tocar, quais convenções seguir, quais ferramentas existem), arquivos de constraint (o que nunca fazer; o que exige aprovação humana) e pipelines de contexto (os dados que chegam ao agente em runtime). Parentes das skills, com papel distinto: skill é procedimento reutilizável; constraint é limite inegociável.
- [ ] **Guides e sensors** — guias codificam convenções ANTES da ação; sensores rodam DEPOIS que o agente age (evals, testes, verificação), pegando falhas antes da produção. É a ponte explícita deste nível com o [[60 - Nivel 6 - Producao e avaliacao]]: o Nível 6 inteiro é a camada de sensores do harness.
- [ ] **Ângulo comercial** — "engenharia de harness" é vocabulário de 2026 que praticamente nenhum concorrente em PME brasileira usa. O pitch: "não entrego um bot, entrego um harness — o sistema que garante que o bot erra cada erro no máximo uma vez".

## Criação de skills e comandos próprios

O roadmap até aqui *usa* skills (Agent Skills, acima); esta seção é sobre **criar as suas**. Uma skill é um procedimento seu, documentado em markdown, que o agente carrega sob demanda — a diferença entre repetir a mesma instrução todo dia e tê-la como ativo versionado.

- [ ] **Anatomia de uma skill** — nome, quando disparar (gatilho), o procedimento passo a passo, e exemplos de uso. Se você explicou a mesma coisa ao agente duas vezes, é candidata a skill.
- [ ] **`/grill-me`** — a primeira skill a criar, usada ANTES de construir qualquer coisa: *"Me entreviste implacavelmente sobre cada aspecto deste plano até chegarmos a um entendimento compartilhado. Desça cada ramo da árvore de design, resolvendo as dependências entre decisões uma a uma."* Inverte o fluxo: em vez de a IA executar seu plano mal especificado, ela força você a especificá-lo. É o [[01 - Conceitos transversais|contrato]] sendo negociado antes do código — e casa direto com a sua preferência consultiva.
- [ ] **O trio de module awareness** — `/grill-me` (interrogar o plano) → `/write-a-prd` (consolidar o entendimento num PRD) → `/prd-to-issues` (quebrar o PRD em issues executáveis). Plano → especificação → trabalho rastreável, cada etapa com artefato.
- [ ] **Skills como ativo do negócio** — cada procedimento de cliente que vira skill (ex.: "como qualificar lead da clínica X", "checklist de deploy do bot de agendamento") é reutilizável no próximo cliente. É o mesmo argumento econômico do MCP, aplicado a conhecimento em vez de integração.

## Fontes

- **Building Effective Agents** — Anthropic, dez/2024. O documento mais importante do nível; reler a cada 2 meses. https://www.anthropic.com/engineering/building-effective-agents
- **Effective context engineering for AI agents** — Anthropic. https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- **Advanced tool use** — descoberta dinâmica de ferramentas; relevante quando o nº de ferramentas cresce. https://www.anthropic.com/engineering/advanced-tool-use
- **Documentação do MCP** e do Claude Agent SDK.
- **Tutoriais do LangGraph** — só depois do loop feito à mão. https://langchain-ai.github.io/langgraph/
- **Documentação do n8n** + comunidade de templates; documentação do Make.
- **What is an AI Agent Harness?** — Databricks. Definição operacional das camadas modelo/harness. https://www.databricks.com/blog/ai-harness
- **Harness Engineering for AI Coding Agents** — Augment Code. Genealogia do termo, PEV loops, rules files e quality gates. https://www.augmentcode.com/guides/harness-engineering-ai-coding-agents
- **What Is Harness Engineering AI? The Definitive 2026 Guide** — Atlan. O framing guides/sensors e os artefatos (AGENTS.md, constraint files). https://atlan.com/know/what-is-harness-engineering/

## Projetos (Ciclos 3, 4 e 6)

- Ciclo 3: automação ponta a ponta com n8n — primeiro item de portfólio; começa o building in public.
- Ciclo 4: o mesmo bot refeito em Python com function calling.
- Ciclo 6: mesmo bot em três versões (n8n, Python à mão, framework) comparando custo, tempo e confiabilidade. Sozinho, é um episódio inteiro do "For Business".

## Teste de saída

1. Consegue classificar seu projeto como workflow ou agente, e justificar?
2. Seu agente tem teto de iterações e orçamento por execução?
3. Nomeia os cinco padrões e diz qual serve para qual tarefa?
4. Explica por que "começar pela API direta" é depurabilidade, não purismo?
5. Defende o critério n8n vs código na frente do cliente?
6. O que acontece se uma ferramenta retornar erro no meio do loop?
