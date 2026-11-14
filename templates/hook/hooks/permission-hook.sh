#!/usr/bin/env bash
# =============================================================================
# permission-hook.sh — заготовка хука-разрешения: решает, выполнять ли действие.
#
# Подходит для событий, которые могут запретить действие:
#   beforeShellExecution, beforeMCPExecution, beforeReadFile, preToolUse,
#   subagentStart (Agent hooks) и beforeTabFileRead (Tab hooks).
#
# ВХОД (stdin): JSON с общими полями (conversation_id, generation_id, model,
#   hook_event_name, cursor_version, workspace_roots, user_email,
#   transcript_path) и полями события:
#     beforeShellExecution -> command, cwd, sandbox
#     beforeMCPExecution   -> tool_name, tool_input, mcp_server_name
#     beforeReadFile       -> file_path, content, attachments
#     beforeTabFileRead    -> file_path, content
#     preToolUse           -> tool_name, tool_input, tool_use_id, cwd
#     subagentStart        -> subagent_type, task, subagent_model
#
# ВЫХОД (stdout): один JSON-объект с решением и больше ничего:
#   permission     указывайте всегда. "allow" — разрешить, "deny" — запретить,
#                  "ask" — спросить пользователя. Значение "ask" работает
#                  только для beforeShellExecution и beforeMCPExecution:
#                  в остальных событиях используйте "allow" или "deny".
#   user_message   [необязательный] текст для пользователя при запрете.
#   agent_message  [необязательный] текст для агента при запрете. Только для
#                  beforeShellExecution, beforeMCPExecution и preToolUse.
#   updated_input  [необязательный] только preToolUse: изменённые аргументы
#                  инструмента.
#
# КОД ВЫХОДА: 0 — использовать JSON из stdout; 2 — запретить действие;
#   любой другой — хук считается упавшим, и действие выполняется, если для
#   хука не задано "failClosed": true.
#   Внимание: при коде 0 непонятный ответ (не JSON или с неверными значениями)
#   БЛОКИРУЕТ действие, поэтому в stdout должен попадать только JSON.
#
# Переменные окружения, доступные хуку, перечислены в observe-hook.sh.
# =============================================================================
set -euo pipefail

# Прочитать входной JSON целиком. Чтобы разобрать его, сохраните в переменную.
# Для разбора нужна программа jq: проверьте, что она установлена.
#   input="$(cat)"
#   command="$(printf '%s' "$input" | jq -r '.command // empty')"
cat > /dev/null

# Заготовка ничего не проверяет и всегда разрешает действие.
# Замените на свою проверку. Пример запрета:
#   printf '%s\n' '{"permission": "deny", "user_message": "Команда запрещена правилами проекта"}'
printf '%s\n' '{"permission": "allow"}'
