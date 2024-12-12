FROM mcr.microsoft.com/devcontainers/python

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Install Node.js, Python, and pip
RUN apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - && \
    apt-get install -y nodejs

# Set the working directory
RUN mkdir -p /workspaces/notes && chown -R vscode:vscode /workspaces
WORKDIR /workspaces/notes

USER vscode
ENV PATH="/home/vscode/.local/bin:${PATH}"

COPY package.json requirements.txt /workspaces/notes/

RUN mkdir -p /home/vscode/.local/bin && \
    # Create an alias for ls -al
    echo '#!/bin/sh' > /home/vscode/.local/bin/ll && \
    echo 'ls --color -alh "$@"' >> /home/vscode/.local/bin/ll && \
    chmod +x /home/vscode/.local/bin/ll && \
    # Install mkdocs and other Python dependencies
    pip3 install --no-cache-dir -r /workspaces/notes/requirements.txt && \
    # Install Node.js dependencies and markdownlint-cli2 globally
    npm install && \
    sudo npm install -g markdownlint-cli2 && \
    # Cleanup
    rm requirements.txt package.json
