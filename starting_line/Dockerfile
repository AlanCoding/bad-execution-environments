ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest

FROM $BASE_IMAGE

RUN sed -i '/[ \t]*self\._output = _output$/a\ \ \ \ \ \ \ \ self._output.write(b"surprise")' /usr/local/lib/python3.8/site-packages/ansible_runner/streaming.py
