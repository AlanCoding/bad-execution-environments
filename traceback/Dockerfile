ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest
ARG FOLDER=/usr/local/lib/python3.8/site-packages/ansible_runner

FROM $BASE_IMAGE
ARG FOLDER

RUN sed -i '/[ \t]*self\._output = _output$/a\ \ \ \ \ \ \ \ raise Exception("surprise3")' $FOLDER/streaming.py
