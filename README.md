# Tensorflow + Python3 + Jupyter + PySpark + Spark 3.0 + Hadoop 3.2

# NOTE: The latest update supported `HTTPS (as default)` for Jupyter Notebook to increase security:
* Launch the **Tensorflow-Python3-Jupyter server** (`http://<ip>:28888/` or `https://<ip>:28888/` - default) -- To change HTTPS or HTTP, see next paragraph.
* Launch the **Tensorboard Web GUI server** (`http://<ip>:26006/` as default)

## To disable/enable HTTPS for Jupyter Notebook
Just edit the `.env` file's entry "ENABLE_HTTPS".
The following changes back to `HTTP` instead of `HTTPS`.
```
## -- true to enable HTTPS; false to disable HTTPS:
ENABLE_HTTPS=false
#ENABLE_HTTPS=true
```
# Zeppelin Notebooks as alternative to Jupyter Notebooks
We also provide Zeppelin notebook [openkbs/docker-spark-bde2020-zeppelin](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/docker-spark-bde2020-zeppelin). If you want Scala/Java Spark ML/Mlib etc, you might try that as well. In all, we support both Zeppelin Notebooks and Jupyter Notebooks technologies for both Spark Scala/Java and Python/PySpark data science users' needs.

# Components:
* ONNX and runtime
* openjdk version "1.8.0_252"
  OpenJDK Runtime Environment (build 1.8.0_252-8u252-b09-1~18.04-b09)
  OpenJDK 64-Bit Server VM (build 25.252-b09, mixed mode)
* Apache Maven 3.6
* Python 3.6 / Python 2.7 + pip 20 + Python3 virtual environments (venv, virtualenv, virtualenvwrapper, mkvirtualenv, ..., etc.)
* Gradle 6.0.1
* NPM 6.14.5
* Node v14.0.0
* Spark 2.4.5 + Hadoop 2.7 (Coming soon Spark-3.0.0 + Hadoop 3.2)
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
* The default Jupyter password is (unless you change it in `.env` file): `ChangeMe!`
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

