dir=$(find . -type d | grep -E "^\.\/.+\/conf/local$")
dir=$(echo $dir | cut -d "/" -f2)
dir=$(echo $dir | xargs)

# replacing placeholder in the project config with the kedro project name
sed -i "s/<[^>]*>/$KEDRO_PROJECT_NAME/g" /kedro/config.yml

cd $(pwd)/$dir && echo $(pwd) && kedro jupyter lab --ip 0.0.0.0 --no-browser && exit 0|| \
  kedro new --config /kedro/config.yml --verbose && \
  cd $(pwd)/$KEDRO_PROJECT_NAME && \
  mv /kedro/requirements.txt ./src/ && kedro install && \
  mv /kedro/spark.yml ./conf/base/ && \
  mv /kedro/context.py ./src/$KEDRO_PROJECT_NAME/ && \
  mv /kedro/pyspark_example.ipynb ./notebooks/ && \
  echo "Root folder of your kedro project: "$(pwd) && \
  echo $(pwd) && kedro jupyter lab --ip 0.0.0.0 --no-browser