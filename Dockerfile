FROM jrpackages/jrnotes
ARG jr_pkg=jrDocker

RUN apt-get update && apt-get install -y \
    python-pip python-dev \
    build-essential libffi-dev \
    libssl-dev gcc libc-dev \
    make apt-transport-https \
    ca-certificates \
    curl gnupg-agent \
    software-properties-common && \
    pip install docker-compose && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
 
## Add docker
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
   apt-get update && \
   apt-get -y install docker-ce && apt-get clean && \
   rm -rf /var/lib/apt/lists/*

RUN install2.r -n -1 -d TRUE -l /rpackages/ --error $jr_pkg \
    && rm -rf /tmp/downloaded_packages/

