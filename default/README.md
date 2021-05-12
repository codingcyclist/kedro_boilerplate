# `kedro-default`: A simple `kedro` boilerplate image with `plotly` and `qgrid` support

The purpose of this Docker image is to create fully configured, containerized kedro projects from scratch in no time.

![](kedro-default.gif)
It is built around `kedro 0.17.0` and by default, comes with some additional dependencies, which have proven to be
useful across many kedro projects, including:
* `jupyterlab` `2.2.9`
* `qgrid` `1.3.1` (interactive widget to explore pandas DataFrames)
* `plotly` `4.14.3`

If you follow the instructions below, your current directory will be populated with a **fully-fledged kedro project in just 
a matter of minutes**. Additionally, you don't have to fiddle with `conda` environments etc. as all
underlying dependencies (including nodejs, jupyter notebook widgets, etc.) will be kept inside an isolated Docker container. 

## How to build the Docker image?
The command below builds the Docker image locally, tagging it with `kedro-default`. Make sure you're in the
same directory as the `Dockerfile` when you execute the command.
```shell
$ docker build . -t kedro-default
```

## How to run the image as a Docker container?
Once you've built the image, switch into an empty directory and use the following command to run the image as a Docker container.
```shell
$ docker run --name kedro -p 8888:8888 -e KEDRO_PROJECT_NAME=my_project -v $(pwd):/kedro/home/ -it kedro-default:latest
```
Spinning up the Docker container will **take a few minutes** since several python and jupyter dependencies have to be 
installed in the background. Once finished, a jupyter notebook will be brought up, and you'll see it's link printed to 
your terminal.

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

## How getting started with `kedro`
There is an **example jupyter notebook** that demonstrates some basic `kedro`, `plotly` and `qgrid` features. Once you start the Docker container,
just open the jupyter link, navigate to the `notebooks/` directory, and checkout `kedro_example.ipynb`.