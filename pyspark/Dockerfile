FROM kedro-default:latest
COPY spark.yml entrypoint.sh requirements.txt context.py pyspark_example.ipynb /kedro/

WORKDIR /kedro/
USER root

#RUN apt-get update && \
#    apt-get install -y openjdk-11-jre && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/

# install java and set JAVA_HOME variable
RUN apt-get update && apt-get install -y software-properties-common &&\
    apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main' &&\
    apt-get update &&\
    apt-get install openjdk-8-jdk -y

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

USER kedro
RUN pip install -r /kedro/requirements.txt --no-cache-dir && \
    jupyter lab build

WORKDIR /kedro/home/

#ENTRYPOINT ["sleep","infinity"]
ENTRYPOINT ["bash","/kedro/entrypoint.sh"]