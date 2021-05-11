# Kedro Boilerplate Image
This is the kedro base image, boasting the following features:
* `kedro` `0.17.0`
* `jupyterlab` `2.2.9`
* `qgrid` `1.3.1` (see details below)
* `plotly` `4.14.3` (see details below)

1. default project name is `project_root` - change it using the `KEDRO_PROJECT_NAME` environment variable in your docker run command (see example below)
   
```shell
docker run --name kedro -p 8888:8888 -v <abs-path>:/kedro/home/ -e KEDRO_PROJECT_NAME=root kedro_docker:latest
```

What to consider when running the container
* Ports: 8888
* Volumes: Mount to `/kedro/home/` - make sure that his is an empty directory
* Environment variables

```shell
docker start -ai kedro
```
1. Clone this repository -> You will end up with a folder of just 5 files
    ```shell script
    <your_dir>/
     - default/
       - config.yml
       - default.ipynb
     - docker-compose.yml
     - Dockerfile
     - entrypoint.sh
     - README.md
     - .gitignore
    ```
2. Change all occurrences of `<your_kedro_project_name>` in `kedro_starter/config.yml` with your preferred project name

3. Run the following command to build the docker image for the first time and fire up the container:
    ```shell script
    docker-compose up
    ```
    After the container has been built for the first time, you should be prompted to re-run the container.
    
4. Re-Run the following command fire up the container again:
    ```shell script
    docker-compose up
    ```
    This time, you should be prompted with a link pointing to a jupyter lab. Going forward, always use this docker-compose command to fire up the container