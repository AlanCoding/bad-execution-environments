ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest

FROM $BASE_IMAGE

RUN sed -i '/[ \t]*with Base64IO(target) as encoded_target:$/a\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ encoded_target.write(b"surprise4")' /usr/local/lib/python3.8/site-packages/ansible_runner/utils/streaming.py
