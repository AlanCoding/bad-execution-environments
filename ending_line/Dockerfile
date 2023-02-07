ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest
ARG FOLDER=/usr/local/lib/python3.8/site-packages/ansible_runner

FROM $BASE_IMAGE
ARG FOLDER

RUN sed -i '/[ \t]*def finished_callback(self, runner_obj):$/a\ \ \ \ \ \ \ \ self._output.write(b"surprise2")' $FOLDER/streaming.py
