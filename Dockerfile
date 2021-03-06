FROM ubuntu:18.04

# Ray wants these lines
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update && apt install software-properties-common -y
# python3.8-dev includes headers that are needed to install pickle5 later
RUN apt-get install python3.8-dev gcc -y
# install python 3.8 virtual environment
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update && apt install python3.8-venv git -y
ENV VIRTUAL_ENV=/opt/venv
RUN python3.8 -m venv $VIRTUAL_ENV
ENV PATH=$VIRTUAL_ENV/bin:$PATH
RUN python -m pip install --upgrade pip setuptools

# install java, requirement to install hydra from source
RUN apt install default-jre -y

RUN mkdir src
COPY hydra-ray-demo/ src/hydra-ray-demo/
RUN python -m pip install -r src/hydra-ray-demo/requirements.txt
WORKDIR src/hydra-ray-demo
