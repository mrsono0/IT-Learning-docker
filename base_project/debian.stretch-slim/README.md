# 빅데이터 개발 환경 구축


- 데비안 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.debian_base --tag mrsono0/base_project:debian_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:debian_base
    docker push mrsono0/base_project:debian_base
```

- 데비안 기반 ssh + oracle xe + 한글 환경 패치  
```
    docker build -f Dockerfile.oraxe_1840 --tag mrsono0/base_project:oraxe_1840 .
    docker run --rm -it -p 2222:22 -p 8080:8080 -p 1521:1521 -p 5500:5500 mrsono0/base_project:oraxe_1840
    docker push mrsono0/base_project:oraxe_1840
```

- 데비안 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.debian_dev_base --tag mrsono0/base_project:debian_dev_base .
    docker run --rm -it -p 2222:22 mrsono0/base_project:debian_dev_base
    docker push mrsono0/base_project:debian_dev_base
```

- 파이썬 + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.python_debian --tag mrsono0/base_project:python_debian .
    docker run --rm -it -p 2222:22 mrsono0/base_project:python_debian
    docker tag base_project:python_debian mrsono0/base_project:python_debian
    docker push mrsono0/base_project:python_debian
```

- 오픈jdk + ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.java_debian --tag mrsono0/base_project:java_debian .
    docker run --rm -it -p 2222:22 mrsono0/base_project:java_debian
    docker tag base_project:java_debian mrsono0/base_project:java_debian
    docker push mrsono0/base_project:java_debian
    https://hub.docker.com/r/anapsix/alpine-java/dockerfile
```

- 주피터 notebook + lab alpine + 한글 패치 환경
```
    docker build -f Dockerfile.jupyter_debian --tag mrsono0/base_project:jupyter_debian .
    docker run --rm -it -p 8888:8888 -p 2222:22 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root" mrsono0/base_project:jupyter_debian
    docker tag base_project:jupyter_debian mrsono0/pythbase_projecton_project:jupyter_debian
    docker push mrsono0/base_project:jupyter_debian
```
