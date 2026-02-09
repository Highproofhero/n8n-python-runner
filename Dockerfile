# Official n8n Python Runner (Debian-based, stable)
FROM n8nio/n8n-task-runners:python3

# Install common libraries (requests, pandas, etc.)
# Add any other libraries you need here
RUN pip install requests

# Port 5678 is the standard for runners
EXPOSE 5678
