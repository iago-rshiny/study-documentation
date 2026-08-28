---
tipo: leituras
status: não iniciado
verificado: 2026-08-28
tags: [roadmap-ia, livros]
---

# Leituras paralelas

Livros lidos **em paralelo** aos níveis, não como pré-requisito. São o contrapeso de longo prazo: o roadmap ensina a stack de IA (que envelhece rápido); estes ensinam design e ofício (que não envelhecem). Ritmo sugerido: um capítulo por semana, com nota de 3 linhas por capítulo no vault.

## Os livros

- [ ] **A Philosophy of Software Design** — John Ousterhout
  Fonte do conceito de **deep vs shallow modules** usado no [[50 - Nível 5 - Agentes e arquitetura]]. Curto, direto, e o mais imediatamente aplicável dos quatro. **Ler primeiro**, junto com os Níveis 3-4: complexidade, information hiding, interfaces, "define errors out of existence".
  *Por que importa dobrado com IA:* agentes de código produzem módulos rasos por padrão; este livro dá o vocabulário para pedir (e reconhecer) o contrário.

- [ ] **The Pragmatic Programmer** — Hunt & Thomas (ed. 20 anos)
  O ofício em volta do código: DRY, ortogonalidade, tracer bullets, "broken windows", automação do próprio fluxo. Ler junto com o Nível 3 — várias práticas do nível (versionar prompts, todo bug vira teste, gestão de segredos) são casos particulares de princípios daqui.

- [ ] **The Design of Design** — Frederick P. Brooks
  Ensaios sobre o **processo** de design: como grandes decisões são tomadas, o papel do design conceitual único, por que comitês produzem design ruim, exemplos reais de projetos. Ler junto com o Nível 5 — é o pano de fundo intelectual do `/grill-me`: interrogar o design antes de construir é exatamente o que Brooks defende. (Do mesmo autor de *The Mythical Man-Month*.)

- [ ] **Domain-Driven Design** — Eric Evans *(estudar — não precisa ler capa a capa)*
  Linguagem ubíqua, bounded contexts, entidades vs. value objects, mapear o domínio ANTES de modelar o sistema. Denso; alternativa de entrada: *Domain-Driven Design Distilled* (Vaughn Vernon) e depois o Evans como referência.
  *Aplicação direta no negócio:* automatizar o atendimento de uma clínica exige primeiro mapear o domínio da clínica (o que é "agendamento", "encaixe", "retorno" NA LINGUAGEM DELES). DDD é a disciplina disso — e o `/grill-me` aplicado ao domínio do cliente é DDD informal.

- [ ] **Extreme Programming Explained** — Kent Beck *(bônus)*
  Origem do TDD como disciplina e do princípio que ancora o vault: *"Invest in the design of the system every day."* Conecta [[30 - Nível 3 - APIs e código]] (TDD como loop) e o `/improve-codebase-architecture` do Nível 5.

## Ordem sugerida

1. Ousterhout (Níveis 3-4) → 2. Pragmatic Programmer (Nível 3-5) → 3. Brooks (Nível 5) → 4. DDD (Nível 5-6, modo estudo) → 5. Beck (quando o TDD estiver rodando na prática).

## Critério de "aplicado"

Mesma regra dos conceitos: um livro só sai de `estudando` quando pelo menos um princípio dele apareceu num projeto rodando — e a nota do capítulo diz qual.
