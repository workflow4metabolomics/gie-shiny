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

# /import will be the universal mount-point for IPython
VOLUME ["/import"]
WORKDIR /import/

ADD ./shiny-server.sh /shiny-server.sh
ADD ./monitor_traffic.sh /monitor_traffic.sh
ADD ./GalaxyConnector /tmp/GalaxyConnector
ADD ./packages-gx.R /tmp/packages-gx.R

# The Galaxy instance can copy in data that needs to be present to the Rstudio webserver
RUN chmod +x /shiny-server.sh && \
    chmod +x /monitor_traffic.sh && \
    Rscript /tmp/packages-gx.R && \
    pip install git+https://github.com/bgruening/galaxy_ie_helpers@a4237aa8704938fd87a2a947b1269f34363c933b

# Must happen later, otherwise GalaxyConnector is loaded by default, and fails,
# preventing ANY execution
COPY ./Rprofile.site /usr/lib/R/etc/Rprofile.site
COPY ./shiny-server.conf /etc/shiny-server/shiny-server.conf

# For temp app
RUN rm -rf /srv/shiny-server/sample-apps
RUN rm /srv/shiny-server/index.html
RUN mkdir -p /srv/shiny-server/samples/test
RUN chmod -R 777 /srv/shiny-server/samples/test
COPY ./ui.R /srv/shiny-server/samples/test/ui.R
COPY ./server.R /srv/shiny-server/samples/test/server.R

COPY ./shiny-server.sh /usr/bin/shiny-server.sh

# Start Shiny
CMD /shiny-server.sh
