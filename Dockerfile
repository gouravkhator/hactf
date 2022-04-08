FROM ubuntu:21.10

# set the language character type to UTF-8 and set the docker frontend to noninteractive,
# if docker frontend is not set,
# then some commands will prompt for user inputs, which we cannnot provide whilst docker is running these instructions
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# Using apt instead of apt-get has some issues. Refer https://github.com/hackafake/hackafake-backend/issues/32
RUN apt-get install -y sudo build-essential jq strace ltrace curl wget git \
gcc gcc-multilib python3 python3-pip make nano vim \
dnsutils net-tools gdb gdb-multiarch procps \
john nmap netcat

# pip packages for CTFs
RUN pip3 install pwntools keystone-engine unicorn capstone ropper

# change directory to /usr/tools to download the external packages to /tools
WORKDIR /usr/tools

# external packages to be downloaded from github or other external sources..
RUN git clone https://github.com/radareorg/radare2 && ./radare2/sys/install.sh

# !ISSUE: there is some issue in the below setup.sh script running
# RUN git clone https://github.com/pwndbg/pwndbg && ./pwndbg/setup.sh

# adds user named 'ctf' with home directory as '/home/ctf', password as 'ctf', login script '/bin/bash'
RUN useradd -d /home/ctf/ -m -p ctf -s /bin/bash ctf

# adds user 'ctf' to sudo group
RUN adduser ctf sudo

# change password for ctf user, to be 'ctf'.. 
# This step is important so that the sudo password of this user is also changed now..
RUN echo "ctf:ctf" | chpasswd

# set the working directory to /home/ctf
WORKDIR /home/ctf

# switch user to ctf user
USER ctf

# TODO:
# expose the port 1024 and then run the shell script as the entrypoint for VNC server ask..
# EXPOSE 1024
# COPY ./entrypoint.sh ./
# ENTRYPOINT [ "/entrypoint.sh" ]
