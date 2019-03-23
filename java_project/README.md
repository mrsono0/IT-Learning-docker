# 자바 개발 환경 구축

## Remote X Window Server for Windows  

- 리모트 엑스윈도우를 위한 윈도으즈용 엑스서버 프로그램  

```
--  https://sourceforge.net/projects/vcxsrv/  
-- https://sourceforge.net/projects/xming/ 

CMD 창에서 아래 명령을 실행
    xming :0 -ac -clipboard -multiwindow
```

- vs code + python + java 한글 패치 환경 by 원격 데스크톱

```
docker build -f Dockerfile.ide_java --tag mrsono0/java_project:ide_java .
docker run --rm -itd -e DISPLAY=172.18.48.1:0 -p 33890:3389 -p 2222:22 mrsono0/java_project:ide_java
docker tag java_project:ide_java mrsono0/java_project:ide_java
docker push mrsono0/java_project:ide_java
```
