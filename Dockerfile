FROM rocker/shiny:latest

# Installing packages needed for check traffic on the container and kill if none
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        nano wget procps sudo \
        libcurl4-openssl-dev curl libxml2-dev python-pip net-tools \
	libssl-dev git

RUN pip install --upgrade setuptools
RUN pip install bioblend && \
    apt-get autoremove -y && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install packages
COPY ./packages.R /tmp/packages.R
RUN Rscript /tmp/packages.R

ADD ./shiny-server.sh /shiny-server.sh
ADD ./monitor_traffic.sh /monitor_traffic.sh
ADD ./GalaxyConnector /tmp/GalaxyConnector
ADD ./packages-gx.R /tmp/packages-gx.R

RUN chmod +x /monitor_traffic.sh && \
    chmod +x /shiny-server.sh

RUN Rscript /tmp/packages-gx.R && \
    pip install git+https://github.com/bgruening/galaxy_ie_helpers@a4237aa8704938fd87a2a947b1269f34363c933b

RUN rm -rf /srv/shiny-server/sample-apps
RUN rm /srv/shiny-server/index.html
RUN mkdir -p /srv/shiny-server/samples/test
COPY ./ui.R /srv/shiny-server/samples/test/ui.R
COPY ./server.R /srv/shiny-server/samples/test/server.R

COPY ./shiny-server.sh /usr/bin/shiny-server.sh

CMD /shiny-server.sh
