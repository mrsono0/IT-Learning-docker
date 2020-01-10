# 빅데이터 개발 환경 구축

## Python

- ### Anaconda3 2019.10

```
docker build -f anaconda3.Dockerfile --tag mrsono0/devremotecontainers:anaconda3 .

docker run --rm --name anaconda3 -itd mrsono0/devremotecontainers:anaconda3

docker run --rm --name anaconda3 -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes mrsono0/devremotecontainers:anaconda3

docker run --rm --name anaconda3 -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -v ~:/home/vscode/prj --net=container:ora11xe --link ora11xe -e JUPYTER_RUN=yes mrsono0/devremotecontainers:anaconda3

docker push mrsono0/devremotecontainers:anaconda3
```

## AI

- ### Crawling (Chrome for Selenium)

```
docker build -f crawling.Dockerfile --tag mrsono0/devremotecontainers:crawling .

docker run --rm --name crawling -itd -u vscode -p 4444:4444 -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes mrsono0/devremotecontainers:crawling

docker push mrsono0/devremotecontainers:crawling
```

- ### EDA (numpy, pandas, ... anaconda3)

```
docker build -f eda.Dockerfile --tag mrsono0/devremotecontainers:eda .

docker run --rm --name eda -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes mrsono0/devremotecontainers:eda

for Mac -v option
docker run --rm --name eda -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes -v /Users/mrsono0/OneDrive/MacBookPro/PNU_201912/5.탐색기반데이터분석기법:/home/vscode/notebooks mrsono0/devremotecontainers:eda

for windows -v option
docker run --rm --name eda -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes -v /C/Users/user/PNU_201912/eda:/home/vscode/notebooks/eda mrsono0/devremotecontainers:eda

docker push mrsono0/devremotecontainers:eda
```

- ### ML, DL and Docker-for-AI-Researcher

```
docker build -f ai.Dockerfile --tag mrsono0/devremotecontainers:ai .

docker run --rm --name ai -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes mrsono0/devremotecontainers:ai

docker push mrsono0/devremotecontainers:ai
```

- ### Hadoop Spark
1. hadoop-env.sh 파일에 아래 내용 수정

```
vi /opt/hadoop-3.1.3/etc/hadoop/hadoop-env.sh
export JAVA_HOME=/usr/local/jdk-11.0.5
```
2. /opt/hadoop-3.1.3/logs 디렉토리 권한 변경

```
chmod -R 777 /opt/hadoop-3.1.3/logs
```
3. namenode format
```
hadoop namenode -format
```

Run `docker network inspect` on the network (e.g. `dockerhadoop_default`) to find the IP the hadoop interfaces are published on. Access these interfaces with the following URLs:

* Namenode: http://<dockerhadoop_IP_address>:9870/dfshealth.html#tab-overview
* History server: http://<dockerhadoop_IP_address>:8188/applicationhistory
* Datanode: http://<dockerhadoop_IP_address>:9864/
* Nodemanager: http://<dockerhadoop_IP_address>:8042/node
* Resource manager: http://<dockerhadoop_IP_address>:8088/

```
docker build -f hadoop_spark.Dockerfile --tag mrsono0/devremotecontainers:hadoop_spark .

docker run --rm --name hadoop -itd -u vscode -p 9000:9000 -p 9870:9870 -p 9864:9864 -p8042:8042 -p 8088:8088 -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes mrsono0/devremotecontainers:hadoop_spark

docker push mrsono0/devremotecontainers:hadoop_spark
```

## Oracle XE 11G apex (웹 관리 기능)

```
    apex Login http://localhost:8080/apex/apex_admin with following credential:
    username: ADMIN
    password: admin
    Login http://localhost:8080/apex/apex_admin with following credential:
    username: ADMIN
    password: Oracle_11g

    By default, the password verification is disable(password never expired)<br/>
    Connect database with following setting:
    hostname: localhost
    port: 1521
    sid: xe
    username: system
    password: oracle

    Password for SYS & SYSTEM : oracle

    alter user hr account unlock;
    alter user hr identified by hr;

docker build -f oraxe11g.Dockerfile --tag mrsono0/devremotecontainers:oraxe11g .

docker run --rm --name oraxe11g -itd -p 8080:8088 -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true mrsono0/devremotecontainers:oraxe11g

docker push mrsono0/devremotecontainers:oraxe11g

docker build -f oraexpress18c.Dockerfile --tag mrsono0/devremotecontainers:oraexpress18c .

docker run --rm --name oraexpress18c -itd -p 8080:8088 -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true mrsono0/devremotecontainers:oraexpress18c

docker push mrsono0/devremotecontainers:oraexpress18c
```

## Rust

```
docker build -f rust1.40.0.Dockerfile --tag mrsono0/devremotecontainers:rust1.40.0 .

docker run --rm --name rust -itd -u vscode -p 8888-8889:8888-8889 -p 6006-6015:6006-6015 -e JUPYTER_RUN=yes mrsono0/devremotecontainers:rust1.40.0

docker push mrsono0/devremotecontainers:rust1.40.0
```

