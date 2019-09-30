FROM rocker/shiny:3.4.4

# Installing packages needed for check traffic on the container and kill if none
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    sudo wget procps curl net-tools python-pip git \
    libcurl4-openssl-dev libxml2-dev libssl-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev && \
    pip install --upgrade setuptools && \
    pip install bioblend && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install packages
COPY ./packages.R /tmp/packages.R
RUN Rscript /tmp/packages.R

VOLUME ["/import"]
WORKDIR /import/

COPY ./shiny-server.sh ./monitor_traffic.sh /
ADD ./packages-gx.R /tmp/packages-gx.R
ADD ./GalaxyConnector /tmp/GalaxyConnector

# The Galaxy instance can copy in data that needs to be present to the Rshiny webserver
RUN Rscript /tmp/packages-gx.R && \
    pip install git+https://github.com/bgruening/galaxy_ie_helpers@6c218ae3534fe6add823db3c63ee8c447b0fcbe2

# Must happen later, otherwise GalaxyConnector is loaded by default, and fails, preventing ANY execution
COPY ./Rprofile.site /usr/local/lib/R/etc/Rprofile.site
COPY ./shiny-server.conf /etc/shiny-server/shiny-server.conf

# Start Shiny
CMD ["/shiny-server.sh"]
