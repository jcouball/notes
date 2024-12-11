FROM mcr.microsoft.com/devcontainers/python

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# # Install Node.js, Python, and pip
RUN apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - && \
    apt-get install -y nodejs

# Install mkdocs and other Python dependencies
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 install --no-cache-dir -r /tmp/pip-tmp/requirements.txt && \
    rm -rf /tmp/pip-tmp

# Install markdownlint-cli2
COPY package.json /tmp/npm-tmp/
RUN cd /tmp/npm-tmp && \
    npm install && \
    npm install -g markdownlint-cli2 && \
    rm -rf /tmp/npm-tmp

# Set the working directory
RUN mkdir -p /workspace && chown -R vscode:vscode /workspace
WORKDIR /workspace
