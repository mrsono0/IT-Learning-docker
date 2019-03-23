# 빅데이터 개발 환경 구축


- 알파인 3.8 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.alpine_base --tag mrsono0/base_project:alpine_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:alpine_base
    docker tag base_project:alpine_base mrsono0/base_project:alpine_base
    docker push mrsono0/base_project:alpine_base
```

- 알파인 3.8 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.alpine_dev_base --tag mrsono0/base_project:alpine_dev_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:alpine_dev_base
    docker tag base_project:alpine_dev_base mrsono0/base_project:alpine_dev_base
    docker push mrsono0/base_project:alpine_dev_base
```

- 데비안 18.04 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.debian_base --tag mrsono0/base_project:debian_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:debian_base
    docker tag base_project:debian_base mrsono0/base_project:debian_base
    docker push mrsono0/base_project:debian_base
```

- 데비안 18.04 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.debian_dev_base --tag mrsono0/base_project:debian_dev_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:debian_dev_base
    docker tag base_project:debian_dev_base mrsono0/base_project:debian_dev_base
    docker push mrsono0/base_project:debian_dev_base
```


- 우분투 18.04 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.ubuntu_base --tag mrsono0/base_project:ubuntu_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:ubuntu_base
    docker tag base_project:ubuntu_base mrsono0/base_project:ubuntu_base
    docker push mrsono0/base_project:ubuntu_base
```

- 우분투 18.04 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.ubuntu_dev_base --tag mrsono0/base_project:ubuntu_dev_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:ubuntu_dev_base
    docker tag base_project:ubuntu_dev_base mrsono0/base_project:ubuntu_dev_base
    docker push mrsono0/base_project:ubuntu_dev_base
```

- 파이썬 + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.python --tag mrsono0/base_project:python .
    docker build -f Dockerfile.python_alpine --tag mrsono0/base_project:python_alpine .
    docker build -f Dockerfile.python_debian --tag mrsono0/base_project:python_debian .
    docker run --rm -it -p 2222:22 mrsono0/base_project:python_alpine
    docker run --rm -it -p 2222:22 mrsono0/base_project:python_debian
    docker tag base_project:python mrsono0/base_project:python
    docker push mrsono0/base_project:python
```

- 오픈jdk + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.java --tag mrsono0/base_project:java .
    docker build -f Dockerfile.java_alpine --tag mrsono0/base_project:java_alpine .
    docker build -f Dockerfile.java_debian --tag mrsono0/base_project:java_debian .
    docker run --rm -it -p 2222:22 mrsono0/base_project:java_debian
    docker tag base_project:java mrsono0/base_project:java
    docker push mrsono0/base_project:java
    https://hub.docker.com/r/anapsix/alpine-java/dockerfile
```

- ruby ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.ruby --tag mrsono0/base_project:ruby .
    docker build -f Dockerfile.ruby_alpine --tag mrsono0/base_project:ruby_alpine .
    docker run --rm -it -p 2222:22 mrsono0/base_project:ruby
    docker tag base_project:ruby mrsono0/base_project:ruby
    docker push mrsono0/base_project:ruby
```

- redmine + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.redmine --tag mrsono0/base_project:redmine .
    docker build -f Dockerfile.redmine_alpine --tag mrsono0/base_project:redmine_alpine .
    docker run --rm -it -p 3000:3000 -p 2222:22 mrsono0/base_project:redmine
    docker tag base_project:redmine mrsono0/base_project:redmine
    docker push mrsono0/base_project:redmine

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
    docker build -f Dockerfile.jenkins --tag mrsono0/base_project:jenkins .
    docker build -f Dockerfile.jenkins_alpine --tag mrsono0/base_project:jenkins_alpine .
    docker run --rm -it -p 3000:3000 -p 2222:22 mrsono0/base_project:jenkins
    docker tag base_project:jenkins mrsono0/base_project:jenkins
    docker push mrsono0/base_project:jenkins

    You can also use a volume container:

    docker run --rm --name myjenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home mrsono0/base_project:jenkins

    https://hub.docker.com/_/jenkins
```

- workspace 우분투 18.04 기반 ssh + 한글 환경 패치 : 데이터 볼륨 컨테이너  
```
    docker build -f Dockerfile.workspace --tag mrsono0/base_project:workspace .
    docker run --rm -it -p 2222:22 mrsono0/base_project:workspace
    docker create -v /workspace  mrsono0/base_project:workspace
    docker run --rm -itd --name workspace -v /workspace -P mrsono0/base_project:workspace
    docker tag base_project:workspace mrsono0/base_project:workspace
    docker push mrsono0/base_project:workspace
```

- ngingx + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.nginx --tag mrsono0/base_project:nginx .
    docker build -f Dockerfile.nginx_alpine --tag mrsono0/base_project:nginx_alpine .
    docker run --rm -itd -p 80:80 mrsono0/base_project:nginx
    docker run --rm -itd -p 80:80 mrsono0/base_project:nginx_alpine
    docker tag base_project:nginx mrsono0/base_project:nginx
    docker push mrsono0/base_project:nginx
```

- flask + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.flask --tag mrsono0/base_project:flask .
    docker build -f Dockerfile.flask_alpine --tag mrsono0/base_project:flask_alpine .
    docker run --rm -itd --name mycontainer -p 80:80 -e FLASK_APP=main.py -e FLASK_DEBUG=1 mrsono0/base_project:flask flask run --host=0.0.0.0 --port=80
    docker run --rm -itd --name mycontainer -p 80:80 -e FLASK_APP=main/main.py -e FLASK_DEBUG=1 mrsono0/base_project:flask_alpine flask run --host=0.0.0.0 --port=80
    docker run --rm -itd -p 80:80 mrsono0/base_project:flask
    docker tag base_project:flask mrsono0/base_project:flask
    docker push mrsono0/base_project:flask

    https://hub.docker.com/r/tiangolo/uwsgi-nginx-flask
```

