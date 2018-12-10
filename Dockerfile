FROM ubuntu:trusty

ENV NODE_ENV development
ENV JWT_SECRET VALUE
ENV DB_USERNAME root
ENV DB_HOST localhost
ENV DB_PASSWORD root
ENV DB_PORT 3306
ENV MAPBOX_ACCESS_TOKEN VALUE
ENV S3_KEY VALUE
ENV S3_SECRET VALUE
ENV S3_BUCKET VALUE
ENV STREAM_APP_ID VALUE
ENV STREAM_KEY VALUE
ENV STREAM_SECRET VALUE
ENV ALGOLIA_APP_ID VALUE
ENV ALGOLIA_SEARCH_ONLY_KEY VALUE
ENV ALGOLIA_API_KEY VALUE
ENV KEEN_PROJECT_ID VALUE
ENV KEEN_WRITE_KEY VALUE
ENV KEEN_READ_KEY VALUE
ENV IMGIX_BASE_URL https://react-example-app.imgix.net/uploads
ENV API_URL http://localhost:8000

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
      wget \
      curl \
      python2.7 \
      python-pip \
      git

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV NODE_VERSION 9.2.1
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN source ~/.nvm/nvm.sh \
    && nvm alias default $NODE_VERSION \
    && nvm use default && \
    npm install -g webpack@2.6.1

ADD src/db/cabin.sql /

#wget http://repo.mysql.com/mysql-apt-config_0.8.9-1_all.deb && \
#sudo dpkg -i mysql-apt-config_0.8.9-1_all.deb && \
#apt-get update && \

RUN apt-get -y install mysql-server-5.6 && \
    touch /.firstrun

ADD start.sh /
RUN chmod +x /start.sh && mkdir -p /app/src

EXPOSE 3000

USER root

WORKDIR /app/src

CMD ["/start.sh"]
