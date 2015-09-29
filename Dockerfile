FROM nginx:1.9
MAINTAINER Hellyna NG <hellyna@groventure.com>

COPY scripts/* /scripts/
COPY conf/* /usr/local/etc/rattic/
RUN bash /scripts/build.sh
EXPOSE 80/tcp

ENTRYPOINT ["/bin/bash", "/scripts/entrypoint.sh"]
