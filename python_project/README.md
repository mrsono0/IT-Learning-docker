# 빅데이터 개발 환경 구축


- 알파인 3.8 기반 도커 이미지 한글 환경 패치  
```
docker build -f Dockerfile.workspace --tag mrsono0/python_project:workspace .
docker create -v /workspace  mrsono0/python_project:workspace
docker run --rm --name workspace -itd -v /workspace -P mrsono0/python_project:workspace
docker tag python_project:workspace mrsono0/python_project:workspace
docker push mrsono0/python_project:workspace

docker build -f Dockerfile.alpine_anaconda3 --tag mrsono0/python_project:alpine_anaconda3 .
docker run --rm -it -p 8888:8888 -p 2222:22 -e notebook_dir="--notebook-dir=/root" mrsono0/python_project:alpine_anaconda3
docker tag python_project:alpine_anaconda3 mrsono0/python_project:alpine_anaconda3
docker push mrsono0/python_project:alpine_anaconda3
```

## Remote X Window Server for Windows  

- 리모트 엑스윈도우를 위한 윈도으즈용 엑스서버 프로그램  
```
--  https://sourceforge.net/projects/vcxsrv/  
-- https://sourceforge.net/projects/xming/ 
CMD 창에서 아래 명령을 실행
    xming :0 -ac -clipboard -multiwindow
```
- vs code + python + 한글 패치 환경 by 원격 데스크톱
```
docker build -f Dockerfile.ide_python --tag mrsono0/python_project:ide_python .
docker run --rm -itd -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_python
docker run --rm --volumes-from=workspace -itd -e DISPLAY=172.18.48.1:0 -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_python
docker run --rm -it -e DISPLAY=172.27.160.1:0 -net="host" -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_python
docker run --rm -it -e DISPLAY=192.168.0.192:0 -p 33890:3389 -p 2222:22 --net=host mrsono0/python_project:ide_python
docker tag python_project:ide_python mrsono0/python_project:ide_python
docker push mrsono0/python_project:ide_python
```

- vs code + anaconda3 + 한글 패치 환경 by 원격 데스크톱
```
docker build -f Dockerfile.ide_anaconda3 --tag mrsono0/python_project:ide_anaconda3 .
docker run --rm -itd -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_anaconda3
docker run --rm --volumes-from=workspace -itd -e DISPLAY=172.18.48.1:0 -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_anaconda3
docker run --rm -it -e DISPLAY=172.27.160.1:0 -net="host" -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_anaconda3
docker run --rm -it -e DISPLAY=192.168.0.192:0 -p 33890:3389 -p 2222:22 --net=host mrsono0/python_project:ide_anaconda3
docker tag python_project:ide_anaconda3 mrsono0/python_project:ide_anaconda3
docker push mrsono0/python_project:ide_anaconda3
```

- vs code + miniconda3 + 한글 패치 환경 by 원격 데스크톱
```
docker build -f Dockerfile.ide_miniconda3 --tag mrsono0/python_project:ide_miniconda3 .
docker run --rm -itd -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_miniconda3
docker run --rm --volumes-from=workspace -itd -e DISPLAY=172.18.48.1:0 -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_miniconda3
docker run --rm -it -e DISPLAY=172.27.160.1:0 -net="host" -p 33890:3389 -p 2222:22 mrsono0/python_project:ide_miniconda3
docker run --rm -it -e DISPLAY=192.168.0.192:0 -p 33890:3389 -p 2222:22 --net=host mrsono0/python_project:ide_miniconda3
docker tag python_project:ide_miniconda3 mrsono0/python_project:ide_miniconda3
docker push mrsono0/python_project:ide_miniconda3
```

## 빅데이터  

- 주피터 노트북 + 한글 패치 환경
```
docker build -f Dockerfile.jupyter --tag mrsono0/python_project:jupyter .
docker run --rm -itd -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -e notebook_dir="--notebook-dir=/root"  mrsono0/python_project:jupyter
docker tag python_project:jupyter mrsono0/python_project:jupyter
docker push mrsono0/python_project:jupyter
```