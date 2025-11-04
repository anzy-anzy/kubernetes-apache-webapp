# -------------------------------
# Dockerfile: Apache Web App for Kubernetes Project
# -------------------------------

# Base image
FROM httpd:2.4

# Maintainer label
LABEL maintainer="Ebsiy Anslem <anslem2025>"

# Copy the custom HTML file into Apache's web root
COPY ./index.html /usr/local/apache2/htdocs/index.html

# Expose port 80
EXPOSE 80

# Optional health check
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost/ || exit 1

