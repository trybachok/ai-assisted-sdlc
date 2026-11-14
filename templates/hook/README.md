# Шаблоны хуков Cursor

Заготовки для хуков (hooks) всех типов по официальной документации:
[Hooks](https://cursor.com/docs/hooks).

Хук — действие, которое Cursor выполняет сам в определённый момент работы:
перед командой в терминале, после правки файла, при отправке запроса. Хук
может наблюдать за событием, запретить действие или изменить его. Как выбрать
тип хука и как им пользоваться, простыми словами описано в
[`docs/cursor-hooks.md`](../../docs/cursor-hooks.md).

## Структура

```text
templates/hook/
├── project-hooks.json        # Project hooks: хуки одного проекта
├── user-hooks.json           # User hooks: личные хуки для всех проектов
├── team-hooks.md             # Team hooks: форма для дашборда команды
├── enterprise-hooks.json     # Enterprise hooks: хуки организации
├── command-based-hooks.json  # Command-based hooks: хук запускает скрипт
├── prompt-based-hooks.json   # Prompt-based hooks: условие проверяет AI-модель
├── agent-hooks.json          # Agent hooks: 18 событий агента в чате
├── tab-hooks.json            # Tab hooks: 2 события автодополнения Tab
├── app-lifecycle-hooks.json  # App lifecycle hooks: Cursor открыл проект
├── *.annotated.jsonc         # копии файлов .json с пояснениями
├── hooks/                    # скрипты-заготовки
│   ├── permission-hook.sh            # разрешить или запретить действие
│   ├── observe-hook.sh               # наблюдать за событием
│   ├── before-submit-prompt-hook.sh  # проверить запрос перед отправкой
│   ├── stop-hook.sh                  # продолжить работу агента
│   ├── session-start-hook.sh         # добавить сведения в новый чат
│   └── workspace-open-hook.sh        # подключить плагины при открытии проекта
└── README.md                 # этот файл (в проект не копируется)
```

У каждого файла `.json` есть копия `*.annotated.jsonc`: те же настройки
и пояснение к каждой строке. В формате JSON комментариев нет, поэтому рабочие
файлы оставлены чистыми. В проект копируют только файл `.json`: копию
с пояснениями Cursor не читает.

## Какой шаблон выбрать

Тип хука — это ответ на три вопроса: где хук хранится, как он выполняется
и что его запускает. Варианты ответов взяты из документации; для каждого есть
шаблон и промпт.

### Где хранится хук

| Тип хука | Шаблон | Чем отличается | Куда поместить | Промпт |
| --- | --- | --- | --- | --- |
| Project hooks | [`project-hooks.json`](project-hooks.json), [пояснения](project-hooks.annotated.jsonc) | Хуки одного проекта: хранятся в git и действуют у всех, кто открыл проект | `.cursor/hooks.json` проекта, скрипты — в `.cursor/hooks/` | [создать](../../prompts/create-hook-project.md) |
| User hooks | [`user-hooks.json`](user-hooks.json), [пояснения](user-hooks.annotated.jsonc) | Личные: действуют во всех ваших проектах на этом компьютере | `~/.cursor/hooks.json`, скрипты — в `~/.cursor/hooks/` | [создать](../../prompts/create-hook-user.md) |
| Team hooks | [`team-hooks.md`](team-hooks.md) | Для всей команды: администратор настраивает хук в дашборде, Cursor сам доставляет его участникам. Только тариф Enterprise | Не файл проекта: [дашборд Cursor](https://cursor.com/dashboard/team-content?section=hooks) | [создать](../../prompts/create-hook-team.md) |
| Enterprise hooks | [`enterprise-hooks.json`](enterprise-hooks.json), [пояснения](enterprise-hooks.annotated.jsonc) | Для всех пользователей компьютера: файлы раздаёт IT-отдел через систему управления устройствами (MDM) | Системная папка: путь зависит от операционной системы, см. ниже | [создать](../../prompts/create-hook-enterprise.md) |

Cursor выполняет все подходящие хуки всех уровней. Если они отвечают
по-разному, побеждает самый строгий ответ: запрет главнее вопроса, вопрос
главнее разрешения — на каком бы уровне ни был хук.

### Как выполняется хук

| Тип хука | Шаблон | Чем отличается | Куда поместить | Промпт |
| --- | --- | --- | --- | --- |
| Command-based hooks | [`command-based-hooks.json`](command-based-hooks.json), [пояснения](command-based-hooks.annotated.jsonc) | Хук запускает скрипт. Тип по умолчанию: работает везде, каждый раз одинаково | Запись в `hooks.json` и скрипт рядом | [создать](../../prompts/create-hook-command-based.md) |
| Prompt-based hooks | [`prompt-based-hooks.json`](prompt-based-hooks.json), [пояснения](prompt-based-hooks.annotated.jsonc) | Условие записано обычными словами, его проверяет AI-модель. Скрипт не нужен. Не работает в облачных агентах и в плагинах | Запись в `hooks.json` | [создать](../../prompts/create-hook-prompt-based.md) |

### Что запускает хук

| Тип хука | Шаблон | Чем отличается | Куда поместить | Промпт |
| --- | --- | --- | --- | --- |
| Agent hooks | [`agent-hooks.json`](agent-hooks.json), [пояснения](agent-hooks.annotated.jsonc) | 18 событий агента в чате: команды, файлы, инструменты, субагенты, запросы | Нужные события — в `hooks.json` | [создать](../../prompts/create-hook-agent.md) |
| Tab hooks | [`tab-hooks.json`](tab-hooks.json), [пояснения](tab-hooks.annotated.jsonc) | 2 события автодополнения Tab — подсказок в редакторе | Нужные события — в `hooks.json` | [создать](../../prompts/create-hook-tab.md) |
| App lifecycle hooks | [`app-lifecycle-hooks.json`](app-lifecycle-hooks.json), [пояснения](app-lifecycle-hooks.annotated.jsonc) | 1 событие вне чата: Cursor открыл проект | Событие — в `hooks.json` | [создать](../../prompts/create-hook-app-lifecycle.md) |

Настоящий хук отвечает на все три вопроса сразу. Например: хук проекта
(Project hooks) запускает скрипт (Command-based hooks) после того, как агент
изменил файл (Agent hooks). Начните с шаблона, который отвечает на самый
важный для вас вопрос, а остальное допишите по другим шаблонам. Если
сомневаетесь, возьмите `project-hooks.json`.

- Хуки внутри плагина — отдельный случай. Их шаблон —
  [`templates/plugin/hooks/`](../plugin/hooks/hooks.annotated.jsonc).
- По документации Cursor загружает также хуки Claude Code из файлов
  `.claude/settings.json`: [Third Party Hooks](https://cursor.com/docs/reference/third-party-hooks).
  Новые хуки создавайте в `hooks.json`.

## Настройки hooks.json

Файл `hooks.json` состоит из версии формата и списка «событие → хуки»:

```json
{
  "version": 1,
  "hooks": {
    "afterFileEdit": [
      {
        "command": ".cursor/hooks/observe-hook.sh"
      }
    ]
  }
}
```

| Настройка | Обязательна | Назначение |
| --- | --- | --- |
| `version` | да | Версия формата файла. Используйте `1` |
| `hooks` | да | Список событий. У каждого события — список хуков: выполняются все |

Настройки одного хука:

| Настройка | Обязательна | Назначение |
| --- | --- | --- |
| `command` | да, для Command-based hooks | Путь к скрипту или команда оболочки |
| `type` | нет | `"command"` (по умолчанию) — запустить скрипт. `"prompt"` — проверить условие AI-моделью |
| `prompt` | да, для Prompt-based hooks | Условие обычными словами. Вместо `$ARGUMENTS` Cursor подставит сведения о событии |
| `model` | нет | Только для Prompt-based hooks: ID модели вместо быстрой модели по умолчанию |
| `timeout` | нет | Сколько секунд ждать ответа. Без настройки действует значение Cursor по умолчанию |
| `matcher` | нет | Условие запуска — регулярное выражение. Без настройки, с пустой строкой или `"*"` хук запускается всегда |
| `failClosed` | нет | `false` (по умолчанию) — если хук не сработал, действие выполняется. `true` — действие запрещается |
| `loop_limit` | нет | Только для `stop` и `subagentStop`: сколько раз подряд хук может продолжить работу. По умолчанию `5`, `null` — без ограничения |

## События

Столбец «Облако» показывает, выполняется ли событие в облачных агентах.
Столбец «Скрипт» называет заготовку из папки `hooks/`.

### Agent hooks

| Событие | Когда срабатывает | Что может хук | С чем сравнивается `matcher` | Облако | Скрипт |
| --- | --- | --- | --- | --- | --- |
| `sessionStart` | Создан новый чат | Добавить текст в начало чата (`additional_context`), задать переменные окружения для следующих хуков (`env`). Отменить создание чата не может | не используется | нет | `session-start-hook.sh` |
| `sessionEnd` | Чат завершён | Только наблюдать: ответ не используется | не используется | нет | `observe-hook.sh` |
| `preToolUse` | Агент собирается использовать любой инструмент | Разрешить или запретить (`permission`), изменить аргументы инструмента (`updated_input`) | тип инструмента: `Shell`, `Read`, `Write`, `Grep`, `Delete`, `Task`, `MCP:<имя инструмента>` | да | `permission-hook.sh` |
| `postToolUse` | Инструмент успешно отработал | Передать агенту текст (`additional_context`); для инструментов MCP — заменить результат (`updated_mcp_tool_output`) | тип инструмента | да | `observe-hook.sh` |
| `postToolUseFailure` | Инструмент завершился ошибкой, не уложился во время или был запрещён | Передать агенту текст (`additional_context`) | тип инструмента | да | `observe-hook.sh` |
| `subagentStart` | Агент собирается запустить субагента | Разрешить или запретить (`permission`) | тип субагента: `generalPurpose`, `explore`, `shell` и другие | да | `permission-hook.sh` |
| `subagentStop` | Субагент закончил работу, завершился ошибкой или был остановлен | Продолжить работу субагента новым сообщением (`followup_message`) | тип субагента | да | `stop-hook.sh` |
| `beforeShellExecution` | Агент собирается выполнить команду в терминале | Разрешить, запретить или спросить пользователя (`permission`) | текст команды | да | `permission-hook.sh` |
| `afterShellExecution` | Команда выполнена | Только наблюдать | текст команды | да | `observe-hook.sh` |
| `beforeMCPExecution` | Агент собирается вызвать инструмент MCP-сервера | Разрешить, запретить или спросить пользователя (`permission`) | в документации не указано; в Cursor 3.30 — `MCP:<имя инструмента>` | нет | `permission-hook.sh` |
| `afterMCPExecution` | Инструмент MCP-сервера отработал | Только наблюдать | в документации не указано; в Cursor 3.30 — `MCP:<имя инструмента>` | нет | `observe-hook.sh` |
| `beforeReadFile` | Агент собирается прочитать файл | Разрешить или запретить (`permission`) | значение `Read` | да | `permission-hook.sh` |
| `afterFileEdit` | Агент изменил файл | Только наблюдать, например запустить форматирование | значение `Write` | да | `observe-hook.sh` |
| `beforeSubmitPrompt` | Пользователь отправил запрос, но он ещё не ушёл | Отправить запрос или не отправлять (`continue`) | значение `UserPromptSubmit` | да | `before-submit-prompt-hook.sh` |
| `preCompact` | Cursor собирается сжать длинный чат в краткое изложение | Только наблюдать; может показать сообщение (`user_message`) | не используется | да | `observe-hook.sh` |
| `stop` | Агент закончил работу над запросом | Продолжить работу новым сообщением (`followup_message`) | значение `Stop` | да | `stop-hook.sh` |
| `afterAgentResponse` | Агент написал ответ | Только наблюдать | значение `AgentResponse` | да | `observe-hook.sh` |
| `afterAgentThought` | Агент закончил блок размышлений | Только наблюдать | значение `AgentThought` | да | `observe-hook.sh` |

### Tab hooks

| Событие | Когда срабатывает | Что может хук | С чем сравнивается `matcher` | Облако | Скрипт |
| --- | --- | --- | --- | --- | --- |
| `beforeTabFileRead` | Tab собирается прочитать файл | Разрешить или запретить (`permission`) | значение `TabRead` | нет | `permission-hook.sh` |
| `afterTabFileEdit` | Tab изменил файл | Только наблюдать, например запустить форматирование | значение `TabWrite` | нет | `observe-hook.sh` |

### App lifecycle hooks

| Событие | Когда срабатывает | Что может хук | С чем сравнивается `matcher` | Облако | Скрипт |
| --- | --- | --- | --- | --- | --- |
| `workspaceOpen` | Cursor открыл проект или изменился набор его папок | Вернуть папки плагинов, которые нужно загрузить (`pluginPaths`) | не используется | нет | `workspace-open-hook.sh` |

Значения `permission`: `"allow"` — разрешить, `"deny"` — запретить, `"ask"` —
спросить пользователя. Значение `"ask"` работает только для событий
`beforeShellExecution` и `beforeMCPExecution`.

Облачные агенты выполняют только Command-based hooks из `.cursor/hooks.json`
проекта, а на тарифе Enterprise — также Team hooks и Enterprise hooks. User
hooks в облаке не выполняются.

## Скрипты

Command-based hook запускает скрипт. Cursor передаёт скрипту сведения
о событии в формате JSON через стандартный ввод (stdin), а скрипт печатает
ответ в формате JSON в стандартный вывод (stdout).

| Скрипт | Для каких событий | Что отвечает заготовка |
| --- | --- | --- |
| [`permission-hook.sh`](hooks/permission-hook.sh) | `beforeShellExecution`, `beforeMCPExecution`, `beforeReadFile`, `preToolUse`, `subagentStart`, `beforeTabFileRead` | `{"permission": "allow"}` — разрешить |
| [`observe-hook.sh`](hooks/observe-hook.sh) | `sessionEnd`, `postToolUse`, `postToolUseFailure`, `afterShellExecution`, `afterMCPExecution`, `afterFileEdit`, `preCompact`, `afterAgentResponse`, `afterAgentThought`, `afterTabFileEdit` | `{}` — ничего не менять |
| [`before-submit-prompt-hook.sh`](hooks/before-submit-prompt-hook.sh) | `beforeSubmitPrompt` | `{"continue": true}` — отправить запрос |
| [`stop-hook.sh`](hooks/stop-hook.sh) | `stop`, `subagentStop` | `{}` — не продолжать работу |
| [`session-start-hook.sh`](hooks/session-start-hook.sh) | `sessionStart` | `{}` — ничего не добавлять |
| [`workspace-open-hook.sh`](hooks/workspace-open-hook.sh) | `workspaceOpen` | `{"pluginPaths": []}` — не подключать плагины |

Заготовки ничего не запрещают и не изменяют: с ними Cursor работает как
обычно, пока вы не впишете свою проверку или действие. Поля, которые приходят
на вход, поля ответа и примеры описаны в заголовке каждого скрипта.

Код выхода — число, которым скрипт сообщает, как он завершился:

| Код выхода | Что означает |
| --- | --- |
| `0` | Успех: Cursor использует ответ скрипта |
| `2` | Запретить действие — то же, что ответ `"permission": "deny"` |
| другой | Хук считается упавшим. Действие выполняется, если у хука не задано `"failClosed": true` |

Для событий, которые разрешают или запрещают действие, непонятный ответ
при коде `0` — не JSON или с неверными значениями — запрещает действие.

## Как записывать hooks.json

Cursor строго проверяет файл. Соблюдайте простые правила — иначе хуки
не загрузятся:

- файл — обычный JSON без комментариев; пояснения держите в копии
  `*.annotated.jsonc`;
- в файле есть строка `"version": 1`;
- имена событий записаны точно, с учётом больших и маленьких букв:
  `afterFileEdit`, а не `afterfileedit`;
- одна ошибка — в имени события, в значении настройки или в запятой —
  отключает все хуки этого файла;
- в значениях нет двух косых черт подряд (`//`), например адресов сайтов:
  Cursor может принять их за начало комментария;
- путь к скрипту записан от правильной папки: в хуках проекта — от корня
  проекта (`.cursor/hooks/имя.sh`), в личных хуках — от папки `~/.cursor/`
  (`./hooks/имя.sh`);
- скрипт исполняемый (команда `chmod +x`) и печатает в stdout один
  JSON-объект и больше ничего;
- `matcher` — регулярное выражение JavaScript. Оно учитывает регистр букв
  и ищет совпадение в любом месте строки: `Shell` и `shell` — разные значения;
- файл `.cursor/hooks.json` проекта — обычный файл, а не ссылка (symlink).

На Windows приложение Cursor запускает команды хуков через PowerShell. Скрипты
`.sh` из этого шаблона рассчитаны на macOS и Linux; для Windows напишите
скрипты PowerShell: входной JSON они читают из переменной `$input`.

## Как пользоваться шаблоном

### Project hooks

1. Скопируйте шаблон и скрипты в свой проект, например из корня этого
   репозитория:

   ```bash
   mkdir -p ~/my-project/.cursor/hooks
   cp -n templates/hook/project-hooks.json ~/my-project/.cursor/hooks.json
   cp -n templates/hook/hooks/permission-hook.sh ~/my-project/.cursor/hooks/
   cp -n templates/hook/hooks/observe-hook.sh ~/my-project/.cursor/hooks/
   chmod +x ~/my-project/.cursor/hooks/*.sh
   ```

   Ключ `-n` не даёт заменить файл, который уже есть. Если в проекте уже есть
   `.cursor/hooks.json`, перенесите в него нужные события вручную.
2. Оставьте в `.cursor/hooks.json` нужные события и подключите свои условия:
   пояснения — в [`project-hooks.annotated.jsonc`](project-hooks.annotated.jsonc).
3. Впишите в скрипты свою проверку или действие.
4. Сохраните `.cursor/hooks.json` и папку `.cursor/hooks/` в git.

Хуки проекта работают, только если вы доверяете проекту (trusted workspace).

### User hooks

1. Скопируйте шаблон и скрипты в папку `.cursor` в домашней папке
   пользователя:

   ```bash
   mkdir -p ~/.cursor/hooks
   cp -n templates/hook/user-hooks.json ~/.cursor/hooks.json
   cp -n templates/hook/hooks/session-start-hook.sh ~/.cursor/hooks/
   cp -n templates/hook/hooks/before-submit-prompt-hook.sh ~/.cursor/hooks/
   chmod +x ~/.cursor/hooks/*.sh
   ```

   Если файл `~/.cursor/hooks.json` уже есть, перенесите в него нужные события
   вручную.
2. Оставьте нужные события и впишите в скрипты свою проверку или действие.
3. Не пишите в личных хуках то, что верно только для одного проекта.

### Team hooks

Это не файл проекта: хук создаёт администратор команды в дашборде.

1. Заполните [`team-hooks.md`](team-hooks.md): событие, операционную систему
   и содержимое хука — скрипт или условие.
2. Передайте заполненный файл администратору команды.
3. Администратор создаёт хук в
   [дашборде Cursor](https://cursor.com/dashboard/team-content?section=hooks).
   Cursor доставит его участникам команды сам: хуки обновляются каждые
   тридцать минут.

### Enterprise hooks

Файлы на компьютеры сотрудников раздаёт IT-отдел: Cursor их не раздаёт
и не обновляет.

1. Подготовьте `hooks.json` по шаблону
   [`enterprise-hooks.json`](enterprise-hooks.json) и скрипты в папке `hooks`
   рядом с ним.
2. Передайте файлы IT-отделу. Файл `hooks.json` помещают в системную папку:

   | Операционная система | Путь к файлу |
   | --- | --- |
   | macOS | `/Library/Application Support/Cursor/hooks.json` |
   | Linux, WSL | `/etc/cursor/hooks.json` |
   | Windows | `C:\ProgramData\Cursor\hooks.json` |

3. Хуки организации запускаются из папки, в которой лежит `hooks.json`,
   поэтому путь к скрипту пишут от неё: `./hooks/имя.sh`.

### Command-based hooks и Prompt-based hooks

Эти шаблоны показывают, как записать один хук. Перенесите нужную запись
в свой `hooks.json` — в `.cursor/hooks.json` проекта или
в `~/.cursor/hooks.json`:

- **Command-based hooks** — запись с настройкой `command` и скрипт из папки
  `hooks/`. Подходит всем событиям.
- **Prompt-based hooks** — запись с настройками `"type": "prompt"` и `prompt`.
  Скрипт не нужен. Подходит событиям, которые могут запретить действие:
  `beforeShellExecution`, `beforeMCPExecution`, `beforeReadFile`, `preToolUse`,
  `subagentStart`, `beforeSubmitPrompt`. Модель может ошибаться, поэтому для
  строгих правил используйте скрипт.

### Agent hooks, Tab hooks и App lifecycle hooks

Эти шаблоны — справочник событий. Найдите нужное событие, перенесите его
запись в свой `hooks.json` и скопируйте скрипт, который в ней указан. Не
переносите шаблон `agent-hooks.json` целиком: каждый хук — отдельная
программа, которая запускается при каждом срабатывании события.

В шаблонах пути записаны для проекта: `.cursor/hooks/имя.sh`. Для личных хуков
замените их на `./hooks/имя.sh`.

## Проверка

1. Откройте **Customize** в боковой панели и перейдите на вкладку **Hooks**:
   хук должен быть в списке.
2. Вызовите событие. Например, для `afterFileEdit` попросите агента изменить
   файл, а для `beforeShellExecution` — выполнить команду.
3. Откройте панель **Output** и выберите в списке канал **Hooks**: в нём
   видно, какие хуки запускались и с какими ошибками.
4. Скрипт можно проверить и без Cursor. Передайте ему сведения о событии
   и посмотрите ответ — один JSON-объект:

   ```bash
   echo '{"command": "git push"}' | .cursor/hooks/permission-hook.sh
   ```

5. Если хук не появился или не срабатывает, проверьте:
   - файл называется `hooks.json` и лежит в папке `.cursor` проекта или
     в `~/.cursor`;
   - файл записан по правилам из раздела «Как записывать hooks.json»;
   - путь к скрипту записан от правильной папки, а скрипт исполняемый;
   - условие `matcher` подходит к событию. Для проверки временно уберите его;
   - вы доверяете проекту: хуки проекта не работают в недоверенном проекте.

Cursor сам перечитывает `hooks.json` после сохранения. Если хуки не появились,
перезапустите Cursor.

## Как поделиться хуками

| Кому нужны хуки | Способ |
| --- | --- |
| Всем, кто работает с проектом | Project hooks: сохраните `.cursor/hooks.json` и `.cursor/hooks/` в git |
| Всей команде во всех проектах | Team hooks: администратор создаёт хук в дашборде. Только тариф Enterprise |
| Всем компьютерам организации | Enterprise hooks: файлы раздаёт IT-отдел |
| Другим командам и проектам | Плагин: хуки упаковывают в плагин и публикуют через маркетплейс |

User hooks остаются только на вашем компьютере.

Шаблон плагина — [`templates/plugin/`](../plugin/README.md), инструкция —
[`docs/cursor-plugin.md`](../../docs/cursor-plugin.md). Хуки плагина
выполняются только как Command-based hooks.
