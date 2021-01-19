# build.sh <container folder> <tag>

echo "--- BUILDING $2 ---"
CONTAINER_PATH="../containers/"
docker build -t $2 $CONTAINER_PATH$1
# docker tag $2 localhost:1234/$2:latest
# docker push localhost:1234/$2:latest
echo "--- FINISHING BUILDING $1 ---"
