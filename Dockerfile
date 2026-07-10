FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache python3 py3-pip

RUN python3 -m venv /opt/python-venv
RUN /opt/python-venv/bin/pip install --no-cache-dir openpyxl

ENV PATH="/opt/python-venv/bin:$PATH"

USER node
