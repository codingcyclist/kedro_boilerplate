FROM python:3.7.9-buster

RUN mkdir -p /tmp/runtime; chmod -R 777 /tmp/runtime
ENV JUPYTER_RUNTIME_DIR /tmp/runtime

RUN chmod -R 777 /usr/local/etc

# add kedro user
ARG KEDRO_UID=999
ARG KEDRO_GID=0
RUN groupadd -f -g ${KEDRO_GID} kedro_group && \
useradd -d /kedro -s /bin/bash -g ${KEDRO_GID} -u ${KEDRO_UID} kedro

RUN su && apt-get update && apt-get install -y locales locales-all && dpkg-reconfigure locales

WORKDIR /kedro/
ADD ./entrypoint.sh /kedro/
RUN chmod +x /kedro/entrypoint.sh

RUN chown -R kedro:${KEDRO_GID} /kedro
USER kedro

RUN pip install kedro==0.17.2 jupyterlab==3.0.12
ENV PATH=${PATH}:/kedro/.local/bin
RUN pip install --user qgrid; jupyter nbextension enable --py --sys-prefix qgrid; jupyter nbextension enable --py --sys-prefix widgetsnbextension
WORKDIR /kedro/home/
EXPOSE 8888

ENTRYPOINT ["bash", "/kedro/entrypoint.sh"]