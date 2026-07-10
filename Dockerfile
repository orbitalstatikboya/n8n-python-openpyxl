FROM node:22-alpine

USER root

RUN apk add --no-cache python3 py3-pip tini

RUN python3 -m venv /opt/python-venv
RUN /opt/python-venv/bin/pip install --no-cache-dir openpyxl

RUN npm install -g n8n@2.29.10

RUN mkdir -p /home/node/.n8n
RUN chown -R node:node /home/node/.n8n /opt/python-venv

RUN cat > /usr/local/bin/n8n-wrapper <<'EOF'
#!/bin/sh
set -e

if [ "$1" = "start" ]; then
  shift
fi

exec n8n "$@"
EOF

RUN chmod +x /usr/local/bin/n8n-wrapper

ENV PATH="/opt/python-venv/bin:$PATH"
ENV NODE_ENV=production
ENV N8N_USER_FOLDER=/home/node/.n8n

USER node

EXPOSE 5678

ENTRYPOINT ["tini", "--", "/usr/local/bin/n8n-wrapper"]
CMD ["start"]
