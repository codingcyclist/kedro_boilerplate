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
COPY kedro_starter/entrypoint.sh /kedro/
RUN tr -d "\r" < /kedro/entrypoint.sh > /kedro/entrypoint_tmp.sh &&\
    mv /kedro/entrypoint_tmp.sh /kedro/entrypoint.sh &&\
    chmod +x /kedro/entrypoint.sh

RUN chown -R kedro:${KEDRO_GID} /kedro
USER kedro

RUN pip install kedro==0.17.0 jupyterlab==2.2.9 qgrid==1.3.1 plotly
ENV PATH=${PATH}:/kedro/.local/bin:/kedro/.local/lib:/kedro/home/

RUN pip install --user ; \
    jupyter labextension install jupyterlab-plotly@4.14.3 --no-build; \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build; \
    jupyter labextension install qgrid2; \
    jupyter labextension enable qgrid; \
    jupyter labextension enable widgetsnbextension

WORKDIR /kedro/home/
EXPOSE 8888

ENTRYPOINT ["bash","/kedro/entrypoint.sh"]