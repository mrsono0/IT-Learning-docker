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


- 알파인 3.8 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.base_alpine --tag mrsono0/base_project:base_alpine_3_8 .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_alpine_3_8
    docker tag base_project:base_alpine_3_8 mrsono0/base_project:base_alpine_3_8
    docker push mrsono0/base_project:base_alpine_3_8
```

- 알파인 3.8 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.base_dev_alpine --tag mrsono0/base_project:base_dev_alpine_3_8 .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_dev_alpine_3_8
    docker tag base_project:base_dev_alpine_3_8 mrsono0/base_project:base_dev_alpine_3_8
    docker push mrsono0/base_project:base_dev_alpine_3_8
```


- 파이썬 + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.python_alpine --tag mrsono0/base_project:python_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:python_alpine
    docker tag base_project:python mrsono0/base_project:python
    docker push mrsono0/base_project:python
```

- 파이썬 Miniconda3 + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.miniconda_alpine --tag mrsono0/base_project:miniconda_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:miniconda_alpine
    docker tag base_project:miniconda_alpine mrsono0/base_project:miniconda_alpine
    docker push mrsono0/base_project:miniconda_alpine
```

- 오픈jdk + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.java_alpine --tag mrsono0/base_project:java_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:java_alpine
    docker tag base_project:java mrsono0/base_project:java
    docker push mrsono0/base_project:java
    https://hub.docker.com/r/anapsix/alpine-java/dockerfile
```

- ruby ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.ruby_alpine --tag mrsono0/base_project:ruby_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:ruby_alpine
    docker tag base_project:ruby_alpine mrsono0/base_project:ruby_alpine
    docker push mrsono0/base_project:ruby_alpine
```

- go ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.go_alpine --tag mrsono0/base_project:go_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:go_alpine
    docker tag base_project:go_alpine mrsono0/base_project:go_alpine
    docker push mrsono0/base_project:go_alpine
```

- redmine + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.redmine_alpine --tag mrsono0/base_project:redmine_alpine .
    docker run --rm -it -p 3000:3000 -p 2222:22 mrsono0/base_project:redmine_alpine
    docker tag base_project:redmine_alpine mrsono0/base_project:redmine_alpine
    docker push mrsono0/base_project:redmine_alpine

    Running Redmine with a database server is the recommened way.
    start a database container https://hub.docker.com/_/redmine/

    PostgreSQL
        $ docker run -d --name some-postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=redmine postgres

    MySQL (replace --link some-postgres:postgres with --link some-mysql:mysql when running redmine)
        $ docker run -d --name some-mysql -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=redmine mysql

    start redmine
        $ docker run -d --name some-redmine --link some-postgres:postgres redmine

    https://hub.docker.com/r/inspiredgeek/redmine-alpine
```

- jenkins + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.jenkins_alpine --tag mrsono0/base_project:jenkins_alpine .
    docker run --rm -it -p 3000:3000 -p 2222:22 mrsono0/base_project:jenkins_alpine
    docker tag base_project:jenkins_alpine mrsono0/base_project:jenkins_alpine
    docker push mrsono0/base_project:jenkins_alpine

    You can also use a volume container:

    docker run --rm --name myjenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home mrsono0/base_project:jenkins

    https://hub.docker.com/_/jenkins
```

- ngingx + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.nginx_alpine --tag mrsono0/base_project:nginx_alpine .
    docker run --rm -itd -p 80:80 mrsono0/base_project:nginx_alpine
    docker tag base_project:nginx_alpine mrsono0/base_project:nginx_alpine
    docker push mrsono0/base_project:nginx_alpine
```

- flask + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.flask_alpine --tag mrsono0/base_project:flask_alpine .
    docker run --rm -itd --name mycontainer -p 80:80 -e FLASK_APP=main/main.py -e FLASK_DEBUG=1 mrsono0/base_project:flask_alpine flask run --host=0.0.0.0 --port=80
    docker run --rm -it -e FLASK_APP=main.py -e FLASK_DEBUG=1 -p 80:80 mrsono0/base_project:flask_alpine flask run --host=0.0.0.0 --port=80
    docker tag base_project:flask_alpine mrsono0/base_project:flask_alpine
    docker push mrsono0/base_project:flask_alpine

    https://hub.docker.com/r/tiangolo/uwsgi-nginx-flask
```

- tomcat + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.tomcat_alpine --tag mrsono0/base_project:tomcat_alpine .
    docker run --rm -it -p 8080:8080 -p 2222:22 mrsono0/base_project:tomcat_alpine
    docker tag base_project:tomcat_alpine mrsono0/base_project:tomcat_alpine
    docker push mrsono0/base_project:tomcat_alpine

    https://hub.docker.com/r/tiangolo/uwsgi-nginx-flask
```

- mariadb + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.mariadb_alpine --tag mrsono0/base_project:mariadb_alpine .
    docker run --rm -itd -e MYSQL_ROOT_PASSWORD=mariadb --link some-mariadb:mysql -p 3306:3306 mrsono0/base_project:mariadb_alpine
    docker run --rm -itd -e MYSQL_DATABASE=mariadb -e MYSQL_USER=mariadb -e MYSQL_PASSWORD=mariadb -e MYSQL_ROOT_PASSWORD=mariadb -p 3306:3306  mrsono0/base_project:mariadb_alpine
    docker tag base_project:mariadb_alpine mrsono0/base_project:mariadb_alpine
    docker push mrsono0/base_project:mariadb_alpine
```

- postgres + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.postgres_alpine --tag mrsono0/base_project:postgres_alpine .
    docker run --rm -itd -e POSTGRES_PASSWORD=mysecretpassword --link some-postgres:postgres -p 3306:3306 mrsono0/base_project:postgres_alpine
    docker tag base_project:postgres_alpine mrsono0/base_project:postgres_alpine
    docker push mrsono0/base_project:postgres_alpine

    https://hub.docker.com/_/postgres
```

- 주피터 notebook + lab alpine + 한글 패치 환경
```
    docker build -f Dockerfile.jupyter_alpine --tag mrsono0/base_project:jupyter_alpine .
    docker run --rm -it -p 8888:8888 -p 443:443 -p 2222:22 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter_alpine
    docker tag base_project:jupyter_alpine mrsono0/pythbase_projecton_project:jupyter_alpine
    docker push mrsono0/base_project:jupyter_alpine
```

- node + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.node_alpine --tag mrsono0/base_project:node_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:node_alpine
    docker tag base_project:node_alpine mrsono0/base_project:node_alpine
    docker push mrsono0/base_project:node_alpine

    https://hub.docker.com/_/node
```

## Remote X Window Server for Windows  

- 리모트 엑스윈도우를 위한 윈도으즈용 엑스서버 프로그램  

```
    --  https://sourceforge.net/projects/vcxsrv/  
    -- https://sourceforge.net/projects/xming/ 
    CMD 창에서 아래 명령을 실행
        xming :0 -ac -clipboard -multiwindow
```

- 엑스윈도우 xfce4 + alpine + python + java 한글 패치 환경 by 원격 데스크톱

```
    docker build -f Dockerfile.xfce4_alpine --tag mrsono0/base_project:xfce4_alpine .
    docker run --rm -itd -p 33890:3389 -p 2222:22 mrsono0/base_project:xfce4_alpine
    docker tag base_project:xfce4_alpine mrsono0/base_project:xfce4_alpine
    docker push mrsono0/base_project:xfce4_alpine

    https://hub.docker.com/r/marcelmaatkamp/alpine-xfce4-xrdp
    https://hub.docker.com/r/danielguerra/alpine-xfce4-xrdp
```
