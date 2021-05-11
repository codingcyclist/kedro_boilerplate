dir=$(find . -type d | grep -E "^\.\/.+\/conf/local$")
dir=$(echo $dir | cut -d "/" -f2)
dir=$(echo $dir | xargs)

# replacing placeholder in the project config with the kedro project name
sed -i "s/<[^>]*>/$KEDRO_PROJECT_NAME/g" /kedro/config.yml

cd $(pwd)/$dir && echo $(pwd) && kedro jupyter lab --ip 0.0.0.0 || \
  kedro new --config /kedro/config.yml --verbose && \
  cd $(pwd)/$KEDRO_PROJECT_NAME && kedro install && \
  pip install --force-reinstall kedro==0.17.0 jupyterlab==2.2.9 qgrid==1.3.1 && \
  pip freeze > $(pwd)/src/requirements.txt && jupyter lab build && \
  echo "Root folder of your kedro project: "$(pwd) && \
  echo $(pwd) && kedro jupyter lab --ip 0.0.0.0