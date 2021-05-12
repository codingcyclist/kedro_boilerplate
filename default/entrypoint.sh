# replacing placeholder in the project config with the kedro project name
sed -i "s/<[^>]*>/$KEDRO_PROJECT_NAME/g" /kedro/config.yml

if [ -d "$(pwd)/$KEDRO_PROJECT_NAME" ]; then
  cd $(pwd)/$KEDRO_PROJECT_NAME && echo $(pwd) && kedro jupyter lab --ip 0.0.0.0 --no-browser
  exit 0
else
  kedro new --config /kedro/config.yml --verbose && \
  cd $(pwd)/$KEDRO_PROJECT_NAME && \
  mv /kedro/requirements.txt ./src/ && \
  mv /kedro/kedro_example.ipynb /notebooks/kedro_example.ipynb && \
  kedro install && \
  echo "Root folder of your kedro project: "$(pwd) && \
  echo $(pwd) && kedro jupyter lab --ip 0.0.0.0 --no-browser
  exit 0
fi