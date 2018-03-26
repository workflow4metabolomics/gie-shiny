[![Docker Repository on Quay](https://quay.io/repository/workflow4metabolomics/gie-shiny/status "Docker Repository on Quay")](https://quay.io/repository/workflow4metabolomics/gie-shiny)

# Docker Shiny Container

Shiny running in a docker container. This image can be used to integrate Shiny into Galaxy.
A variety of different packages are pre-installed and can be used right away.

## Usage

### From the pre-build image

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
 and you will have a running RShiny instance on ``http://localhost:3838/``.
 
 ## Application list
 
 * [gie-shiny-chromato](https://github.com/workflow4metabolomics/gie-shiny-chromato): 