- 우분투 18.04 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.base_bionic --tag mrsono0/base_project:base_bionic .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_bionic
    docker push mrsono0/base_project:base_bionic
```

- 우분투 18.04 기반 ssh + java, python, node.js, go, g++ 한글 환경 패치  
```
    docker build -f Dockerfile.base_dev_bionic --tag mrsono0/base_project:base_dev_bionic .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_dev_bionic
    docker push mrsono0/base_project:base_dev_bionic
```

- 우분투 18.04 기반 ssh + Jupyter 한글 환경 패치  
```
    docker build -f Dockerfile.jupyter_bionic --tag mrsono0/base_project:jupyter_bionic .
    docker run --rm -it -p 8888:8888 mrsono0/base_project:jupyter_bionic
    docker run --rm -it -p 8889:8888 -e JUPYTER_ENABLE_LAB=no mrsono0/base_project:jupyter_bionic
    docker run --rm -it -p 8888:8888 -e JUPYTER_ENABLE_LAB=pyspark mrsono0/base_project:jupyter_bionic
    docker push mrsono0/base_project:jupyter_bionic
    docker exec -it centos01 /bin/bash
```
[Jupyter Magics with SQL : ](https://towardsdatascience.com/jupyter-magics-with-sql-921370099589)
```
    %load_ext sql
    %sql oracle://system:oracle@192.168.1.3:1521/xe
    %sql SELECT 1 as "test" from dual
```
[Jupyter beakerx : ](https://github.com/twosigma/beakerx/blob/master/doc/sql/Sql.ipynb)
```
    ENV BEAKERX_SQL_DEFAULT_JDBC jdbc:h2:mem:db
    %classpath /usr/lib/jdbc/ojdbc8.jar;/usr/lib/jdbc/mysql-connector-java-5.1.47-bin.jar
    %defaultDatasource jdbc:h2:mem:db
```

- 우분투 18.04 기반 ssh + Jupyter teradatasql 한글 환경 패치  
```
    docker build -f Dockerfile.teradatasql_base_bionic --tag mrsono0/base_project:teradatasql_base_bionic .
    docker build -f Dockerfile.teradatasql_dev_bionic --tag mrsono0/base_project:teradatasql_dev_bionic .
    docker build -f Dockerfile.teradatasql_bionic --tag mrsono0/base_project:teradatasql_bionic .
    docker run --rm -it -p 8081:8081 mrsono0/base_project:teradatasql_dev_bionic
    docker run --rm -it -p 8888:8888 mrsono0/base_project:teradatasql_bionic
    docker run --rm -it -p 8889:8888 -e JUPYTER_ENABLE_LAB=no mrsono0/base_project:teradatasql_bionic
    docker run --rm -it -p 8888:8888 -e JUPYTER_ENABLE_LAB=pyspark mrsono0/base_project:teradatasql_bionic
    docker push mrsono0/base_project:teradatasql_bionic
```

- 우분투 18.04 기반 ssh + Oracle XE 11g 한글 환경 패치  
```
    docker build -f Dockerfile.oraxe11g_bionic --tag mrsono0/base_project:oraxe11g_bionic .
    docker run --rm -it -p 5500:5500 -p 8080:8080 -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true mrsono0/base_project:oraxe11g_bionic
    docker push mrsono0/base_project:oraxe11g_bionic
    Connect database with following setting:
        hostname: localhost
        port: 1521
        sid: xe
        username: system
        password: oracle
        Password for SYS & SYSTEM: oracle
    Connect to Oracle Application Express web management console with following settings:
        https://localhost:5500/em
        http://localhost:8080/apex/apex_admin
        username: ADMIN
        password: admin
        or
        username: ADMIN
        password: Oracle_11g
        http://localhost:8080/apex
        workspace: INTERNAL
        user: ADMIN
        password: Oracle_11g
```

- 우분투 18.04 기반 ssh + vscode 한글 환경 패치  
```
    docker build -f Dockerfile.vscode_bionic --tag mrsono0/base_project:vscode_bionic .
    docker run --rm -it --net="host" -e DISPLAY=$DISPLAY mrsono0/base_project:vscode_bionic
    docker run --rm -it -e DISPLAY=$DISPLAY mrsono0/base_project:vscode_bionic
    set-variable -name DISPLAY -value 10.0.75.1:0.0
    set-variable -name DISPLAY -value 172.17.0.1:0.0
    docker push mrsono0/base_project:vscode_bionic
```

- 우분투 18.04 기반 ssh + zeppelin 한글 환경 패치  
```
    docker build -f Dockerfile.zeppelin_bionic --tag mrsono0/base_project:zeppelin_bionic .
    docker run --rm -it -p 8080:8080 mrsono0/base_project:zeppelin_bionic
    docker push mrsono0/base_project:zeppelin_bionic
```
