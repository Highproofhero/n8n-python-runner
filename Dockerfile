FROM n8nio/runners:stable
USER root
# Install custom packages
RUN cd /opt/runners/task-runner-python && uv pip install numpy requests

# 2. OVERWRITE the locked config with our custom open config
# This is the "Railway equivalent" of mounting a volume
COPY n8n-task-runners.json /etc/n8n-task-runners.json

USER runner
