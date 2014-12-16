FROM ubuntu:14.04
MAINTAINER Piotr Radkowski <piotr.radkowski@uj.edu.pl>

ENV DEBIAN_FRONTEND noninteractive

# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/no-cache

RUN apt-get update && \
	apt-get install -y nginx
RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

# Setup nginx
ADD nginx/default /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx/index.html /usr/share/nginx/html/index.html

# Add server certificate
ADD nginx/cert.* /etc/nginx/

EXPOSE 80
EXPOSE 443
CMD nginx
