FROM n8nio/runners:stable
USER root
# Install custom packages
RUN cd /opt/runners/task-runner-python && uv pip install numpy requests

# 2. Overwrite config with REQUIRED 'command' and 'args' fields included
# We use the exact paths and arguments from the official repo reference
RUN echo '{"task-runners": [{"runner-type": "python", "command": "/opt/runners/task-runner-python/.venv/bin/python", "args": ["-I", "-B", "-X", "disable_remote_debug", "-m", "src.main"], "workdir": "/home/runner", "health-check-server-port": "5682", "env-overrides": {"N8N_RUNNERS_EXTERNAL_ALLOW": "*", "N8N_RUNNERS_STDLIB_ALLOW": "*"}}, {"runner-type": "javascript", "command": "/usr/local/bin/node", "args": ["--disallow-code-generation-from-strings", "--disable-proto=delete", "/opt/runners/task-runner-javascript/dist/start.js"], "workdir": "/home/runner", "health-check-server-port": "5681", "env-overrides": {"NODE_FUNCTION_ALLOW_EXTERNAL": "*", "NODE_FUNCTION_ALLOW_BUILTIN": "*"}}]}' > /etc/n8n-task-runners.json && \
    chown runner:runner /etc/n8n-task-runners.json && \
    chmod 644 /etc/n8n-task-runners.json

USER runner


