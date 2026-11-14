#!/usr/bin/env bash
# =============================================================================
# observe-hook.sh — заготовка наблюдающего хука: он узнаёт о событии, но не
# решает, выполнять ли действие. Подходит для форматирования файлов, журналов
# и уведомлений.
#
# Подходит для событий:
#   sessionEnd, postToolUse, postToolUseFailure, afterShellExecution,
#   afterMCPExecution, afterFileEdit, preCompact, afterAgentResponse,
#   afterAgentThought (Agent hooks) и afterTabFileEdit (Tab hooks).
#
# ВХОД (stdin): JSON с общими полями (conversation_id, generation_id, model,
#   hook_event_name, cursor_version, workspace_roots, user_email,
#   transcript_path) и полями события, например:
#     afterFileEdit        -> file_path, edits
#     afterShellExecution  -> command, output, duration, sandbox
#     afterMCPExecution    -> tool_name, tool_input, mcp_server_name, result_json
#     postToolUse          -> tool_name, tool_input, tool_output, duration
#     postToolUseFailure   -> tool_name, tool_input, error_message, failure_type
#   Поле hook_event_name позволяет одному скрипту различать события.
#
# ВЫХОД (stdout): один JSON-объект и больше ничего. Пустой объект {} подходит
#   для всех этих событий. Необязательные поля ответа:
#     postToolUse         -> additional_context (текст для агента после
#                            результата инструмента), updated_mcp_tool_output
#                            (только для MCP: заменяет вывод инструмента)
#     postToolUseFailure  -> additional_context
#     preCompact          -> user_message (сообщение пользователю)
#     остальные события   -> полей ответа нет
#
# КОД ВЫХОДА: 0 — успех; любой другой — хук считается упавшим (на действие,
#   которое уже выполнено, это не влияет).
#
# ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ, которые Cursor передаёт любому хуку:
#   CURSOR_PROJECT_DIR      корень проекта (есть всегда)
#   CURSOR_VERSION          версия Cursor (есть всегда)
#   CURSOR_USER_EMAIL       e-mail пользователя (если выполнен вход)
#   CURSOR_TRANSCRIPT_PATH  путь к файлу с записью диалога (если запись включена)
#   CURSOR_CODE_REMOTE      "true" при работе с удалённым проектом
#   CLAUDE_PROJECT_DIR      то же, что CURSOR_PROJECT_DIR (совместимость с Claude)
# =============================================================================
set -euo pipefail

# Прочитать входной JSON целиком. Чтобы разобрать его, сохраните в переменную.
# Для разбора нужна программа jq: проверьте, что она установлена.
#   input="$(cat)"
#   file_path="$(printf '%s' "$input" | jq -r '.file_path // empty')"
cat > /dev/null

# Заготовка ничего не делает. Замените на своё действие: запуск форматтера,
# запись в журнал и т. п. Всё, что печатают вызванные программы, направляйте
# в /dev/null или в файл: в stdout должен попасть только JSON.
printf '%s\n' '{}'
