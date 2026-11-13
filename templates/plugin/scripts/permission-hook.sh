#!/usr/bin/env bash
# =============================================================================
# permission-hook.sh — заготовка хука-разрешения.
#
# Подключён в hooks/hooks.json к событиям, которые решают, выполнять ли действие:
#   preToolUse, subagentStart, beforeShellExecution, beforeMCPExecution,
#   beforeReadFile, beforeTabFileRead.
#
# ВХОД (stdin): JSON с общими полями (conversation_id, generation_id, model,
#   hook_event_name, cursor_version, workspace_roots, user_email,
#   transcript_path) и полями конкретного события, например:
#     beforeShellExecution -> command, cwd, sandbox
#     beforeMCPExecution   -> tool_name, tool_input, mcp_server_name
#     beforeReadFile       -> file_path, content, attachments
#     preToolUse           -> tool_name, tool_input, tool_use_id, cwd
#     subagentStart        -> subagent_type, task, subagent_model
#
# ВЫХОД (stdout): JSON с решением:
#   permission     основное поле ответа, указывайте всегда. "allow" — разрешить,
#                  "deny" — запретить, "ask" — спросить пользователя ("ask"
#                  работает только для beforeShellExecution и beforeMCPExecution).
#   user_message   [необязательный] текст для пользователя при запрете.
#   agent_message  [необязательный] текст для агента при запрете.
#   updated_input  [необязательный] только preToolUse: изменённые аргументы
#                  инструмента.
#
# КОД ВЫХОДА: 0 — использовать JSON из stdout; 2 — запретить действие;
#   любой другой — хук считается упавшим, и действие выполняется, если для
#   хука не задан failClosed: true.
#   Внимание: при коде 0 невалидный JSON или ответ не по схеме БЛОКИРУЕТ
#   действие, поэтому в stdout должен попадать только JSON.
#
# Переменные окружения, доступные хуку, перечислены в observe-hook.sh.
# =============================================================================
set -euo pipefail

# Прочитать входной JSON целиком. Чтобы разобрать его, сохраните в переменную:
#   input="$(cat)"
#   command="$(printf '%s' "$input" | jq -r '.command // empty')"
cat > /dev/null

# Заготовка ничего не проверяет и всегда разрешает действие.
# Замените на свою логику. Пример запрета:
#   printf '%s\n' '{"permission": "deny", "user_message": "Команда запрещена политикой"}'
printf '%s\n' '{"permission": "allow"}'
