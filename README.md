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
- Готовые решения
  - [spec-kit](examples/spec-kit.md)