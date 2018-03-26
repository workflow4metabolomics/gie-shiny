# Docker Shiny Container

Shiny running in a docker container. This image can be used to integrate Shiny into Galaxy.
A variety of different packages are pre-installed and can be used right away.

## Usage

* Build your own image and run it

 [Docker](https://www.docker.com) is a pre-requirement for this project. You can build the container with:
 ```bash
 $ docker build -t gie-shiny .
 ```
 The build process can take some time, but if finished you can run your container with:
 ```bash
 $ docker run -p 3838:3838 -v /home/user/foo/:/import/ -t gie-shiny
 ```
 and you will have a running RShiny instance on ``http://localhost:3838/``.
