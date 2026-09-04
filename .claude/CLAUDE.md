# Vault de documentação de estudo — roadmap de IA

Este repositório é um vault Obsidian, não um projeto de código. O "produto" aqui
são notas que o dono do vault vai reler daqui a seis meses.

## Antes de escrever qualquer coisa

Carregue a skill **`registrar-estudo`**. Ela contém as convenções completas:
estrutura de pastas, modelos de entrada, regras de nomenclatura e a regra central
do método.

O vault é organizado por **nível** e, dentro dele, por **tópico** — os itens da
checklist `## Conceitos` da nota do nível. Registrar uma sessão é marcar o tópico
(`- [ ]` → `- [x]`) **e** escrever a entrada no diário daquele nível.

A regra central, repetida aqui porque é a que se perde — a entrada de diário tem
dois campos com donos diferentes:

> `### O que foi coberto na conversa` é **do agente**: resumo factual do terreno.
> `### O que entendi (minhas palavras)` é **só do usuário**. Onde ele não escreveu
> com as próprias palavras, deixe uma lacuna marcada — nunca preencha para "ficar
> completo", e nunca com material do primeiro campo.

O método está em `02 - Metodo de estudo.md` e vale mais que qualquer instrução
que você invente. Em conflito, o método vence.

## Invariantes

- **Nomes de arquivo sem acento e sem cedilha.** É o que evita link quebrado.
- **Checkbox só é marcado quando o tópico fecha:** o usuário disse que terminou,
  explicou com as próprias palavras, ou aplicou em código que rodou. Discutir não
  é fechar. Nunca desmarcar.
- **Diário é histórico:** só se acrescenta, nunca se reescreve entrada antiga.
- **Nota de conceito só quando o conceito fecha.** Nunca crie preventivamente.
- **`status: aplicado em projeto`** exige código que rodou. Não promova sozinho.
- **`verificado`** é obrigatório nos níveis 5 e 6 (perecibilidade alta).
- Não toque em `00`, `01`, `02`, `70` sem pedido explícito — são notas de
  estrutura, não de registro.
- Não commite no git sem o usuário pedir.

## O que é gerado e não deve ser editado à mão

- `90 - Sistema/91 - Painel de progresso.md` — regenerado por
  `.claude/scripts/indexar-vault.ps1` a partir do frontmatter das notas.
- `.claude/fila-de-sessoes.jsonl` — fila escrita pelo hook `SessionEnd`.
  Não versionada.

## Scripts

| Script | O que faz | Chamado por |
|---|---|---|
| `capturar-sessao.ps1` | Enfileira metadados da sessão encerrada | hook `SessionEnd` |
| `indexar-vault.ps1` | Regenera o painel de progresso | agente, ao fim de um registro |
| `fechar-fila.ps1` | Marca item da fila como processado | agente |
| `verificar-vault.ps1` | Checa links quebrados, notas órfãs e entradas sem âncora de tópico | você, para auditar; sai com código 1 se achar problema |

Todos são determinísticos: sem LLM, sem rede, sem token.

Explicação da arquitetura: `90 - Sistema/90 - Como funciona a automacao.md`.
