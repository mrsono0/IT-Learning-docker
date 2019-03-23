# 빅데이터 개발 환경 구축


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
    docker build -f Dockerfile.teradatasql_bionic --tag mrsono0/base_project:teradatasql_bionic .
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