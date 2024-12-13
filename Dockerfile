# Use a Python image to build the MkDocs documentation
FROM python:3.12-slim AS builder

# Install MkDocs and any plugins (update with your specific requirements)
RUN pip install --no-cache-dir mkdocs mkdocs-material markdown-include pymdown-extensions

# Set working directory
WORKDIR /docs

# Copy the documentation source into the container
COPY . .

# Build the MkDocs site
RUN mkdocs build

# Use a lightweight web server for the final stage
FROM nginx:stable-alpine

# Copy built MkDocs site to the Nginx default html directory
COPY --from=builder /docs/site /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]