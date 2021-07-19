FROM ubuntu:18.04

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Base
RUN apt-get update && \
    apt-get install -y --no-install-recommends supervisor \
    software-properties-common \
    rsyslog \
    curl \
    build-essential \
    python 

# NodeJS
RUN apt-get install -y --no-install-recommends npm && \
    npm install n -g && \
    n lts

RUN add-apt-repository ppa:nginx/stable && apt-get update && \
    apt-get -y install nginx-full && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default

# Add files

# NodeJS App
RUN mkdir app
COPY app app
RUN cd app && npm install && cd ..

# Supervisor
ADD nginx-nodejs.conf /etc/supervisor/conf.d/nginx-nodejs.conf
# Nginx
# ADD nginx/sites-enabled /etc/nginx/sites-enabled

EXPOSE 80

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
