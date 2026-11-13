В `github/spec-kit` используются два слоя:

1. Активный ruleset `Automatic Copilot code reviews` для всех веток автоматически назначает Copilot ревьюером нового PR.
2. Файл [`.github/skills/code-review/SKILL.md`](https://github.com/github/spec-kit/blob/main/.github/skills/code-review/SKILL.md) задаёт правила ревью: проверять тесты, regression evidence, архитектурные документы и терминологию.

Дополнительный контекст Copilot получает из [`AGENTS.md`](https://github.com/github/spec-kit/blob/main/AGENTS.md).

Чтобы повторить:

1. Открыть `Repository → Settings → Rules → Rulesets`.
2. Создать branch ruleset.
3. Выбрать нужные ветки.
4. Включить `Automatically request Copilot code review`.
5. При необходимости включить:
   - `Review new pushes`;
   - `Review draft pull requests`.
6. Настроить глубину в `Settings → Copilot → Code review`.

Затем добавить собственный навык:

```markdown
---
name: code-review
description: Reviews Laravel changes for correctness, security, tests, and project conventions.
---

# Code Review

1. Check authentication and authorization.
2. Check input validation.
3. Detect N+1 database queries.
4. Require regression tests for bug fixes.
5. Check migrations for safe rollback.
6. Verify that existing Laravel conventions are followed.
7. Report only specific, actionable issues with file and line references.
```

Путь должен быть:

```text
.github/skills/code-review/SKILL.md
```

Важно: сам `SKILL.md` определяет, **что проверять**. Автоматический запуск обеспечивает ruleset. В [PR 5386](https://github.com/github/spec-kit/pull/5386) после второго commit Copilot был запрошен повторно; ruleset этого репозитория сам по себе не настроен на ревью каждого push.

[Официальная инструкция GitHub](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/configure-code-review)