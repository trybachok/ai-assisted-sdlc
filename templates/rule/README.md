# Шаблоны правил Cursor

Заготовки для правил (rules) всех типов по официальной документации:
[Rules](https://cursor.com/docs/rules).

Правило — постоянная инструкция для AI-агента. Как выбрать тип правила и как
им пользоваться, простыми словами описано в
[`docs/cursor-rules.md`](../../docs/cursor-rules.md).

## Структура

```text
templates/rule/
├── always-apply.mdc             # Project Rule: действует в каждом чате
├── apply-intelligently.mdc      # Project Rule: агент подключает сам по описанию
├── apply-to-specific-files.mdc  # Project Rule: подключается по glob-шаблону файлов
├── apply-manually.mdc           # Project Rule: только по упоминанию через @
├── AGENTS.template.md           # AGENTS.md: простые указания без настроек
├── user-rule.md                 # User Rule: личное правило для всех проектов
├── team-rule.md                 # Team Rule: правило для всей команды
└── README.md                    # этот файл (в проект не копируется)
```

## Какой шаблон выбрать

| Тип правила | Шаблон | Когда правило действует | Куда поместить | Промпт |
| --- | --- | --- | --- | --- |
| Project Rule: Always Apply | [`always-apply.mdc`](always-apply.mdc) | В каждом чате проекта | `.cursor/rules/` | [создать](../../prompts/create-rule-always-apply.md) |
| Project Rule: Apply Intelligently | [`apply-intelligently.mdc`](apply-intelligently.mdc) | Когда агент по описанию решит, что правило относится к задаче | `.cursor/rules/` | [создать](../../prompts/create-rule-apply-intelligently.md) |
| Project Rule: Apply to Specific Files | [`apply-to-specific-files.mdc`](apply-to-specific-files.mdc) | Когда агент работает с файлом, подходящим под glob-шаблон | `.cursor/rules/` | [создать](../../prompts/create-rule-apply-to-specific-files.md) |
| Project Rule: Apply Manually | [`apply-manually.mdc`](apply-manually.mdc) | Когда правило упомянули в чате через `@` | `.cursor/rules/` | [создать](../../prompts/create-rule-apply-manually.md) |
| `AGENTS.md` | [`AGENTS.template.md`](AGENTS.template.md) | При работе с проектом; файл из подпапки — при работе с файлами этой папки | Корень проекта или подпапка, под именем `AGENTS.md` | [создать](../../prompts/create-rule-agents-md.md) |
| User Rule | [`user-rule.md`](user-rule.md) | Во всех ваших проектах | Cursor: **Customize → Rules** | [создать](../../prompts/create-rule-user.md) |
| Team Rule | [`team-rule.md`](team-rule.md) | Во всех проектах команды | [Дашборд Cursor](https://cursor.com/dashboard/team-content), тарифы Team и Enterprise | [создать](../../prompts/create-rule-team.md) |

Если правила противоречат друг другу, главнее Team Rules, затем Project Rules,
затем User Rules.

## Настройки Project Rule

Project Rule — файл `.mdc`. Он начинается с блока настроек (frontmatter) между
двумя строками `---`, ниже идёт текст правила в формате Markdown. Тип правила
задаёт сочетание трёх полей:

| Тип правила | `alwaysApply` | `description` | `globs` |
| --- | --- | --- | --- |
| Always Apply | `true` | не нужен, игнорируется | не нужен, игнорируется |
| Apply Intelligently | `false` | **обязателен** | не указывать |
| Apply to Specific Files | `false` | не нужен | **обязателен** |
| Apply Manually | `false` | не указывать | не указывать |

| Поле | Назначение |
| --- | --- |
| `alwaysApply` | `true` — правило включается в каждый чат; `false` — подключается по `globs`, по `description` или вручную |
| `description` | О чём правило и когда его применять. По описанию агент решает, подключать ли правило |
| `globs` | Glob-шаблоны файлов, к которым относится правило. Несколько шаблонов перечисляют через запятую |

В блоке настроек оставляйте только эти поля, каждое — в одну строку. Не
добавляйте туда комментарии и не переносите значение на следующую строку:
Cursor может прочитать такие настройки неверно, и правило получит другой тип.
Поэтому пояснения в шаблонах вынесены из блока настроек в комментарий
`<!-- ... -->` под ним.

## Как пользоваться шаблоном

### Project Rule

1. Скопируйте шаблон нужного типа в папку `.cursor/rules/` своего проекта под
   понятным именем, например из корня этого репозитория:

   ```bash
   mkdir -p ~/my-project/.cursor/rules
   cp templates/rule/apply-to-specific-files.mdc ~/my-project/.cursor/rules/docs-style.mdc
   ```

2. Сохраните расширение `.mdc`: файлы `.md` в `.cursor/rules/` Cursor
   игнорирует. Правила можно раскладывать по подпапкам, например
   `.cursor/rules/frontend/components.mdc`.
3. Настройте блок в начале файла: впишите свой `description` или `globs`.
4. Замените текст в квадратных скобках своими указаниями.
5. Удалите поясняющий комментарий `<!-- ... -->`: текст правила целиком
   попадает в контекст модели.

### AGENTS.md

1. Скопируйте шаблон в корень своего проекта под именем `AGENTS.md`:

   ```bash
   cp templates/rule/AGENTS.template.md ~/my-project/AGENTS.md
   ```

2. Замените текст в квадратных скобках, ненужные разделы удалите.
3. Удалите поясняющий комментарий.

Шаблон намеренно назван `AGENTS.template.md`: файл с именем `AGENTS.md` Cursor
применяет автоматически, в том числе из подпапок.

### User Rule и Team Rule

Это не файлы проекта: текст из шаблона переносят в Cursor вручную.

- **User Rule.** Заполните [`user-rule.md`](user-rule.md), скопируйте текст
  под комментарием и добавьте его в Cursor: **Customize → Rules**.
- **Team Rule.** Заполните [`team-rule.md`](team-rule.md) и передайте его
  администратору команды. Администратор создаёт правило в
  [дашборде Cursor](https://cursor.com/dashboard/team-content), выставляет
  настройки из таблицы и вставляет текст из раздела «Текст правила».

## Glob-шаблоны

Glob-шаблон описывает сразу много файлов: `*` заменяет имя или часть имени
на одном уровне, `**` — любое число вложенных папок. Шаблон указывают в поле
`globs` у Project Rule и в настройках Team Rule.

| Шаблон | Какие файлы подходят |
| --- | --- |
| `*.ts` | Все файлы `.ts` в корне проекта |
| `**/*.ts` | Все файлы `.ts` в любой папке |
| `src/**` | Все файлы внутри `src/` |
| `src/**/*.tsx` | Все файлы `.tsx` внутри `src/` |
| `docs/**/*.md, docs/**/*.mdx` | Файлы `.md` и `.mdx` внутри `docs/` (два шаблона через запятую) |
| `tailwind.config.*` | Файл `tailwind.config` с любым расширением |

## Проверка

1. Откройте **Customize** в боковой панели и перейдите в раздел **Rules**:
   правило должно быть в списке, а его тип — совпадать с задуманным.
2. Откройте новый чат и дайте агенту задачу, в которой правило должно
   сработать. Правило типа Apply Manually вызовите через `@` и имя файла
   без расширения, например `@migration-guide`.
3. Если правило не сработало, проверьте:
   - файл лежит в `.cursor/rules/` и имеет расширение `.mdc`;
   - у правила Apply Intelligently заполнен `description`;
   - у правила Apply to Specific Files `globs` подходит к вашим файлам.

Правила действуют только на агента в чате: на автодополнение Cursor Tab
и другие AI-функции они не влияют.

## Как поделиться правилами

Project Rule и `AGENTS.md` достаточно сохранить в git вместе с проектом: их
получит каждый, кто работает с репозиторием.

В другие проекты правила из репозитория сами по себе не импортируются: их
упаковывают в плагин и публикуют через маркетплейс. Шаблон плагина —
[`templates/plugin/`](../plugin/README.md), инструкция —
[`docs/cursor-plugin.md`](../../docs/cursor-plugin.md).

У правила внутри плагина свой шаблон —
[`rules/coding-standards.mdc`](../plugin/rules/coding-standards.mdc). В папку
`.cursor/rules/` его не копируйте: в его блоке настроек есть комментарии.
