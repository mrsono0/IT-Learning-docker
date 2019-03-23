# 빅데이터 개발 환경 구축

```
how do i change the location ??? because “C” is not my biggest drive 

    Stop docker etc
    Type “Hyper-V Manager” in task-bar search box and run it.
    Select your PC in the left hand pane (Mine is called DESKTOP-CBP**)
    Right click on the correct virtual machine (Mine is called MobyLinuxVM)
    Select “Turn off” (If it is running)
    Right click on it again and select “Move”
    Follow the prompts

Create file called c:\programdata\docker\config\daemon.json with content below where e:\images is location where do you want to store all you images etc. restart docker.

{

    "graph": "e:\\images" 
}

{
    “data-root”: “d:\\docker”
}

https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon
```

- Apache Spark Master + ssh + 한글 환경 패치

```
docker build -f Dockerfile.spark_master --tag mrsono0/bigdata_project:spark_master .
docker run --rm -it -p 8080:8080 -p 7077:7077 -p 6066:6066 -p 2222:22 mrsono0/bigdata_project:spark_master
docker tag bigdata_project:spark_master mrsono0/bigdata_project:spark_master
docker push mrsono0/bigdata_project:spark_master

To start a Spark master:

    docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:2.4.0-hadoop2.7
```

- Apache Spark Worker + ssh + 한글 환경 패치

```
docker build -f Dockerfile.spark_worker --tag mrsono0/bigdata_project:spark_worker .
docker run --rm -it -p 8080:8080 -p 7077:7077 -p 6066:6066 -p 2222:22 mrsono0/bigdata_project:spark_worker
docker tag bigdata_project:spark_worker mrsono0/bigdata_project:spark_worker
docker push mrsono0/bigdata_project:spark_worker

To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-worker:2.4.0-hadoop2.7

docker-compose -f Docker-compose_spark.yml up -d
docker-compose -f Docker-compose_spark.yml up -d --force-recreate
docker-compose up -d --build [<서비스 이름>]
docker-compose ps
docker-compose stop
docker-compose start
docker-compose down --volume
docker-compose exec django ./manage.py makemigrations
docker-compose logs -f django
```

- Apache Spark Submit + ssh + 한글 환경 패치

```
docker build -f Dockerfile.spark_submit --tag mrsono0/bigdata_project:spark_submit .
docker run --rm -it -p 8080:8080 -p 7077:7077 -p 6066:6066 -p 2222:22 mrsono0/bigdata_project:spark_submit
docker tag bigdata_project:spark_submit mrsono0/bigdata_project:spark_submit
docker push mrsono0/bigdata_project:spark_submit
```

- Apache Spark zeppelin + ssh + 한글 환경 패치

```
docker build -f Dockerfile.spark_zeppelin --tag mrsono0/bigdata_project:spark_zeppelin .
docker run --rm -it -p 8080:8080 -p 7077:7077 -p 6066:6066 -p 2222:22 mrsono0/bigdata_project:spark_zeppelin
docker run -it --rm --net spark-net -p 80:8080 mrsono0/bigdata_project:spark_zeppelin /bin/bash
docker tag bigdata_project:spark_zeppelin mrsono0/bigdata_project:spark_zeppelin
docker push mrsono0/bigdata_project:spark_zeppelin
```

- Apache zeppelin + ssh + 한글 환경 패치

```
docker build -f Dockerfile.zeppelin --tag mrsono0/bigdata_project:zeppelin .
docker run --rm -it -p 8080:8080 -p 2222:22 mrsono0/bigdata_project:zeppelin
docker tag bigdata_project:zeppelin mrsono0/bigdata_project:zeppelin
docker push mrsono0/bigdata_project:zeppelin
```

- Apache Hadoop namenode + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_namenode --tag mrsono0/bigdata_project:hadoop_namenode .
docker run --rm -it -p 50070:50070 -p 2222:22 mrsono0/bigdata_project:hadoop_namenode
docker tag bigdata_project:hadoop_namenode mrsono0/bigdata_project:hadoop_namenode
docker push mrsono0/bigdata_project:hadoop_namenode
```

- Apache Hadoop resourcemanager + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_resourcemanager --tag mrsono0/bigdata_project:hadoop_resourcemanager .
docker run --rm -it -p 8088:8088 -p 2222:22 mrsono0/bigdata_project:hadoop_resourcemanager
docker tag bigdata_project:hadoop_resourcemanager mrsono0/bigdata_project:hadoop_resourcemanager
docker push mrsono0/bigdata_project:hadoop_resourcemanager
```

- Apache Hadoop historyserver + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_historyserver --tag mrsono0/bigdata_project:hadoop_historyserver .
docker run --rm -it -p 8188:8188 -p 2222:22 mrsono0/bigdata_project:hadoop_historyserver
docker tag bigdata_project:hadoop_historyserver mrsono0/bigdata_project:hadoop_historyserver
docker push mrsono0/bigdata_project:hadoop_historyserver
```

- Apache Hadoop nodemanager + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_nodemanager --tag mrsono0/bigdata_project:hadoop_nodemanager .
docker run --rm -it -p 8042:8042 -p 2222:22 mrsono0/bigdata_project:hadoop_nodemanager
docker tag bigdata_project:hadoop_nodemanager mrsono0/bigdata_project:hadoop_nodemanager
docker push mrsono0/bigdata_project:hadoop_nodemanager
```

- Apache Hadoop datanode + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_datanode --tag mrsono0/bigdata_project:hadoop_datanode .
docker run --rm -it -p 50075:50075 -p 2222:22 mrsono0/bigdata_project:hadoop_datanode
docker tag bigdata_project:hadoop_datanode mrsono0/bigdata_project:hadoop_datanode
docker push mrsono0/bigdata_project:hadoop_datanode
```

- Apache Hadoop nginx + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_nginx --tag mrsono0/bigdata_project:hadoop_nginx .
docker run --rm -it -p 8080:80 -p 2222:22 mrsono0/bigdata_project:hadoop_nginx
docker run --rm -itd -p 8080:80 -e FLASK_APP=main/main.py -e FLASK_DEBUG=1 mrsono0/base_project:nginx_flask flask run --host=0.0.0.0 --port=80
docker tag bigdata_project:hadoop_nginx mrsono0/bigdata_project:hadoop_nginx
docker push mrsono0/bigdata_project:hadoop_nginx
```

- Apache Hadoop hive + ssh + 한글 환경 패치

```
docker build -f Dockerfile.hadoop_hive --tag mrsono0/bigdata_project:hadoop_hive .
docker run --rm -it -p 2222:22 mrsono0/bigdata_project:hadoop_hive
docker tag bigdata_project:hadoop_hive mrsono0/bigdata_project:hadoop_hive
docker push mrsono0/bigdata_project:hadoop_hive
docker-compose -f docker-compose_hive.yml up -d

https://hub.docker.com/u/bde2020
```
