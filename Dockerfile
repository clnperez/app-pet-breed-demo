# Make sure to run this with `nvidia-docker run`

FROM caffe:0.14

RUN apt-get update && apt-get -y install unzip wget zlib1g-dev libjpeg-dev python-pip cython && apt-get clean
WORKDIR /opt
RUN wget --no-verbose https://github.com/Junsong-Wang/pet-breed/archive/master.zip && unzip master.zip && rm -f master.zip
RUN cd pet-breed-master && pip install -r requirements.txt
RUN sed -ie 's/\/root\/pet-breed/\/opt\/pet-breed-master/g' /opt/pet-breed-master/web_demo/app.py
ADD launch.sh /usr/bin/launch.sh
ADD url.txt /etc/NAE/url.txt
RUN chmod 0755 /usr/bin/launch.sh
EXPOSE 5000
