# [github/spec-kit](https://github.com/github/spec-kit)

Предлагаемый AI-assisted SDLC:

- цикл: спецификация → план → задачи → реализация → проверка;
- отдельный процесс исправления багов: assessment → fix → test;
- инструкции для агентов в [AGENTS.md](https://github.com/github/spec-kit/blob/main/AGENTS.md);
- обязательные тестовые доказательства и human review;
- CI: pytest, Ruff, ShellCheck, CodeQL, dependency audit;
- [PR-шаблон](https://github.com/github/spec-kit/blob/main/.github/PULL_REQUEST_TEMPLATE.md) требует описать тестирование и использование AI;
- AI-вклад явно раскрывается;
- проект применяет собственный процесс к своей разработке.

## Порядок использования

### 1. Установить CLI

```bash
uv tool install specify-cli
```

Нужны Python 3.11+ и `uv`.

### 2. Инициализировать существующий репозиторий

Сначала убедитесь, что изменения сохранены в Git, затем:

```bash
specify init --here --force --integration cursor-agent
```

`--force` необходим для непустого проекта, поэтому после команды обязательно проверьте:

```bash
git diff
```

Будут добавлены `.specify/` и навыки в `.cursor/skills/`.

### 3. Задать правила проекта

В чате Cursor:

```text
/speckit-constitution

Следовать архитектуре и соглашениям существующего Laravel-приложения.
Не добавлять зависимости без согласования.
Проверять авторизацию на сервере.
Изменения поведения покрывать PHPUnit-тестами.
После изменений запускать релевантные тесты и Laravel Pint.
Миграции должны быть обратимыми.
```

Это выполняется один раз для проекта.

### 4. Разработать функцию

Каждую команду запускайте отдельно и проверяйте результат.

```text
/speckit-specify

Администратор должен видеть список всех бронирований.
Список содержит пользователя, дату, статус и объект бронирования.
Обычный пользователь не должен получать доступ к странице.
```

Затем:

```text
/speckit-clarify
```

AI задаст вопросы по неоднозначным требованиям.

```text
/speckit-plan

Используй установленную версию Laravel, существующую архитектуру,
Eloquent, policies и PHPUnit. Не добавляй новые зависимости.
```

Далее:

```text
/speckit-checklist
/speckit-tasks
/speckit-analyze
/speckit-implement
/speckit-converge
```

Если `converge` обнаружит пробелы, повторите:

```text
/speckit-implement
/speckit-converge
```

до результата `Converged`.


[Официальная инструкция для существующих проектов](https://github.com/github/spec-kit/blob/main/docs/how-to/existing-projects.md) · [Интеграция с Cursor](https://github.com/github/spec-kit/blob/main/docs/integrations/cursor-agent.md)