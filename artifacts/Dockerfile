ARG BASE_IMAGE=quay.io/ansible/ansible-runner:latest
ARG FOLDER=/usr/local/lib/python3.8/site-packages/ansible_runner

FROM $BASE_IMAGE
ARG FOLDER

RUN sed -i '/[ \t]*with Base64IO(target) as encoded_target:$/a\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ encoded_target.write(b"surprise4")' $FOLDER/utils/streaming.py
