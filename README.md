# Tensorflow + Python3 + Jupyter + PySpark + Spark 3.0 + Hadoop 3.2

# (New) Added R Kernel support.

# NOTE: The latest update supported `HTTPS` for Jupyter Notebook to increase security:
* Launch the **Tensorflow-Python3-Jupyter server** (`http://<ip>:28888/` - **default** or `https://<ip>:28888/`) -- To change HTTPS or HTTP, see next paragraph 
  * Remember to ***".env"*** setup for using HTTPS since the default is HTTP (again!)
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
* Jupyter
  * ONNX and runtime
  * Tensorflow and examples
* [Java openkbs/jdk-mvn-py3 - see README.md](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md)
* [Base Container Image: openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3)
* [Base Container Image: openkbs/jdk-mvn-py3-x11](https://github.com/DrSnowbird/jdk-mvn-py3-x11)
* [Base Components: OpenJDK, Python 3, PIP, Node/NPM, Gradle, Maven, etc.](https://github.com/DrSnowbird/jdk-mvn-py3#components) 

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
* [R Studio in Jupyter](https://dzone.com/articles/using-r-on-jupyternbspnotebook)
* [IRKernel for Jupyter](https://irkernel.github.io/installation/)

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
You can use either
```
import sys
!{sys.executable} -m pip list
```
or
```
developer@cace1316ae93:~$ pip freeze
absl-py==0.10.0
appdirs==1.4.4
argon2-cffi==20.1.0
asn1crypto==0.24.0
astunparse==1.6.3
async-generator==1.10
attrs==20.2.0
backcall==0.2.0
beautifulsoup4==4.6.0
bleach==3.2.1
blis==0.4.1
cachetools==4.1.1
catalogue==1.0.0
certifi==2020.6.20
cffi==1.14.3
chardet==3.0.4
click==7.1.2
cloudpickle==1.6.0
cryptography==2.1.4
cycler==0.10.0
cymem==2.0.3
decorator==4.4.2
defusedxml==0.6.0
distlib==0.3.1
entrypoints==0.3
filelock==3.0.12
findspark==1.4.2
fire==0.3.1
Flask==1.1.2
funcy==1.15
future==0.18.2
gast==0.3.3
gensim==3.8.3
google-auth==1.22.1
google-auth-oauthlib==0.4.1
google-pasta==0.2.0
grpcio==1.32.0
h5py==2.10.0
html5lib==0.999999999
httpie==2.2.0
hyperopt==0.2.5
idna==2.10
importlib-metadata==2.0.0
importlib-resources==3.0.0
iniconfig==1.1.1
ipaddress==1.0.23
ipykernel==5.3.4
ipython==7.16.1
ipython-genutils==0.2.0
ipywidgets==7.5.1
itsdangerous==1.1.0
j2cli==0.3.10
jedi==0.17.2
Jinja2==2.11.2
joblib==0.17.0
json-lines==0.5.0
jsonschema==3.2.0
jupyter==1.0.0
jupyter-client==6.1.7
jupyter-console==6.2.0
jupyter-core==4.6.3
jupyterlab-pygments==0.1.2
Keras==2.4.3
Keras-Preprocessing==1.1.2
keras2onnx==1.7.0
keyring==10.6.0
keyrings.alt==3.0
kiwisolver==1.2.0
langdetect==1.0.8
lxml==4.2.1
Markdown==3.3.2
MarkupSafe==1.1.1
matplotlib==3.3.2
mistune==0.8.4
murmurhash==1.0.2
nbclient==0.5.1
nbconvert==6.0.7
nbformat==5.0.8
nest-asyncio==1.4.1
networkx==2.5
nltk==3.5
notebook==6.1.4
numexpr==2.7.1
numpy==1.19.2
oauthlib==3.1.0
olefile==0.45.1
onnx==1.7.0
onnxconverter-common==1.7.0
onnxmltools==1.7.0
onnxruntime==1.5.2
opt-einsum==3.3.0
packaging==20.4
panda==0.3.1
pandas==1.1.3
pandasql==0.7.3
pandocfilters==1.4.2
parso==0.7.1
pbr==5.5.0
pexpect==4.8.0
pickleshare==0.7.5
Pillow==8.0.0
pkgconfig==1.5.1
plac==1.1.3
pluggy==0.13.1
preshed==3.0.2
prometheus-client==0.8.0
prompt-toolkit==3.0.8
protobuf==3.13.0
ptyprocess==0.6.0
py==1.9.0
py4j==0.10.9
pyasn1==0.4.8
pyasn1-modules==0.2.8
pycparser==2.20
pycrypto==2.6.1
Pygments==2.7.1
pygobject==3.26.1
pyLDAvis==2.1.2
pyparsing==2.4.7
pyrsistent==0.17.3
pyspark==3.0.1
pytest==6.1.1
python-apt==1.6.5+ubuntu0.3
python-dateutil==2.8.1
python-git==2018.2.1
pytz==2020.1
pyxdg==0.25
PyYAML==5.3.1
pyzmq==19.0.2
qtconsole==4.7.7
QtPy==1.9.0
regex==2020.10.15
requests==2.24.0
requests-oauthlib==1.3.0
rsa==4.6
scikit-learn==0.23.2
scipy==1.5.3
seaborn==0.11.0
SecretStorage==2.3.1
Send2Trash==1.5.0
six==1.15.0
skl2onnx==1.7.0
smart-open==3.0.0
spacy==2.3.2
SQLAlchemy==1.3.20
srsly==1.0.2
stevedore==3.2.2
tables==3.4.2
tensorboard==2.3.0
tensorboard-plugin-wit==1.7.0
tensorflow==2.3.1
tensorflow-estimator==2.3.0
termcolor==1.1.0
terminado==0.9.1
testpath==0.4.4
tf2onnx==1.7.1
thinc==7.4.1
threadpoolctl==2.1.0
toml==0.10.1
torch==1.6.0
tornado==6.0.4
tqdm==4.50.2
traitlets==4.3.3
typing-extensions==3.7.4.3
unattended-upgrades==0.1
urllib3==1.25.11
virtualenv==20.0.35
virtualenv-clone==0.5.4
virtualenvwrapper==4.8.4
wasabi==0.8.0
wcwidth==0.2.5
webencodings==0.5.1
Werkzeug==1.0.1
widgetsnbextension==3.5.1
wrapt==1.12.1
yml2json==1.1.3
zipp==3.3.1
```

# Releases information
See [Release information](https://github.com/DrSnowbird/jdk-mvn-py3#releases-information)
