# 빅데이터 개발 환경 구축


- 알파인 3.9 기반 ssh + 한글 환경 패치  
```
    docker build -f Dockerfile.base_alpine --tag mrsono0/base_project:base_alpine_3_9 .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_alpine_3_9
    docker tag base_project:base_alpine_3_9 mrsono0/base_project:base_alpine_3_9
    docker push mrsono0/base_project:base_alpine_3_9
```

- 알파인 3.9 기반 ssh + 추가 라이브러리 + 한글 환경 패치  
```
    docker build -f Dockerfile.base_dev_alpine --tag mrsono0/base_project:base_dev_alpine_3_9 .
    docker run --rm -it -p 2222:22 mrsono0/base_project:base_dev_alpine_3_9
    docker tag base_project:base_dev_alpine_3_9 mrsono0/base_project:base_dev_alpine_3_9
    docker push mrsono0/base_project:base_dev_alpine_3_9
```

- 주피터 notebook + lab alpine + 한글 패치 환경
```
    docker build -f Dockerfile.jupyter_alpine_3_9 --tag mrsono0/base_project:jupyter_alpine_3_9 .
    docker run --rm -it -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes mrsono0/base_project:jupyter_alpine_3_9
    docker run --rm -it -p 8888:8888 -e JUPYTER_ENABLE_LAB=pyspark mrsono0/base_project:jupyter_alpine_3_9
    docker run --rm -it -p 8888:8888 mrsono0/base_project:jupyter_alpine_3_9
    docker tag base_project:jupyter_alpine_3_9 mrsono0/pythbase_projecton_project:jupyter_alpine_3_9
    docker push mrsono0/base_project:jupyter_alpine_3_9
```

- vscode alpine + 한글 패치 환경
```
    docker build -f Dockerfile.vscode_alpine_3_9 --tag mrsono0/base_project:vscode_alpine_3_9 .
    docker run --rm -it  mrsono0/base_project:vscode_alpine_3_9
    docker push mrsono0/base_project:vscode_alpine_3_9
```
