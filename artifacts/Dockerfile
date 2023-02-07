ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest

FROM $BASE_IMAGE

RUN sed -i '/[ \t]*def artifacts_handler(self, artifact_dir):$/a\ \ \ \ \ \ \ \ self._output.write(b"surprise4")' /usr/local/lib/python3.8/site-packages/ansible_runner/streaming.py
