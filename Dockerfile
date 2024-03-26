# Use the latest Ubuntu LTS release
FROM ubuntu:22.04

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y nginx zip curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Remove any duplicate "daemon" directive if present
RUN sed -i '/^daemon\s/s/^\s*//' /etc/nginx/nginx.conf

# Download and extract the 2048 game files
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master && \
    cd /var/www/html/ && \
    unzip master.zip && \
    mv 2048-master/* . && \
    rm -rf 2048-master master.zip

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

