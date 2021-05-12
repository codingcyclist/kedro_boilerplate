FROM kedro-default:latest
COPY spark.yml entrypoint.sh requirements.txt context.py pyspark_example.ipynb /kedro/

WORKDIR /kedro/
USER root

RUN apt-get update && \
    apt-get install -y openjdk-11-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

USER kedro
RUN pip install -r /kedro/requirements.txt --no-cache-dir --force-reinstall && \
    jupyter lab build

WORKDIR /kedro/home/

ENTRYPOINT ["bash","/kedro/entrypoint.sh"]