# docker-keras

get account on https://ngc.nvidia.com/ 
to browse their catalog

## Postgres
 
docker run -d --rm --name postgres -p 5432:5432 postgres

## Run h2o in a deamon in an individual container in keras
 
docker run --rm --name h2o_java -d -p 54321:54321 -v /home/norayr/0MyDataBases/:/mdb keras   /bin/bash -c "java -Xmx8g -jar /mdb/h2o-3.20.0.2/h2o.jar -port 54321"
 
## to find out the internal docker container ip for h2o:
docker exec -ti h2o_java /bin/bash -c "ip addr show"
 
# Then can connect to the ip from above from another container 
 
## To run jupyter with keras
 
docker run --rm --name jupyter -d -p 8888:8888  -v /home/norayr/0MyDataBases/:/mdb keras /bin/bash -c "source /opt/conda/bin/activate keras && jupyter notebook --notebook-dir=/mdb --ip='0.0.0.0' --port=8888 --no-browser --allow-root"
