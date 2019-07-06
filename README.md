# Tensorflow + Python3 + Jupyter + Spark 2.4.3 + PySpark + Hadoop 2.7

# NOTE: The latest update supported `HTTPS (as default)` for Jupyter Notebook to increase security:
* Launch the **Tensorflow-Python3-Jupyter server** (`http://<ip>:28888/` or `https://<ip>:28888/` - default)
* Launch the **Tensorboard Web GUI server** (`http://<ip>:26006/` as default)

## To disable/enable HTTPS for Jupyter Notebook
Just edit the `./docker-run.env` file's entry "ENABLE_HTTPS".
The following changes back to `HTTP` instead of `HTTPS`.
```
## -- true to enable HTTPS; false to disable HTTPS:
ENABLE_HTTPS=false
#ENABLE_HTTPS=true
```
# Zeppelin Notebooks as alternative to Jupyter Notebooks
We also provide Zeppelin notebook [openkbs/docker-spark-bde2020-zeppelin](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/docker-spark-bde2020-zeppelin). If you want Scala/Java Spark ML/Mlib etc, you might try that as well. In all, we support both Zeppelin Notebooks and Jupyter Notebooks technologies for both Spark Scala/Java and Python/PySpark data science users' needs.

# Components:
* openjdk version "1.8.0_212"
  OpenJDK Runtime Environment (build 1.8.0_212-8u212-b01-1~deb9u1-b01)
  OpenJDK 64-Bit Server VM (build 25.212-b01, mixed mode)
* Apache Maven 3.6.0
* Python 3.6 / Python 2.7 + pip 19.1 + Python3 virtual environments (venv, virtualenv, virtualenvwrapper, mkvirtualenv, ..., etc.)
* Node v11.15.0 + npm 6.7.0 (from NodeSource official Node Distribution)
* Gradle 5.3
* Spark 2.4.3 + Hadoop 2.7
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

# Run
Two ways to run:
```
./run.sh
```
or
```
docker pull openkbs/tensorflow-python3-jupyter
docker-compose up -d
```
Once it is up, you can access it with:
* The default Jupyter password is (unless you change it in `docker.env` file): `ChangeMe!`
```
http://<IP_Address>:28888/ (Juypter Notebook)  -- if you disable HTTPS
https://<IP_Address>:28888/ (Juypter Notebook)  -- if you enable HTTPS
http://<IP_Address>:26006/ (Jupyter Tensorboard)
```
Where `<IP_Address>` will be:
- If running locally: `localhost`, `0.0.0.0`, `127.0.0.1`, or host's IP address.
- If running with Openshift: then find out the domain name that OpenShift has created for this container.

# How to change the default password?
Edit the ./docker-run.env file, say, to change to MyNewPassword!
```
#### Don't use any quote to enclose the password since it (quotes) will be treated as part of the value!
PASSWORD=StrongPassword
```

# What if I need more Python/PIP packages?
1. Enter the Container
```
./shell.sh
```
2. Install the new Python/PIP package, e.g.,
```
sudo python3 -m pip install <package>
or 
sudo pip install <package>
e.g.
    sudo pip install nose
    sudo pip install IPython
    sudo pip install pyGtk
    sudo pip install Scrapy
    . . . etc.
```
If you are using OpenShift / Origin Contaier Platform, you can use the Web UI to enter the `Container's Console` and then run the above Python package installation.

# (Other way) to install more packages - Inside Jupyter Notebook
```
# Install a pip package in the current Jupyter kernel
import sys
!{sys.executable} -m pip install <package>
e.g.
    import sys
    !{sys.executable} -m pip install numpy
```

