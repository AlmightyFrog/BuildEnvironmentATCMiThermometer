FROM debian:stable-slim

ARG USER=user
ARG UID=1000
ARG GID=1000

#######################

ENV PATH $PATH:/opt/tc32/bin 

RUN groupadd -g $GID -o $USER
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $USER

RUN mkdir /app
RUN chown $UID:$GID /app

RUN apt-get update \
	&& apt-get -y install --no-install-recommends \
			python3 python3-serial make \
	&& rm -rf /var/lib/apt/lists/*

USER $USER

ADD tc32_gcc.tar.bz2 /opt/

WORKDIR /app

ENTRYPOINT ["bash"]
