#!/usr/bin/env bash
# =============================================================================
# observe-hook.sh — заготовка наблюдающего хука.
#
# Подключён в hooks/hooks.json к событиям, которые не решают судьбу действия:
#   sessionStart, sessionEnd, postToolUse, postToolUseFailure, subagentStop,
#   afterShellExecution, afterMCPExecution, afterFileEdit, preCompact, stop,
#   afterAgentResponse, afterAgentThought, afterTabFileEdit, workspaceOpen.
#
# ВХОД (stdin): JSON с общими полями (conversation_id, generation_id, model,
#   hook_event_name, cursor_version, workspace_roots, user_email,
#   transcript_path) и полями конкретного события. Поле hook_event_name
#   позволяет одному скрипту различать события.
#
# ВЫХОД (stdout): JSON-объект. Пустой объект {} допустим для всех этих событий.
#   Необязательные поля ответа зависят от события:
#     sessionStart        -> env (переменные окружения для следующих хуков
#                            сессии), additional_context (текст в контекст)
#     postToolUse         -> additional_context, updated_mcp_tool_output
#     postToolUseFailure  -> additional_context
#     stop, subagentStop  -> followup_message (автоматически продолжить работу
#                            с этим сообщением; ограничено loop_limit)
#     preCompact          -> user_message
#     workspaceOpen       -> pluginPaths (абсолютные пути к папкам плагинов,
#                            которые нужно загрузить для рабочей области)
#     остальные события   -> полей ответа нет
#
# КОД ВЫХОДА: 0 — успех; любой другой — хук считается упавшим (для наблюдающих
#   событий это ни на что не влияет).
#
# ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ, которые Cursor передаёт любому хуку:
#   CURSOR_PROJECT_DIR      корень рабочей области (есть всегда)
#   CURSOR_VERSION          версия Cursor (есть всегда)
#   CURSOR_USER_EMAIL       e-mail пользователя (если выполнен вход)
#   CURSOR_TRANSCRIPT_PATH  путь к файлу расшифровки диалога (если включены)
#   CURSOR_CODE_REMOTE      "true" в удалённой рабочей области
#   CURSOR_PLUGIN_ROOT      папка установки плагина (для хуков из плагинов)
#   CLAUDE_PROJECT_DIR      синоним CURSOR_PROJECT_DIR (совместимость с Claude)
# =============================================================================
set -euo pipefail

# Прочитать входной JSON целиком. Пример записи в журнал аудита:
#   input="$(cat)"
#   printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$input" >> /tmp/agent-audit.log
cat > /dev/null

# Заготовка ничего не делает. Замените на свою логику (форматтер, аудит и т. п.).
printf '%s\n' '{}'
