FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

RUN apt update && \
    apt upgrade -y && \
    apt install -y libgl1 git python3 python3-pip python3.10-venv

ARG UNAME=webui
ARG UID=1000
ARG GID=1000
ENV COMMANDLINE_ARGS=--skip-torch-cuda-test
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME
WORKDIR /app
COPY . /app
RUN    ./webui-docker.sh --skip-torch-cuda-test

EXPOSE 8080
CMD ["./webui.sh"]