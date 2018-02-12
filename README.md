# Docker RShiny Container

RShiny running in a docker container. This image can be used to integrate RShiny into Galaxy.
A variety of different packages are pre-installed and can be used right away.

## Usage

* Build your own image and run it

 [Docker](https://www.docker.com) is a pre-requirement for this project. You can build the container with:
 ```bash
 $ docker build -t shiny_gie .
 ```
 The build process can take some time, but if finished you can run your container with:
 ```bash
 $ docker run -p 3838:3838 -v /home/user/foo/:/import/ -t shiny_gie
 ```
 and you will have a running RShiny instance on ``http://localhost:3838/``.


### Environment Variables

Several environment variables are available by default, per IE rough standards


#### Run-Time Variables

Variable            | Use
------------------- | ---
`GALAXY_WEB_PORT`   | Port on which Galaxy is running, if applicable
`CORS_ORIGIN`       | If the notebook is proxied, this is the URL the end-user will see when trying to access a notebook
`DOCKER_PORT`       | Used in Galaxy Interactive Environments to ensure that proxy routes are unique and accessible
`API_KEY`           | Galaxy API Key with which to interface with Galaxy
`HISTORY_ID`        | ID of current Galaxy History, used in easing the dataset upload/download process
`REMOTE_HOST`       | Unused
`GALAXY_URL`        | URL at which Galaxy is accessible
`DEBUG`             | Enable debugging mode, mostly for developers
