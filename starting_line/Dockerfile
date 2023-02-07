ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest
ARG FOLDER=/usr/local/lib/python3.8/site-packages/ansible_runner

FROM $BASE_IMAGE
ARG FOLDER

RUN sed -i '/[ \t]*self\._output = _output$/a\ \ \ \ \ \ \ \ self._output.write(b"surprise1")' $FOLDER/streaming.py
