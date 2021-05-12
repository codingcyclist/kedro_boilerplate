# `kedro-pyspark`: A `kedro` boilerplate image with `pyspark` support

The purpose of this Docker image is to create fully configured, containerized kedro projects **with pyspark support**
from scratch in no time.

![kedro-pyspark.gif](kedro-pyspark.gif)

The Docker image is built on top of the `kedro-default` Docker image (i.e. `kedro 0.17.0`, `python 3.7`). It provides full `pyspark` support on top of all
functionalities included in `kedro-default` (including plotly, qgrid, etc.). In particular, the `kedro-pyspark` Docker 
image comes pre-configured with Java 11, pyspark, and pyarrow.

If you follow the instructions below, your current directory will be populated with a **fully-fledged kedro project in just 
a matter of minutes**. Additionally, you don't have to fiddle with `conda` environments etc. as all
underlying dependencies (including pyspark, Java, nodejs, jupyter notebook widgets, ect.) will be kept inside an isolated Docker container. 

## How to build the Docker image?
The command below builds the Docker image locally, tagging it with `kedro-pyspark`. Make sure you're in the
same directory as the `Dockerfile` when you execute the command and make sure that you've already built `kedro-default`, which
serves as the base image for `kedro-pyspark`.
```shell
$ docker build . -t kedro-pyspark
```

## How to run the image as a Docker container?
Once you've built the image, switch into an empty directory and use the following command to run the image as a Docker container.
```shell
$ docker run --name kedro -p 8888:8888 -e KEDRO_PROJECT_NAME=my_project -v $(pwd):/kedro/home/ -it kedro-pyspark:latest
```
Spinning up the Docker container will **take a few minutes** since several Java and pyspark dependencies have to be installed in the background.
Once finished, a jupyter notebook will be brought up, and you'll see it's link printed to your terminal.

The following **flags** for the `docker run` command are particularly useful:
* `-e`/`--env`: Use this flag to pass **environment variables** to the run command. In particular, use the `KEDRO_PROJECT_NAME` 
  environment variable to **determine the name of your kedro project's root folder**
  
* `-p`/`--publish`: Use this flag to foward ports from localhost to the docker container. In particular, make sure to forward
   your local port `8888` to port `8888` in the container. Otherwise, you won't have access to the jupyter notebook/lab running 
  on port 8888
  
* `-v`/`--volume`: Use this flag to mount a directory from your local computer to a directory inside the container. In particular,
   if you want to keep the files from your kedro project in sync between your computer and the container, make sure to mount
  an empty, local directory to `/kedro/home/` inside the container. (`$(pwd)` will automatically mount you current directory)
  
* `--name`: Use this flag to give a name to your container. If you don't give a name, docker will automatically pick one at random
* `-it`: This is actually a combination of two flags (`i` and `t`). Passing `-it` to the run command allows you to interact
with the container via your terminal (e.g. use `ctrl` + `C` to bring down jupyter)
## How to start/stop the Docker container
Once you've built the docker image and run it as a container, you can always re-start said container with the following command:
```shell
$ docker start -ai kedro
```
The `-ai` flag makes sure to print any logs from the Docker container to your local console. To **stop the container**, just hit
`ctrl` + `c` or open a second command prompt and type `docker stop kedro`
## How to remove the Container
The command below will remove the docker container (assuming you ran the container as `--name kedro`)
```shell
$ docker container rm kedro
```
> **CAUTION:** Any custom python packages which you might have installed inside the container will be deleted when
you remove the container. To be able to recover
those packates once you re-build the container, make sure to update your `requirements.txt` file, before you remove 
the container. Alternatively, you could create a docker volume and mount it to `/kedro/.local/` in order to keep 
packages persistently.

## How to use `pyspark` with `kedro`
There is an **example jupyter notebook** that demonstrates how to use `pyspark` within `kedro`. Once you start the Docker container,
just open the jupyter link, navigate to the `notebooks/` directory, and checkout `pyspark_example.ipynb`.