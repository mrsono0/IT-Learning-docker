# IT-Learning-docker

DockerFile for BigData

## 빅데이터 시스템 구축에 필요한 도커파일 정리.

- ubuntu 18.04 base
- sshd
- xrdp
- anaconda3
- jupyter notebook
- pytorch
- mxnet
- tensorflow cpu
- keras cpu
- khaiii
- spark
- zeppelin
- hadoop
- IDE

Contents:
- Ubuntu 18.04
- Mate Desktop (ubuntu repo)
- XRDP built from source (ubuntu repo)
- XRPDXORG built from source (ubuntu repo)
- tightvncserver (ubuntu repo)
- Epiphany web browser (ubuntu repo)
- openssh-server (always useful)
- Custom xrdp.ini script

```

docker run --name RattyDAVE18.04 \
           -p 3389:3389 \
           -p 2222:22 \
           -v %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE%:/root/createusers.txt \
           -v %LOCAL_PATH_TO_HOME_DIRECTORY%:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:18.04

```

- Replace %LOCAL_PATH_TO_CREATEUSERS.TXT_FILE% with the local filename of the createusers file.
- Replace %LOCAL_PATH_TO_HOME_DIRECTORY% with the local directory of the /home directorys.
- You do not need to publish port 22 only use if needed.

Example of a working command line.

```

docker run -d --name RattyDAVE18.04 \
           -p 3389:3389 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:18.04

```

I doubt most people would want this version but I have made available. This release contains development tools.

