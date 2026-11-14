# ai-assisted-sdlc

Памятка по внедрению AI в процессы разработки.

## Рабочий цикл AI-assisted SDLC

1. Сформулировать цель и критерии приёмки.
2. Дать AI изучить код без изменений.
3. Проверить его факты и предположения.
4. Запросить минимальный атомарный diff.
5. Просмотреть каждую изменённую строку.
6. Запустить тесты, линтеры и статический анализ.
7. Проверить безопасность и граничные случаи.
8. Зафиксировать результат в commit/PR.

## Этапы

* constitution — постоянные правила проекта;
* specify — что и зачем нужно сделать;
* clarify — какие требования неясны;
* plan — как реализовать;
* tasks — последовательность изменений;
* implement — написание кода;
* converge — соответствует ли код требованиям.
---
Содержание:
- Промпты
  - [простая задача](prompts/simple-task.md)
  - [создание Cursor Skill](prompts/create-skill.md)
  - [создание Cursor Plugin](prompts/create-plugin.md)
  - создание Cursor Rule — отдельный промпт для каждого типа правила:
    - [Always Apply](prompts/create-rule-always-apply.md)
    - [Apply Intelligently](prompts/create-rule-apply-intelligently.md)
    - [Apply to Specific Files](prompts/create-rule-apply-to-specific-files.md)
    - [Apply Manually](prompts/create-rule-apply-manually.md)
    - [AGENTS.md](prompts/create-rule-agents-md.md)
    - [User Rule](prompts/create-rule-user.md)
    - [Team Rule](prompts/create-rule-team.md)
  - создание Cursor Subagent — отдельный промпт для каждого типа субагента:
    - [Project subagent](prompts/create-subagent-project.md)
    - [User subagent](prompts/create-subagent-user.md)
    - [Read-only subagent](prompts/create-subagent-readonly.md)
    - [Background subagent](prompts/create-subagent-background.md)
    - [Cloud subagent](prompts/create-subagent-cloud.md)
  - создание Cursor Hook — отдельный промпт для каждого типа хука:
    - [Project hooks](prompts/create-hook-project.md)
    - [User hooks](prompts/create-hook-user.md)
    - [Team hooks](prompts/create-hook-team.md)
    - [Enterprise hooks](prompts/create-hook-enterprise.md)
    - [Command-based hooks](prompts/create-hook-command-based.md)
    - [Prompt-based hooks](prompts/create-hook-prompt-based.md)
    - [Agent hooks](prompts/create-hook-agent.md)
    - [Tab hooks](prompts/create-hook-tab.md)
    - [App lifecycle hooks](prompts/create-hook-app-lifecycle.md)
- Ревью кода
  - [настройка Copilot](docs/copilot-github-ruleset.md)
- Плагины Cursor
  - [как создать плагин по шаблону](docs/cursor-plugin.md)
  - [шаблон плагина](templates/plugin/README.md)
- Навыки Cursor
  - [шаблон навыка](templates/skill/README.md)
- Правила Cursor
  - [как создавать и использовать правила](docs/cursor-rules.md)
  - [шаблоны правил](templates/rule/README.md):
    - [Always Apply](templates/rule/always-apply.mdc) — действует в каждом чате
    - [Apply Intelligently](templates/rule/apply-intelligently.mdc) — агент подключает сам по описанию
    - [Apply to Specific Files](templates/rule/apply-to-specific-files.mdc) — подключается по файлам
    - [Apply Manually](templates/rule/apply-manually.mdc) — только по упоминанию через `@`
    - [AGENTS.md](templates/rule/AGENTS.template.md) — простые указания для проекта
    - [User Rule](templates/rule/user-rule.md) — личное правило для всех проектов
    - [Team Rule](templates/rule/team-rule.md) — правило для всей команды
- Субагенты Cursor
  - [как создавать и использовать субагентов](docs/cursor-subagents.md)
  - [шаблоны субагентов](templates/subagent/README.md):
    - [Project subagent](templates/subagent/project-subagent.md) — помощник одного проекта, общий для команды
    - [User subagent](templates/subagent/user-subagent.md) — личный помощник во всех проектах
    - [Read-only subagent](templates/subagent/readonly-subagent.md) — проверяет и ничего не изменяет
    - [Background subagent](templates/subagent/background-subagent.md) — работает в фоне
    - [Cloud subagent](templates/subagent/cloud-subagent.md) — задача для запуска в облаке
- Хуки Cursor
  - [как создавать и использовать хуки](docs/cursor-hooks.md)
  - [шаблоны хуков](templates/hook/README.md):
    - [Project hooks](templates/hook/project-hooks.json) ([пояснения](templates/hook/project-hooks.annotated.jsonc)) — хуки одного проекта, общие для команды
    - [User hooks](templates/hook/user-hooks.json) ([пояснения](templates/hook/user-hooks.annotated.jsonc)) — личные хуки во всех проектах
    - [Team hooks](templates/hook/team-hooks.md) — хук для всей команды, настраивается в дашборде
    - [Enterprise hooks](templates/hook/enterprise-hooks.json) ([пояснения](templates/hook/enterprise-hooks.annotated.jsonc)) — хуки организации
    - [Command-based hooks](templates/hook/command-based-hooks.json) ([пояснения](templates/hook/command-based-hooks.annotated.jsonc)) — хук запускает скрипт
    - [Prompt-based hooks](templates/hook/prompt-based-hooks.json) ([пояснения](templates/hook/prompt-based-hooks.annotated.jsonc)) — условие проверяет AI-модель
    - [Agent hooks](templates/hook/agent-hooks.json) ([пояснения](templates/hook/agent-hooks.annotated.jsonc)) — события агента в чате
    - [Tab hooks](templates/hook/tab-hooks.json) ([пояснения](templates/hook/tab-hooks.annotated.jsonc)) — события автодополнения Tab
    - [App lifecycle hooks](templates/hook/app-lifecycle-hooks.json) ([пояснения](templates/hook/app-lifecycle-hooks.annotated.jsonc)) — Cursor открыл проект
  - скрипты-заготовки для хуков:
    - [permission-hook.sh](templates/hook/hooks/permission-hook.sh) — разрешить или запретить действие
    - [observe-hook.sh](templates/hook/hooks/observe-hook.sh) — наблюдать за событием
    - [before-submit-prompt-hook.sh](templates/hook/hooks/before-submit-prompt-hook.sh) — проверить запрос перед отправкой
    - [stop-hook.sh](templates/hook/hooks/stop-hook.sh) — продолжить работу агента
    - [session-start-hook.sh](templates/hook/hooks/session-start-hook.sh) — добавить сведения в новый чат
    - [workspace-open-hook.sh](templates/hook/hooks/workspace-open-hook.sh) — подключить плагины при открытии проекта
- Готовые решения
  - [spec-kit](examples/spec-kit.md)