# Problems in Login
Few reasons that your login password might not work:
1. You have multiple place set password and they are inconsistent: just search "***password***" and "***PASSWORD***" for all the files in the folder - basically, `docker-compose.yml, docker-run.sh, run-sh (if you modify it)`  files are key sources for setting up password for login.
2. It might be your Chrome or browsers auto feed old password: To solve this problem, 
Just launch a new `incognito windows` and then type URL as usuall:
```
http://<ip>:28888/  (if you disable HTTPS)
or
https://<ip>:28888/  (if you enable HTTPS)
```
# Resources & References
* [TnesorFlow Tutorials](https://www.tensorflow.org/tutorials)
* [Jupyter Notebook](https://jupyter.org/)
* [TensorFlow](https://www.tensorflow.org/)
* [scikit-learn](http://scikit-learn.org/stable/)
* [pandas](http://pandas.pydata.org/)
* [matplotlib](https://matplotlib.org/)
* [numpy](http://www.numpy.org/)
* [scipy](https://www.scipy.org/)
* [Pillow](https://pillow.readthedocs.io/en/4.1.x/)
* [Python 2 and 3](https://www.python.org/)
* [Gensim - Topic Modeling for Humans](https://radimrehurek.com/gensim/)
* [Text Analytics for Beginners using NLTK](https://www.datacamp.com/community/tutorials/text-analytics-beginners-nltk)
* [spaCy Notebooks](https://github.com/explosion/spacy-notebooks)
* [spaCy models for training](https://spacy.io/usage/training)

Note: the jupyter notebooks are only based on Python 3 kernels as default.

# See Also - docker-based IDE
* [openkbs/docker-spark-bde2020-zeppelin](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/docker-spark-bde2020-zeppelin): Spark (Scala/Java) Cluster with Spark ML/MLlib + Hadoop (HDFS)
* [openkbs/atom-docker](https://hub.docker.com/r/openkbs/atom-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
* [openkbs/knime-docker](https://hub.docker.com/r/openkbs/knime-docker/)
* [openkbs/knime-vnc-docker](https://hub.docker.com/r/openkbs/knime-vnc-docker/)
* [openkbs/netbeans10-docker](https://hub.docker.com/r/openkbs/netbeans10-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/rapidminer-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rapidminer-docker)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)
* [openkbs/webstorm-vnc-docker](https://hub.docker.com/r/openkbs/webstorm-vnc-docker/)

# Python Packages List
```
import sys
!{sys.executable} -m pip list

Package              Version               
-------------------- ----------------------
absl-py              0.7.1                 
astor                0.7.1                 
atomicwrites         1.3.0                 
attrs                19.1.0                
backcall             0.1.0                 
beautifulsoup4       4.4.1                 
bleach               3.1.0                 
boto                 2.49.0                
boto3                1.9.130               
botocore             1.12.130              
bz2file              0.98                  
certifi              2019.3.9              
chardet              3.0.4                 
Click                7.0                   
cycler               0.10.0                
decorator            4.4.0                 
defusedxml           0.5.0                 
docutils             0.14                  
entrypoints          0.3                   
findspark            1.3.0                 
Flask                1.0.2                 
funcy                1.11                  
future               0.17.1                
gast                 0.2.2                 
gensim               3.7.2                 
grpcio               1.19.0                
h5py                 2.9.0                 
html5lib             0.999                 
httpie               1.0.2                 
hyperopt             0.1.2                 
idna                 2.8                   
ipaddress            1.0.22                
ipykernel            5.1.0                 
ipython              7.4.0                 
ipython-genutils     0.2.0                 
ipywidgets           7.4.2                 
itsdangerous         1.1.0                 
j2cli                0.3.6.post1           
jedi                 0.13.3                
Jinja2               2.10.1                
jmespath             0.9.4                 
joblib               0.13.2                
jsonschema           3.0.1                 
jupyter              1.0.0                 
jupyter-client       5.2.4                 
jupyter-console      6.0.0                 
jupyter-core         4.4.0                 
Keras                2.2.4                 
Keras-Applications   1.0.7                 
Keras-Preprocessing  1.0.9                 
kiwisolver           1.0.1                 
langdetect           1.0.7                 
lxml                 3.5.0                 
Markdown             3.1                   
MarkupSafe           1.1.1                 
matplotlib           3.0.3                 
mistune              0.8.4                 
mock                 2.0.0                 
more-itertools       7.0.0                 
nbconvert            5.4.1                 
nbformat             4.4.0                 
networkx             2.3                   
nltk                 3.4                   
notebook             5.7.8                 
numexpr              2.6.9                 
numpy                1.16.2                
panda                0.3.1                 
pandas               0.24.2                
pandasql             0.7.3                 
pandocfilters        1.4.2                 
parso                0.4.0                 
pathlib2             2.3.3                 
pbr                  5.1.3                 
pexpect              4.7.0                 
pickleshare          0.7.5                 
Pillow               6.0.0                 
pip                  19.0.3                
pkgconfig            1.5.1                 
pluggy               0.9.0                 
prometheus-client    0.6.0                 
prompt-toolkit       2.0.9                 
protobuf             3.7.1                 
ptyprocess           0.6.0                 
py                   1.8.0                 
py4j                 0.10.7                
pycurl               7.43.0                
Pygments             2.3.1                 
pygobject            3.20.0                
pyLDAvis             2.1.2                 
pymongo              3.7.2                 
pyparsing            2.3.1                 
pyrsistent           0.14.11               
pyspark              2.4.1                 
pytest               4.4.0                 
python-apt           1.1.0b1+ubuntu0.16.4.2
python-dateutil      2.8.0                 
pytz                 2018.9                
PyYAML               5.1                   
pyzmq                18.0.1                
qtconsole            4.4.3                 
requests             2.21.0                
s3transfer           0.2.0                 
scikit-learn         0.20.3                
scipy                1.2.1                 
seaborn              0.9.0                 
Send2Trash           1.5.0                 
setuptools           41.0.0                
singledispatch       3.4.0.3               
six                  1.12.0                
smart-open           1.8.1                 
SQLAlchemy           1.3.2                 
stevedore            1.30.1                
tables               3.2.2                 
tensorboard          1.13.1                
tensorflow           1.13.1                
tensorflow-estimator 1.13.0                
termcolor            1.1.0                 
terminado            0.8.2                 
testpath             0.4.2                 
tornado              6.0.2                 
tqdm                 4.31.1                
traitlets            4.3.2                 
unattended-upgrades  0.1                   
urllib3              1.24.1                
virtualenv           16.4.3                
virtualenv-clone     0.5.2                 
virtualenvwrapper    4.8.4                 
wcwidth              0.1.7                 
webencodings         0.5.1                 
Werkzeug             0.15.2                
wheel                0.33.1                
widgetsnbextension   3.4.2                 
```

# Releases Information
```
developer@2368ba1413d1:~$ /usr/scripts/printVersions.sh 
+ echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
+ java -version
openjdk version "1.8.0_212"
OpenJDK Runtime Environment (build 1.8.0_212-8u212-b01-1~deb9u1-b01)
OpenJDK 64-Bit Server VM (build 25.212-b01, mixed mode)
+ mvn --version
Apache Maven 3.6.0 (97c98ec64a1fdfee7767ce5ffb20918da4f719f3; 2018-10-24T18:41:47Z)
Maven home: /usr/apache-maven-3.6.0
Java version: 1.8.0_212, vendor: Oracle Corporation, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.18.0-25-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.13
+ python3 -V
Python 3.5.3
+ pip --version
pip 19.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)
+ pip3 --version
pip 19.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)
+ gradle --version

Welcome to Gradle 5.3.1!

Here are the highlights of this release:
 - Feature variants AKA "optional dependencies"
 - Type-safe accessors in Kotlin precompiled script plugins
 - Gradle Module Metadata 1.0

For more details see https://docs.gradle.org/5.3.1/release-notes.html


------------------------------------------------------------
Gradle 5.3.1
------------------------------------------------------------

Build time:   2019-03-28 09:09:23 UTC
Revision:     f2fae6ba563cfb772c8bc35d31e43c59a5b620c3

Kotlin:       1.3.21
Groovy:       2.5.4
Ant:          Apache Ant(TM) version 1.9.13 compiled on July 10 2018
JVM:          1.8.0_212 (Oracle Corporation 25.212-b01)
OS:           Linux 4.18.0-25-generic amd64

+ npm -v
6.7.0
+ node -v
v11.14.0
+ cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```
