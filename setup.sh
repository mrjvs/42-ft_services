# setup workdir
cd ./srcs/scripts

if [ $# = 0 ]; then
    # no args -> start full setup
    ./start.sh
elif [ $1 = "all" ]; then
    # arg1 = all -> start full setup
    ./start.sh
elif [ $1 = "pods" ]; then
    # arg1 = pods -> start/update pods
    echo "setting up pods"
    ./pods/start.sh
else
    echo "Error: argument not valid!"
    exit 1;
fi
