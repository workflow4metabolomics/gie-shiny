[![Docker Repository on Quay](https://quay.io/repository/workflow4metabolomics/gie-shiny/status "Docker Repository on Quay")](https://quay.io/repository/workflow4metabolomics/gie-shiny)

# Docker Shiny Container

This repository allows to run Shiny in a docker container. This image can be used to integrate Shiny into Galaxy.
A variety of different packages are pre-installed and can be used right away.

## Context

* Based on the work of [ValentinChCloud Shiny GIE](https://github.com/ValentinChCloud/shiny-GIE).
* Using the repository [rocker/shiny]() to install Shiny.
* Adding Galaxy Connectors from [erasche Docker RStudio Container](https://github.com/erasche/docker-rstudio-notebook) to import/export datasets.
* Using the [Galaxy IE helpers by bgruening](https://github.com/bgruening/galaxy_ie_helpers).

## Usage

### From the pre-built image

[![Docker Repository on Quay](https://quay.io/repository/workflow4metabolomics/gie-shiny/status "Docker Repository on Quay")](https://quay.io/repository/workflow4metabolomics/gie-shiny)

```
FROM quay.io/workflow4metabolomics/gie-shiny:latest
```

### Build localy 

* Build your own image

 [Docker](https://www.docker.com) is a pre-requirement for this project. You can build the container with:
 ```bash
 $ docker build -t gie-shiny .
 ```

 * And run it
 
 The build process can take some time, but if finished you can run your container with:
 ```bash
 $ docker run -p 3838:3838 -v /home/user/foo/:/import/ -t gie-shiny
 ```
 and you will have a running Shiny instance on ``http://localhost:3838/``.
 
 ## Application list
 
 * [gie-shiny-chromato](https://github.com/workflow4metabolomics/gie-shiny-chromato) : This application allows to visualize TIC and BPC chromatograms. 
