# Как создать плагин Cursor по шаблону

Плагин — это папка с манифестом и компонентами: правилами, навыками, агентами,
командами, хуками и MCP-серверами. Шаблон лежит в
[`templates/plugin/`](../templates/plugin/).

Инструкция основана на официальной документации:
[Plugins](https://cursor.com/docs/plugins) и
[Plugins reference](https://cursor.com/docs/reference/plugins).

## Шаг 1. Скопируйте шаблон

Из корня этого репозитория:

```bash
cp -R templates/plugin ~/my-plugin
```

Имя папки и плагина — строчными буквами через дефис (`my-plugin`).

## Шаг 2. Заполните манифест

Откройте [`.cursor-plugin/plugin.json`](../templates/plugin/.cursor-plugin/plugin.json).
Это единственный обязательный файл плагина, а в нём обязательно только поле `name`.

1. Задайте `name`, `description`, `version`, `author`.
2. Удалите поля `rules`, `agents`, `skills`, `commands`, `hooks`, `mcpServers`.
   При стандартных папках они не нужны: Cursor сам находит компоненты.
   Если их оставить, а папку удалить, путь в манифесте станет неверным.
3. Удалите `variables`, если плагину не нужны токены и другие настройки.

Что значит каждое поле — в
[`plugin.annotated.jsonc`](../templates/plugin/.cursor-plugin/plugin.annotated.jsonc).

> Формат JSON не допускает комментариев, поэтому пояснения к JSON-файлам
> шаблона лежат в соседних файлах `*.annotated.jsonc`.

## Шаг 3. Оставьте только нужные компоненты

Плагин может содержать любое сочетание компонентов. Для первого плагина хватит
манифеста и одного навыка или правила. Остальные папки удалите.

| Что нужно плагину | Файл в шаблоне | Что сделать |
| --- | --- | --- |
| Постоянные указания для AI | [`rules/coding-standards.mdc`](../templates/plugin/rules/coding-standards.mdc) | Заменить текст правила, настроить `description`, `alwaysApply`, `globs` |
| Пошаговый сценарий для агента | [`skills/code-reviewer/SKILL.md`](../templates/plugin/skills/code-reviewer/SKILL.md) | Переименовать папку, указать то же имя в `name`, написать `description` и инструкции |
| Отдельный агент со своей ролью | [`agents/security-reviewer.md`](../templates/plugin/agents/security-reviewer.md) | Задать `name`, `description`, написать промпт |
| Действие, которое выполняет агент | [`commands/deploy-staging.md`](../templates/plugin/commands/deploy-staging.md) | Задать `name`, `description`, описать шаги |
| Скрипты по событиям агента | [`hooks/hooks.json`](../templates/plugin/hooks/hooks.json) и [`scripts/`](../templates/plugin/scripts/) | Оставить только нужные события, написать скрипты |
| Подключение внешних сервисов | [`mcp.json`](../templates/plugin/mcp.json) | Заменить примеры серверов своими |

Правила, навыки, агенты и команды — это Markdown-файлы с блоком настроек
в начале (YAML-frontmatter). Пояснения к каждой настройке написаны прямо в файлах.

Обратите внимание:

- **Хуки.** В шаблоне подключены все события сразу. Если хуки не нужны, удалите
  папки `hooks/` и `scripts/` целиком. Если нужны — оставьте в `hooks.json`
  только свои события (пояснения — в
  [`hooks.annotated.jsonc`](../templates/plugin/hooks/hooks.annotated.jsonc))
  и выполните `chmod +x scripts/*.sh`.
- **Секреты.** Токены и пароли в файлы плагина не записывают. В `mcp.json`
  ставят плейсхолдер `${ИМЯ}`, а имя объявляют в поле `variables` манифеста.
  Значение пользователь задаёт в дашборде: Plugins → Configure. Пример —
  в [`mcp.annotated.jsonc`](../templates/plugin/mcp.annotated.jsonc).

## Шаг 4. Проверьте плагин локально

1. Скопируйте папку плагина в `~/.cursor/plugins/local/my-plugin`.
2. Перезапустите Cursor или выполните команду **Developer: Reload Window**.
3. Откройте **Customize** и убедитесь, что компоненты плагина появились.

Копируйте папку, а не создавайте символическую ссылку: ссылку на папку за
пределами `~/.cursor/plugins/local` Cursor пропускает. На тарифе Enterprise
локальный импорт плагинов должен разрешить администратор.

## Шаг 5. Опубликуйте (по желанию)

1. Перепишите [`README.md`](../templates/plugin/README.md): что делает плагин
   и как его настроить.
2. Удалите файлы `*.annotated.jsonc` и `marketplace.example.*` — плагину они
   не нужны.
3. Выложите плагин в публичный Git-репозиторий.
4. Пройдите чек-лист в конце [`README.md`](../templates/plugin/README.md) шаблона.
5. Отправьте ссылку на репозиторий на
   [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish).
   Каждый плагин проверяют вручную перед публикацией.

Если в одном репозитории несколько плагинов, в его корень добавляют
`.cursor-plugin/marketplace.json`. Пример —
[`marketplace.example.json`](../templates/plugin/.cursor-plugin/marketplace.example.json).
