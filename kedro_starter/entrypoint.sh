dir=$(find . -type d | grep -Ev "(^\.$)|(^[^\/]?\/[^\/]+\/.*$)|(^\.\/\..*$)|(^.*kedro_starter.*$)")
dir=$(basename $dir)
dir=$(echo $dir | xargs)
cd $(pwd)/$dir && echo $(pwd) && kedro jupyter lab --ip 0.0.0.0 || kedro new --config kedro_starter/config.yml && echo "please restart the docker container"