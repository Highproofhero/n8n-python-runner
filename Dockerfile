FROM n8nio/runners:stable
USER root


# 1. Install custom packages
# We target the specific virtual environment used by the python runner
RUN cd /opt/runners/task-runner-python && \
    . .venv/bin/activate && \
    uv pip install numpy requests

# 2. Patch the EXISTING config file
# We do NOT overwrite the file. We use 'sed' to find the restrictive settings 
# and replace them with wildcards ("*") to allow your imports.
RUN sed -i 's/"N8N_RUNNERS_EXTERNAL_ALLOW": ""/"N8N_RUNNERS_EXTERNAL_ALLOW": "*"/g' /etc/n8n-task-runners.json && \
    sed -i 's/"N8N_RUNNERS_STDLIB_ALLOW": ""/"N8N_RUNNERS_STDLIB_ALLOW": "*"/g' /etc/n8n-task-runners.json && \
    sed -i 's/"NODE_FUNCTION_ALLOW_EXTERNAL": ""/"NODE_FUNCTION_ALLOW_EXTERNAL": "*"/g' /etc/n8n-task-runners.json && \
    sed -i 's/"NODE_FUNCTION_ALLOW_BUILTIN": ""/"NODE_FUNCTION_ALLOW_BUILTIN": "*"/g' /etc/n8n-task-runners.json

USER runner


