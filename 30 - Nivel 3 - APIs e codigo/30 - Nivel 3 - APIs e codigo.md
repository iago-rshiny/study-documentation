---
nível: 3
duração: 4-6 semanas
status: não iniciado
perecibilidade: média
verificado: 2026-08-28
tags: [roadmap-ia, nivel-3]
---

# Nível 3 — APIs e código

**Objetivo:** entregar automação simples de verdade. A partir daqui a proporção inverte: 70% prática / 30% estudo.

## Conceitos

- [ ] **Fluência em Python de automação** — pré-requisito. Não é Python de cientista de dados (notebook, dados em memória), é Python de serviço: funções separadas, try/except real, variáveis de ambiente, requests/SDK, venv, Pydantic básico.
- [ ] **Anatomia de uma chamada de API** — endpoint, autenticação, system vs messages, max_tokens, temperature, objeto de resposta e `usage` (onde se lê o custo).
- [ ] **Client tools vs server tools** — client: você define schema, executa e devolve `tool_result`; server (web search, code execution): o provedor executa, com cobrança adicional por uso. Client tools custam como chamada normal.
- [ ] **Definição de ferramenta como prompt** — a API constrói um system prompt a partir das definições de ferramentas. Descrição ruim = prompt ruim. Exemplos de input custam ~20-50 tokens (simples) a ~100-200 (aninhados).
- [ ] **`tool_choice`** — forçar o uso de uma ferramenta específica. Resolve "o bot respondeu de cabeça em vez de consultar a agenda".
- [ ] **O modelo nunca executa nada** — ele devolve a *intenção* de chamar a função com argumentos; quem executa é o seu código. Pré-requisito conceitual do loop ReAct.
- [ ] **Structured outputs com Pydantic** — schema vira classe, validação vira código, erro vira exceção tratável. Toda saída de LLM é entrada não-confiável até validada.
- [ ] **Erros 429 vs 529** — 429 = rate limit (seu lado: desacelerar ou subir tier; dimensões RPM/ITPM/OTPM); 529 = overload do provedor (retry + eventual fallback de provedor). Parecem iguais no log, pedem respostas opostas.
- [ ] **Retry, backoff exponencial e jitter** — ordem: `retry-after` primeiro → headers de reset → backoff com jitter (quebra thundering herd).
- [ ] **Retries nativos do SDK** — os SDKs oficiais já re-tentam falhas transitórias (conexão, 429, 5xx) com backoff, 2x por padrão, honrando retry-after. Aumentar `max_retries` em vez de escrever loop próprio.
- [ ] **Timeout e interações** — timeout padrão do cliente é 10 min e timeouts também são re-tentados.
- [ ] **Gestão de segredos** — chave fora do código e fora do Git. Erro mais comum de iniciante. (Já aprendido na prática: duas rotações de chave.)
- [ ] **Escolha de modelo por tarefa** — modelo pequeno para classificação, grande para raciocínio. Errar multiplica custo por 10 sem ganho.
- [ ] **Prompt caching como throughput** — tokens cacheados não contam para ITPM na maioria dos modelos atuais: cache eleva o teto, não só reduz custo.

## Feedback loops de desenvolvimento

O conceito que amarra este nível: **encurtar o tempo entre escrever algo e descobrir se está certo**. Quanto mais curto o loop, mais rápido você aprende — e mais seguro fica delegar código a um agente, porque o loop vira o verificador automático do que a IA produziu.

- [ ] **Tipos estáticos** — o loop mais curto (segundos): type hints + Pydantic + um checker (mypy/pyright) pegam erro antes de rodar. Em saída de LLM, o schema validado É o tipo estático da fronteira modelo↔código.
- [ ] **Testes automatizados** — o loop de minutos: pytest rodando a cada mudança. Todo bug encontrado vira teste; a suíte é a memória do projeto.
- [ ] **Execução real / acesso ao browser** — o loop de verdade-terreno: rodar contra o dado real (o CSV da Olist, o WhatsApp de teste) e, em automação web, ver o resultado renderizado. Fecha o que tipo e teste não cobrem.
- [ ] **TDD como loop** — red-green-refactor: escrever o teste antes, vê-lo falhar (red), implementar o mínimo até passar (green), refatorar com a rede de segurança armada. Usado aqui de dois jeitos: (1) como método seu de aprender — o teste força você a definir o comportamento antes de escrever; (2) como **guardrail de agente de código** — quando quem escreve é a IA, o teste é o critério objetivo que fecha o ciclo: o agente itera até a suíte passar, e você revisa design em vez de caçar bug. Conecta com [[60 - Nivel 6 - Producao e avaliacao]]: eval é TDD aplicado a comportamento de LLM.

Referência de espírito: *"Invest in the design of the system every day"* — Kent Beck, Extreme Programming Explained. Ver [[70 - Leituras paralelas]].

## Fontes

- **How tool use works** — o round trip completo. https://platform.claude.com/docs/en/agents-and-tools/tool-use/how-tool-use-works
- **Define tools** — schema, tool_choice, propriedades. https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/implement-tool-use
- **Tutorial: build a tool-using agent** — de uma chamada até um loop de produção; ponte para o Nível 5. https://platform.claude.com/docs/en/agents-and-tools/tool-use/overview
- **Rate limits + referência de erros** — fonte primária. https://platform.claude.com/docs/en/api/rate-limits
- **Anthropic Cookbook** — notebooks executáveis; rodar, quebrar de propósito, ler o erro. https://github.com/anthropics/anthropic-cookbook
- **Documentação do Pydantic** — BaseModel e validação.
- **Automate the Boring Stuff with Python** — gratuito; cobre o gap Python-de-estatística → Python-de-script.

## Projetos (Ciclos 1 e 2)

Script que interpreta CSV (Olist) → classificador com saída JSON validada → primeira ferramenta via function calling (consultar planilha, calcular data).

## Teste de saída

1. Seu script sobrevive a um timeout da API sem morrer?
2. Você sabe quanto custou cada chamada, em reais?
3. Sabe explicar por que o modelo "não executa" a função?
4. O que acontece quando o JSON volta malformado?
5. Está reescrevendo retry que o SDK já faz?
6. Chaves fora do código e fora do Git?
