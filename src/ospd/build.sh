# Install gvm-libs
APP="ospd"
git clone https://github.com/greenbone/${APP}.git \
&& cd ${APP} \
&& python3 setup.py install