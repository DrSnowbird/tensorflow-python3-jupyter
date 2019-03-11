# Tensorflow + Python3 + Jupyter + Spark + PySpark

# Note this fork GIT modify the parent GIT with the followings
* Launch the **Tensorboard Web GUI server** (at port 26006 as default)
* Launch the **Tensorflow-Python3-Jupyter server** (at port 28008 as default)
* Added Python3 Tensorflow examples from the forked GIT, "git@github.com:DrSnowbird/TensorFlow-Examples.git (forked from its parent aymericdamien/TensorFlow-Examples" (I corrected some of the syntax for print to be Python3 - but not completed done for all notebook yet)

# Spark Notebook alternative
We also provide Spark Zeppelin notebook local cluster [openkbs/docker-spark-bde2020-zeppelin](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/docker-spark-bde2020-zeppelin). If you want Scala/Java Spark ML/Mlib etc, you might try that as well. In all, we support both Zeppelin Notebooks and Jupyter Notebooks technologies for both Scala/Java and Python data science users' needs.

# Components:
* java version "1.8.0_202"
  Java(TM) SE Runtime Environment (build 1.8.0_202-b08)
  Java HotSpot(TM) 64-Bit Server VM (build 25.202-b08, mixed mode)
* Apache Maven 3.6.0
* Python 3.5.2 / Python 2.7.12 + pip 19.0.2
* Node v11.9.0 + npm 6.5.0 (from NodeSource official Node Distribution)
* Gradle 5.1
* Spark 2.4.0 + Hadoop 2.7
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

# PIP Components installed as default:
This container choose defaults components including NLP
```
Flask
future
findspark
gensim
httpie
hyperopt
ipaddress
ipykernel
j2cli
jinja2
jupyter
keras
langdetect
matplotlib
networkx
nltk
numpy
panda
pandas
pandasql
Pillow
pkgconfig
pyLDAvis
pyparsing
requests
scikit_learn
scipy
seaborn
tqdm
virtualenv
virtualenvwrapper
```
# Run
Two ways to run:
```
./run.sh
```
or
```
docker-compose up -d
```

The login default (unless you change it in `docker-run.env` file): `ChangeMe!`

# References
* [Jupyter Notebook](https://jupyter.org/)
* [TensorFlow](https://www.tensorflow.org/)
* [scikit-learn](http://scikit-learn.org/stable/)
* [pandas](http://pandas.pydata.org/)
* [matplotlib](https://matplotlib.org/)
* [numpy](http://www.numpy.org/)
* [scipy](https://www.scipy.org/)
* [Pillow](https://pillow.readthedocs.io/en/4.1.x/)
* [Python 2 and 3](https://www.python.org/)

Note: the jupyter notebooks are only based on Python 3 kernels as default.

# See Also - docker-based IDE
* [openkbs/atom-docker](https://hub.docker.com/r/openkbs/atom-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
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