- x3270
- filezilla
- netbeans
- dia
- geany
- putty
- remmina 
- openjdk-11-jdk
- libreoffice
- pasmo
- BlueJ
- Rocket2014 (A RC2014 Z80 emulator - https://github.com/trcwm/rocket2014 - ROMs located in /opt/rocket2014/examples)

Screen sharing:
           On the master user connect using the Xvnc option and login as normal.
           On the desktop there is a file called session_info.txt this will contain the display number and password.
           
           On the other clients connect using the Reconnect option.
           Using the information in the session_info file:
                PORT = 5900 + display number. (So if display is 11 then the port would be 5911)
                USERNAME = Username of the master account.
                PASSWORD = the password in the Session_info.txt file. (e.g. 1a2b3c4d)
                

Example of a working command line.

```

docker run -d --name RattyDAVE18.04-tools \
           -p 3389:3389 -p 2222:22 \
           -v /root/createusers.txt:/root/createusers.txt \
           -v /root/home:/home \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:18.04-tools

```
spark-notebook

'''
docker run -p 8888:8888 jupyter/scipy-notebook:2c80cf3537ca
docker run -d -P --name notebook jupyter/all-spark-notebook

'''

## Apache Spark

The `jupyter/pyspark-notebook` and `jupyter/all-spark-notebook` images support the use of [Apache Spark](https://spark.apache.org/) in Python, R, and Scala notebooks. The following sections provide some examples of how to get started using them.

### Using Spark Local Mode

Spark local mode is useful for experimentation on small data when you do not have a Spark cluster available.

#### In a Python Notebook

```python
import pyspark
sc = pyspark.SparkContext('local[*]')

# do something to prove it works
rdd = sc.parallelize(range(1000))
rdd.takeSample(False, 5)
```
### Connecting to a Spark Cluster on Mesos

This configuration allows your compute cluster to scale with your data.

0. [Deploy Spark on Mesos](http://spark.apache.org/docs/latest/running-on-mesos.html).
1. Configure each slave with [the `--no-switch_user` flag](https://open.mesosphere.com/reference/mesos-slave/) or create the `$NB_USER` account on every slave node.
2. Run the Docker container with `--net=host` in a location that is network addressable by all of your Spark workers. (This is a [Spark networking requirement](http://spark.apache.org/docs/latest/cluster-overview.html#components).)
    * NOTE: When using `--net=host`, you must also use the flags `--pid=host -e TINI_SUBREAPER=true`. See https://github.com/jupyter/docker-stacks/issues/64 for details.
3. Follow the language specific instructions below.

#### In a Python Notebook

```python
import os
# make sure pyspark tells workers to use python3 not 2 if both are installed
os.environ['PYSPARK_PYTHON'] = '/usr/bin/python3'

import pyspark
conf = pyspark.SparkConf()

# point to mesos master or zookeeper entry (e.g., zk://10.10.10.10:2181/mesos)
conf.setMaster("mesos://10.10.10.10:5050")
# point to spark binary package in HDFS or on local filesystem on all slave
# nodes (e.g., file:///opt/spark/spark-2.2.0-bin-hadoop2.7.tgz)
conf.set("spark.executor.uri", "hdfs://10.10.10.10/spark/spark-2.2.0-bin-hadoop2.7.tgz")
# set other options as desired
conf.set("spark.executor.memory", "8g")
conf.set("spark.core.connection.ack.wait.timeout", "1200")

# create the context
sc = pyspark.SparkContext(conf=conf)

# do something to prove it works
rdd = sc.parallelize(range(100000000))
rdd.sumApprox(3)
```
### Connecting to a Spark Cluster in Standalone Mode

Connection to Spark Cluster on Standalone Mode requires the following set of steps:

0. Verify that the docker image (check the Dockerfile) and the Spark Cluster which is being deployed, run the same version of Spark.
1. [Deploy Spark in Standalone Mode](http://spark.apache.org/docs/latest/spark-standalone.html).
2. Run the Docker container with `--net=host` in a location that is network addressable by all of your Spark workers. (This is a [Spark networking requirement](http://spark.apache.org/docs/latest/cluster-overview.html#components).)
    * NOTE: When using `--net=host`, you must also use the flags `--pid=host -e TINI_SUBREAPER=true`. See https://github.com/jupyter/docker-stacks/issues/64 for details.
3. The language specific instructions are almost same as mentioned above for Mesos, only the master url would now be something like spark://10.10.10.10:7077

## Tensorflow

The `jupyter/tensorflow-notebook` image supports the use of [Tensorflow](https://www.tensorflow.org/) in single machine or distributed mode.

### Single Machine Mode

```python
import tensorflow as tf

hello = tf.Variable('Hello World!')

sess = tf.Session()
init = tf.global_variables_initializer()

sess.run(init)
sess.run(hello)
```

### Zeppelin Running docker image

```bash
docker run -p 8080:8080 --rm --name zeppelin apache/zeppelin:<release-version>  
```

* Zeppelin will run at `http://localhost:8080`.

If you want to specify `logs` and `notebook` dir,  

```bash
docker run -p 8080:8080 --rm \
-v $PWD/logs:/logs \
-v $PWD/notebook:/notebook \
-e ZEPPELIN_LOG_DIR='/logs' \
-e ZEPPELIN_NOTEBOOK_DIR='/notebook' \
--name zeppelin apache/zeppelin:<release-version> # e.g '0.7.1'
```

### Set the Default Java Version  
To check the default Java version you would use the following command:  
  
java -version  
Copy  
openjdk version "10.0.1" 2018-04-17  
OpenJDK Runtime Environment (build 10.0.1+10-Ubuntu-3ubuntu1)  
OpenJDK 64-Bit Server VM (build 10.0.1+10-Ubuntu-3ubuntu1, mixed mode)  
Copy  
If you have multiple Java versions installed on the server you can change  
the default version using the  update-alternatives tool as shown bellow:  
  
sudo update-alternatives --config java  
Copy  
There are 3 choices for the alternative java (providing /usr/bin/java).  
  
------------------------------------------------------------  
  Selection    Path                                            Priority   Status  
------------------------------------------------------------  
* 0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1101      auto mode  
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1101      manual mode  
  2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode  
  3            /usr/lib/jvm/java-8-oracle/jre/bin/java          1081      manual mode  
  4            /usr/local/oracle-java-10/jdk-10.0.2/bin/java    1500      manual mode  
  
Press <enter> to keep the current choice[*], or type selection number:  
Copy  
To change the default Java version just enter the version number  
(the number in the Selection column) and press Enter.
