FROM n8nio/runners:stable
USER root
# Install custom packages
RUN cd /opt/runners/task-runner-python && uv pip install numpy requests

# 2. CREATE the config file directly with correct permissions
# We write the JSON string to the file and then give 'runner' ownership
# We include the Javascript block so the runner starts successfully
RUN echo '{"task-runners": [{"runner-type": "python", "env-overrides": {"N8N_RUNNERS_EXTERNAL_ALLOW": "*", "N8N_RUNNERS_STDLIB_ALLOW": "*"}}, {"runner-type": "javascript", "env-overrides": {"NODE_FUNCTION_ALLOW_EXTERNAL": "*", "NODE_FUNCTION_ALLOW_BUILTIN": "*"}}]}' > /etc/n8n-task-runners.json && \
    chown runner:runner /etc/n8n-task-runners.json && \
    chmod 644 /etc/n8n-task-runners.json

USER runner
