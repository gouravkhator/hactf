# HACTF -- My Custom CTF Docker Image

A docker image built on top of **ubuntu:19.10**, embracing the ***motivations of CTF players***, and setting up a *playground* for them to leverage and play the CTF, without worrying for *nasty* setups.

## Notes for CTF players

Run the commands given below, to have the ubuntu 19.10 docker image with important tools needed for your upcoming CTF challenges.

Note that you can write the scripts and payloads inside `<directory_containing_docker_compose_file>/ctf_files` and the same files will be mounted inside docker container in the folder `/home/ctf/ctf_files`.

**Normal user and sudo password for user `ctf`: `ctf`.**

### Commands to run on your host machine

```sh
git clone https://github.com/gouravkhator/hactf
cd hactf/
mkdir ctf_files/

# write some ctf scripts/payloads in this folder in some files
echo "print('hello world')" >> hello.py

docker-compose up -d --build # building and running the image
docker exec -it ctf /bin/bash # login to the container
docker-compose down # stopping and removing the container
```

## Prerequisites

Install docker and docker-compose on your host machine.

## Commands in Details

- Build and run the docker image in detached mode

  ```sh
  docker-compose up -d --build
  ```

- Run the already built docker image in detached mode

  ```sh
  docker-compose up -d
  ```

- Login to the docker container

  ```sh
  docker exec -it ctf /bin/bash
  ```

  > Note: `ctf` is the docker container name, as given in the `docker-compose.yml` file.

- Check the running docker containers for this image:

  ```sh
  docker-compose ps
  ```

- Check all the docker containers for this image:

  ```sh
  docker-compose ps -a
  ```

- Stop a particular container:

  ```sh
  docker stop <container-name>
  ```

- Stop and remove the running container ran using `docker-compose up -d`:

  ```sh
  docker-compose down
  ```

- Check all the built docker images for your host system

  ```sh
  docker images
  ```

- Remove a particular image

  ```sh
  docker image rm <image-id>
  ```

- If you have the image built in some different docker-compose context/folder:

  - Then, if you run `docker-compose up -d`, this will again build the image in the current folder, as this is a different context.
  - If you want to use the same old built image:

    ```sh
    # giving container name as `ctf`
    docker create --name ctf -it <image-name>
    docker start ctf
    docker exec -it ctf /bin/bash
    ```
  
  But, now the `ctf_files` folder will not be mounted, as `docker-compose` mounts the volume and not the image itself, and we didn't run docker-compose now.

## Checklist

- [x] Install important tools on ubuntu:19.10 docker image. We can install more tools when required, add the commands in Dockerfile in future.
- [x] Use docker-compose for simplifying the process.
- [x] Use volumes to mount the ctf files/scripts/payloads from host machine inside docker.
- [ ] Entrypoint script
  - [ ] Configure VNC like configuration to give CTF players a choice, if they need to use the GUI image via VNC.
  - [ ] Based on CTF players' choice, install large-sized CTF frameworks like metasploit framework and expose its ports to the host macine.
- [ ] Expose the network ports, so that we can capture the packets of the docker container, on Wireshark, which is installed on our host machine.

## Credits

This repo was a motivation from one of the repos of LiveOverflow channel: [pwn_docker_example](https://github.com/LiveOverflow/pwn_docker_example).