- ngingx + flask + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.nginx_flask --tag mrsono0/base_project:nginx_flask .
    docker run --rm -itd -p 80:80 -e FLASK_APP=main/main.py -e FLASK_DEBUG=1 mrsono0/base_project:nginx_flask flask run --host=0.0.0.0 --port=80
    docker tag base_project:nginx_flask mrsono0/base_project:nginx_flask
    docker push mrsono0/base_project:nginx_flask
```

- mariadb + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.mariadb --tag mrsono0/base_project:mariadb .
    docker build -f Dockerfile.mariadb_alpine --tag mrsono0/base_project:mariadb_alpine .
    docker run --rm -itd -e MYSQL_ROOT_PASSWORD=mariadb --link some-mariadb:mysql -p 3306:3306 mrsono0/base_project:mariadb
    docker run --rm -itd -e MYSQL_DATABASE=mariadb -e MYSQL_USER=mariadb -e MYSQL_PASSWORD=mariadb -e MYSQL_ROOT_PASSWORD=mariadb -p 3306:3306  mrsono0/base_project:mariadb
    docker tag base_project:mariadb mrsono0/base_project:mariadb
    docker push mrsono0/base_project:mariadb
```

- postgres + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.postgres --tag mrsono0/base_project:postgres .
    docker build -f Dockerfile.postgres_alpine --tag mrsono0/base_project:postgres_alpine .
    docker run --rm -itd -e POSTGRES_PASSWORD=mysecretpassword --link some-postgres:postgres -p 3306:3306 mrsono0/base_project:postgres
    docker tag base_project:postgres mrsono0/base_project:postgres
    docker push mrsono0/base_project:postgres

    https://hub.docker.com/_/postgres
```

- 오라클 xe 11g apex (웹 관리 기능) + ssh + 한글 환경 패치  
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

    docker build -f Dockerfile.ora_xe_11g --tag mrsono0/base_project:ora_xe_11g .
    docker run --rm -itd -p 8080:8080 -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true mrsono0/base_project:ora_xe_11g
    docker tag base_project:ora_xe_11g mrsono0/base_project:ora_xe_11g
    docker push mrsono0/base_project:ora_xe_11g
```

- 주피터 notebook + lab + Miniconda3 + 한글 패치 환경
```
    docker build -f Dockerfile.jupyter_base --tag mrsono0/base_project:jupyter_base .
    docker run --rm -it -p 8888:8888 -p 2222:22 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root"  mrsono0/base_project:jupyter_base
    docker run --rm -it -p 8888:8888 -p 2222:22 -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter_base
    docker tag base_project:jupyter_base mrsono0/pythbase_projecton_project:jupyter_base
    docker push mrsono0/base_project:jupyter_base
```

- 주피터 notebook + lab alpine + 한글 패치 환경
```
    docker build -f Dockerfile.jupyter --tag mrsono0/base_project:jupyter .
    docker build -f Dockerfile.jupyter_alpine --tag mrsono0/base_project:jupyter_alpine .
    docker build -f Dockerfile.jupyter_debian --tag mrsono0/base_project:jupyter_debian .
    docker run --rm -it -p 8888:8888 -p 2222:22 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter
    docker run --rm -it -p 8888:8888 -p 443:443 -p 2222:22 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter_alpine
    docker run --rm -it -p 8888:80 -p 443:443 -p 2222:22 -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter_alpine
    docker run --rm -it -p 8888:8888 -p 2222:22 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter_debian
    docker tag base_project:jupyter_alpine mrsono0/pythbase_projecton_project:jupyter_alpine
    docker push mrsono0/base_project:jupyter_alpine
```

- Apache Spark base + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.spark_base --tag mrsono0/base_project:spark_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:spark_base
    docker tag base_project:spark_base mrsono0/base_project:spark_base
    docker push mrsono0/base_project:spark_base
```

- Apache hadoop base + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.hadoop_base --tag mrsono0/base_project:hadoop_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:hadoop_base
    docker tag base_project:hadoop_base mrsono0/base_project:hadoop_base
    docker push mrsono0/base_project:hadoop_base
```

- Apache zeppelin base + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.zeppelin_base --tag mrsono0/base_project:zeppelin_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:zeppelin_base
    docker tag base_project:zeppelin_base mrsono0/base_project:zeppelin_base
    docker push mrsono0/base_project:zeppelin_base
```

- node + ssh + 한글 환경 패치
```
    docker build -f Dockerfile.node --tag mrsono0/base_project:node .
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

- 엑스윈도우 + vs code + python + java 한글 패치 환경 by 원격 데스크톱

```
    docker build -f Dockerfile.ide_xfce4 --tag mrsono0/base_project:ide_xfce4 .
    docker build -f Dockerfile.ide_mate --tag mrsono0/base_project:ide_mate .
    docker run --rm -itd -e DISPLAY=172.18.48.1:0 -p 33890:3389 -p 2222:22 mrsono0/base_project:ide_xfce4
    docker run --rm -itd -p 33890:3389 -p 2222:22 mrsono0/base_project:ide_mate
    docker tag base_project:ide mrsono0/base_project:ide
    docker push mrsono0/base_project:ide
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
