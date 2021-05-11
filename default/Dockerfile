FROM nikolaik/python-nodejs:python3.7-nodejs12
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
COPY config.yml entrypoint.sh requirements.txt /kedro/
RUN tr -d "\r" < /kedro/entrypoint.sh > /kedro/entrypoint_tmp.sh &&\
    mv /kedro/entrypoint_tmp.sh /kedro/entrypoint.sh &&\
    chmod +x /kedro/entrypoint.sh

RUN chown -R kedro:${KEDRO_GID} /kedro
USER kedro

RUN pip install -r /kedro/requirements.txt
ENV PATH=${PATH}:/kedro/.local/bin:/kedro/.local/lib:/kedro/home/
ENV KEDRO_PROJECT_NAME=${KEDRO_PROJECT_NAME:-project_root}

RUN jupyter labextension install jupyterlab-plotly@4.14.3 --no-build; \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build; \
    jupyter labextension install qgrid2 --no-build; \
    jupyter labextension enable qgrid; \
    jupyter labextension enable widgetsnbextension

WORKDIR /kedro/home/
EXPOSE 8888

#ENTRYPOINT ["sleep","infinity"]
ENTRYPOINT ["bash","/kedro/entrypoint.sh"]