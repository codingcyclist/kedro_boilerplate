# Kedro Boilerplate Image
1. Clone this repository -> You will end up with a folder of just 5 files
    ```shell script
    <your_dir>
     - docker-compose.yml
     - Dockerfile
     - entrypoint.sh
     - README.md
     - .gitignore
    ```
2. Run the following command to build the docker image and to create the kedro project. You'll be asked for a name of your kedro project - remember that name:
    ```shell script
    docker-compose -f docker-compose.yml --name kedro run kedro
    ```
3. Comment out the first line in `entrypoint.sh` and add a second line. Your final `entrypoint.sh` should look as follows:
    ```shell script
    #kedro new && bash
    cd /kedro/home/<your_kedro_project_name> && bash
    ```
