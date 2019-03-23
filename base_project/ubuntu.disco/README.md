# 빅데이터 개발 환경 구축


- 우분투 19.04 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.base_disco --tag mrsono0/base_project:base_disco .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_disco
    docker tag base_project:base_disco mrsono0/base_project:base_disco
    docker push mrsono0/base_project:base_disco
```

- 우분투 19.04 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.base_dev_disco --tag mrsono0/base_project:base_dev_disco .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_dev_disco
    docker tag base_project:base_dev_disco mrsono0/base_project:base_dev_disco
    docker push mrsono0/base_project:base_dev_disco
```

- 주피터 notebook + lab 우분투 19.04 + 한글 패치 환경
```
    docker build -f Dockerfile.jupyter_disco --tag mrsono0/base_project:jupyter_disco .
    docker run --rm -it -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes mrsono0/base_project:jupyter_disco
    docker run --rm -it -p 8888:8888 -e JUPYTER_ENABLE_LAB=pyspark mrsono0/base_project:jupyter_disco
    docker tag base_project:jupyter_disco mrsono0/pythbase_projecton_project:jupyter_disco
    docker push mrsono0/base_project:jupyter_disco
```

- 우분투 19.04 기반 ssh + 원격데스크톱 + vscode + 한글 환경 패치  
```
    docker build -f Dockerfile.xrdp_disco --tag mrsono0/base_project:xrdp_disco .
    docker run --rm -it -p 33890:3389 -p3350:3350 -p 2222:22 mrsono0/base_project:xrdp_disco
    docker tag base_project:xrdp_disco mrsono0/base_project:xrdp_disco
    docker push mrsono0/base_project:xrdp_disco
```

- 우분투 19.04 기반 ssh + vscode + 한글 환경 패치  
```
    docker build -f Dockerfile.vscode_disco --tag mrsono0/base_project:vscode_disco .
    docker run --rm -it -p 33890:3389 -p 2222:22 mrsono0/base_project:vscode_disco
    docker tag base_project:vscode_disco mrsono0/base_project:vscode_disco
    docker push mrsono0/base_project:vscode_disco
```