3. Or, you can add your packages into the file below and restart "./run.sh" your Container. It will install additional packages in the file, "./requirements-extra.txt", for you.
```
# Bert pre-trained model
pytorch-pretrained-bert
```

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
2. It might be your Chrome or browsers auto feed old password as cache. To solve this problem, 
you just launch a new `incognito windows` and then type URL as usuall:
```
http://<ip>:28888/  (if you disable HTTPS, i.e., you want HTTP://...)
or
https://<ip>:28888/  (if you enable HTTPS, i.e., you want HTTPS://...)
```
# Resources & References
* [ONNX AI](https://onnx.ai/)
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
* [ONNX and Run-time environment](https://hub.docker.com/repository/docker/openkbs/onnx-ecosystem)
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

Package                Version
---------------------- ---------------
absl-py                0.9.0
appdirs                1.4.3
asn1crypto             0.24.0
astunparse             1.6.3
attrs                  19.3.0
backcall               0.1.0
beautifulsoup4         4.6.0
bleach                 3.1.5
blis                   0.4.1
boto                   2.49.0
boto3                  1.13.18
botocore               1.16.18
cachetools             4.1.0
catalogue              1.0.0
certifi                2020.4.5.1
chardet                3.0.4
click                  7.1.2
cloudpickle            1.3.0
cryptography           2.1.4
cycler                 0.10.0
cymem                  2.0.3
decorator              4.4.2
defusedxml             0.6.0
distlib                0.3.0
docutils               0.15.2
entrypoints            0.3
filelock               3.0.12
findspark              1.3.0
Flask                  1.1.2
funcy                  1.14
future                 0.18.2
gast                   0.3.3
gensim                 3.8.3
google-auth            1.15.0
google-auth-oauthlib   0.4.1
google-pasta           0.2.0
grpcio                 1.29.0
h5py                   2.10.0
html5lib               0.999999999
httpie                 2.1.0
hyperopt               0.2.4
idna                   2.9
importlib-metadata     1.6.0
importlib-resources    1.4.0
ipaddress              1.0.23
ipykernel              5.3.0
ipython                7.14.0
ipython-genutils       0.2.0
ipywidgets             7.5.1
itsdangerous           1.1.0
j2cli                  0.3.10
jedi                   0.17.0
Jinja2                 2.11.2
jmespath               0.10.0
joblib                 0.15.1
json-lines             0.5.0
jsonschema             3.2.0
jupyter                1.0.0
jupyter-client         6.1.3
jupyter-console        6.1.0
jupyter-core           4.6.3
Keras                  2.3.1
Keras-Applications     1.0.8
Keras-Preprocessing    1.1.2
keyring                10.6.0
keyrings.alt           3.0
kiwisolver             1.2.0
langdetect             1.0.8
lxml                   4.2.1
Markdown               3.2.2
MarkupSafe             1.1.1
matplotlib             3.2.1
mistune                0.8.4
more-itertools         8.2.0
murmurhash             1.0.2
nbconvert              5.6.1
nbformat               5.0.6
networkx               2.4
nltk                   3.5
notebook               6.0.3
numexpr                2.7.1
numpy                  1.18.4
oauthlib               3.1.0
olefile                0.45.1
opt-einsum             3.2.1
packaging              20.4
panda                  0.3.1
pandas                 1.0.3
pandasql               0.7.3
pandocfilters          1.4.2
parso                  0.7.0
pbr                    5.4.5
pexpect                4.8.0
pickleshare            0.7.5
Pillow                 7.1.2
pip                    20.1.1
pkgconfig              1.5.1
plac                   1.1.3
pluggy                 0.13.1
preshed                3.0.2
prometheus-client      0.8.0
prompt-toolkit         3.0.5
protobuf               3.12.2
ptyprocess             0.6.0
py                     1.8.1
py4j                   0.10.7
pyasn1                 0.4.8
pyasn1-modules         0.2.8
pycrypto               2.6.1
Pygments               2.6.1
pygobject              3.26.1
pyLDAvis               2.1.2
pyparsing              2.4.7
pyrsistent             0.16.0
pyspark                2.4.5
pytest                 5.4.1
python-apt             1.6.5+ubuntu0.2
python-dateutil        2.8.1
pytz                   2019.3
pyxdg                  0.25
PyYAML                 5.3.1
pyzmq                  19.0.1
qtconsole              4.7.3
QtPy                   1.9.0
regex                  2020.5.14
requests               2.23.0
requests-oauthlib      1.3.0
rsa                    4.0
s3transfer             0.3.3
scikit-learn           0.22.2.post1
scipy                  1.4.1
seaborn                0.10.0
SecretStorage          2.3.1
Send2Trash             1.5.0
setuptools             47.1.0
six                    1.15.0
smart-open             2.0.0
spacy                  2.2.4
SQLAlchemy             1.3.16
srsly                  1.0.2
stevedore              1.32.0
tables                 3.4.2
tensorboard            2.2.2
tensorboard-plugin-wit 1.6.0.post3
tensorflow             2.2.0
tensorflow-estimator   2.2.0
termcolor              1.1.0
terminado              0.8.3
testpath               0.4.4
thinc                  7.4.0
torch                  1.5.0
tornado                6.0.4
tqdm                   4.46.0
traitlets              4.3.3
unattended-upgrades    0.1
urllib3                1.25.9
virtualenv             20.0.21
virtualenv-clone       0.5.4
virtualenvwrapper      4.8.4
wasabi                 0.6.0
wcwidth                0.1.9
webencodings           0.5.1
Werkzeug               1.0.1
wheel                  0.34.2
widgetsnbextension     3.5.1
wrapt                  1.12.1
zipp                   3.1.0
```

# Releases Information
```
developer@e822d335ae79:~$ /usr/scripts/printVersions.sh 
+ echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
+ whereis java
java: /usr/bin/java /usr/share/java /usr/lib/jvm/java-8-openjdk-amd64/bin/java /usr/share/man/man1/java.1.gz
+ echo

+ java -version
openjdk version "1.8.0_252"
OpenJDK Runtime Environment (build 1.8.0_252-8u252-b09-1~18.04-b09)
OpenJDK 64-Bit Server VM (build 25.252-b09, mixed mode)
+ mvn --version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /usr/apache-maven-3.6.3
Java version: 1.8.0_252, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "5.3.0-53-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.17
+ python3 -V
Python 3.6.9
+ pip --version
pip 20.1.1 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ pip3 --version
pip 20.1.1 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ gradle --version

Welcome to Gradle 6.0.1!

Here are the highlights of this release:
 - Substantial improvements in dependency management, including
   - Publishing Gradle Module Metadata in addition to pom.xml
   - Advanced control of transitive versions
   - Support for optional features and dependencies
   - Rules to tweak published metadata
 - Support for Java 13
 - Faster incremental Java and Groovy compilation
 - New Zinc compiler for Scala
 - VS2019 support
 - Support for Gradle Enterprise plugin 3.0

For more details see https://docs.gradle.org/6.0.1/release-notes.html


------------------------------------------------------------
Gradle 6.0.1
------------------------------------------------------------

Build time:   2019-11-18 20:25:01 UTC
Revision:     fad121066a68c4701acd362daf4287a7c309a0f5

Kotlin:       1.3.50
Groovy:       2.5.8
Ant:          Apache Ant(TM) version 1.10.7 compiled on September 1 2019
JVM:          1.8.0_252 (Private Build 25.252-b09)
OS:           Linux 5.3.0-53-generic amd64

+ npm -v
6.14.4
+ node -v
v14.0.0
+ cat /etc/lsb-release /etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.2 LTS"
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```
