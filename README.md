# Kedro Boilerplate Image
1. Clone this repository -> You will end up with a folder of just 5 files
    ```shell script
    <your_dir>/
     - kedro_starter/
       - config.yml
       - kedro_starter.ipynb
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