# docker-ccminer

## Disclaimer
Using my beginner level Linux and Docker knowledge I cobbled the Dockerfile together in a single evening. It seems to be running well without any issues, but please proceed at your own risk.

- TESTED: CUDA-9 ccminer
- UNTESTED: Nanashi-Meiyo-Meijin ccminer

## Credit
- Fork of [docker-ccminer](https://github.com/patrickceg/docker-ccminer) by [patrickceg](https://github.com/patrickceg)
- This repo's CUDA9 branch uses the [CUDA-9 ccminer](https://github.com/tpruvot/ccminer/tree/cuda-9) by [tpruvot](https://github.com/tpruvot)
- This repo's Nanashi-Meiyo-Meijin branch uses the [Nanashi-Meiyo-Meijin ccminer](https://github.com/Nanashi-Meiyo-Meijin/ccminer) by [Nanashi-Meiyo-Meijin](https://github.com/Nanashi-Meiyo-Meijin)
- A couple of the Dockerfile options come from [calvintam236](https://github.com/calvintam236)'s xmrig-docker images

## Info
[docker-ccminer](https://github.com/patrickceg/docker-ccminer) uses CentOS, but I wanted an Ubuntu NVIDIA image. I've edited the Dockerfile to include these options and removed the steps specific to CentOS.

## Prerequisites
- `docker-ce`
  - Installation: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1
- `nvidia-docker`
  - Installation: https://github.com/NVIDIA/nvidia-docker#xenial-x86_64
  
 ## Usage
Deploying a container
```
docker run --runtime=nvidia --restart unless-stopped -itd --name <container name> bendwyer/ccminer:nvidia -a <algorithm> -d <gpu device number> -o <pool url> -u <username> -p <password>
```

Available passthrough options for container
```
docker run --runtime=nvidia --rm bendwyer/ccminer:nvidia
```
