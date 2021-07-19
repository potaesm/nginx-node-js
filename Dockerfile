FROM ubuntu:18.04
# ARG PORT
# ARG WEB_MEMORY

# For local testing
ENV PORT=8080
ENV WEB_MEMORY=512

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Base module
RUN apt-get update && \
    apt-get install -y --no-install-recommends supervisor \
    software-properties-common \
    rsyslog \
    cron \
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

# Add NodeJS App
RUN mkdir app
COPY app app
RUN cd app && npm install && cd ..

# Heroku node
COPY heroku-node.sh home
RUN ["chmod", "+x", "home/heroku-node.sh"]

# Add Supervisor
ADD nginx-nodejs.conf /etc/supervisor/conf.d/nginx-nodejs.conf

# Add Nginx
# ADD nginx/sites-enabled /etc/nginx/sites-enabled

EXPOSE ${PORT}

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
