FROM n8nio/n8n:latest

USER root

RUN apt-get update \
    && apt-get install -y python3 python3-venv python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/python-venv

RUN /opt/python-venv/bin/pip install --no-cache-dir openpyxl

ENV PATH="/opt/python-venv/bin:$PATH"

USER node
