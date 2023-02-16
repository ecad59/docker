FROM renovate/renovate:34.143.0-slim

USER root

SHELL ["/bin/bash", "-c"]

RUN apt update-y
RUN apt install -y git

ENV RENOVATE_BINARY_SOURCE=global
USER 1000

ENTRYPOINT ["/bin/bash"]