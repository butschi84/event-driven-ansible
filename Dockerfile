FROM ubuntu:latest

RUN apt update && apt install -y build-essential maven openjdk-17-jdk python3-dev python3-pip
ENV JDK_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV JAVA_HOME=$JDK_HOME
ENV PIP_NO_BINARY=jpy
ENV PATH=$PATH:~/.local/bin
RUN python3 -m pip install -U Jinja2
RUN python3 -m pip install aiokafka
RUN python3 -m pip install ansible ansible-rulebook ansible-runner wheel
RUN ansible-galaxy collection install community.general ansible.eda
RUN apt install vim curl -y

COPY *.yml ./
COPY webhook-rule.yml ./

EXPOSE 8080/tcp
CMD ["ansible-rulebook", "--rulebook", "webhook-rule.yml", "-i", "inventory.yml", "--verbose"]