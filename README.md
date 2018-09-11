# docker_chisel

```
cd /Users/i830671/Documents/XSA/docker_mysqls
docker build --no-cache -t alunde/mysqls:latest .
docker build -t alunde/mysqls:latest .
echo "docker run -ti -p 3306:3306 alunde/mysqls:latest"
docker push alunde/mysqls:latest
cf delete mysqls -f -r
cf push mysqls --docker-image alunde/mysqls:latest -m 640M -k 2G -n mysqls --no-start
cf enable-ssh mysqls
cf restart mysqls
cf ssh mysqls
```
