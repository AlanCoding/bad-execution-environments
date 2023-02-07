ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest

FROM $BASE_IMAGE

RUN sed -i '/[ \t]*def finished_callback(self, runner_obj):$/a\ \ \ \ \ \ \ \ self._output.write(b"surprise2")' /usr/local/lib/python3.8/site-packages/ansible_runner/streaming.py
