# docker-ccminer
This repo hosts the files for a Xenial-based ccminer Docker container. You can pull the images from a couple of places:
- [Docker Hub](https://hub.docker.com/r/bendwyer/docker-ccminer/)
- [Docker Store](https://store.docker.com/community/images/bendwyer/docker-ccminer)

## Container performance
- TESTED: `docker-ccminer:cuda-9`
  - Stock GTX 1070 FE hashrate ~33.5 MH/s
- TESTED `docker-ccminer:Nanashi-Meiyo-Meijin`
  - Stock GTX 1070 FE hashrate increased to ~35.5 MH/s over `docker-ccminer:cuda-9`

## Disclaimer
I'm not a Docker or Linux expert. Proceed at your own risk.

## Credit
- This is a fork of the CentOS-based [docker-ccminer](https://github.com/patrickceg/docker-ccminer) by [patrickceg](https://github.com/patrickceg)
- [Dockerfile.xenial.cuda-9](https://github.com/bendwyer/docker-ccminer/blob/master/Dockerfile.xenial.cuda-9) uses the [cuda-9 ccminer](https://github.com/tpruvot/ccminer/tree/cuda-9) by [tpruvot](https://github.com/tpruvot)
- [Dockerfile.xenial.Nanashi-Meiyo-Meijin](https://github.com/bendwyer/docker-ccminer/blob/master/Dockerfile.xenial.Nanashi-Meiyo-Meijin) uses the [Nanashi-Meiyo-Meijin ccminer](https://github.com/Nanashi-Meiyo-Meijin/ccminer) by [Nanashi-Meiyo-Meijin](https://github.com/Nanashi-Meiyo-Meijin)
- A couple of the Dockerfile options come from [calvintam236](https://github.com/calvintam236)'s xmrig-docker images

## Prerequisites
- `docker-ce`
  - Installation: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1
- `nvidia-docker`
  - Installation: https://github.com/NVIDIA/nvidia-docker#xenial-x86_64
  
## Usage
### cuda-9 container
Deploy container
```
docker run --runtime=nvidia --restart unless-stopped -itd --name <container name> bendwyer/docker-ccminer:cuda-9 -a <algorithm> -d <gpu device number> -o <pool url> -u <username> -p <password>
```

Available passthrough options for container
```
docker run --runtime=nvidia --rm bendwyer/docker-ccminer:cuda-9
```

### Nanashi-Meiyo-Meijin container
Deploy container
```
docker run --runtime=nvidia --restart unless-stopped -itd --name <container name> bendwyer/docker-ccminer:Nanashi-Meiyo-Meijin -a <algorithm> -d <gpu device number> -o <pool url> -u <username> -p <password>
```

Available passthrough options for container
```
docker run --runtime=nvidia --rm bendwyer/docker-ccminer:Nanashi-Meiyo-Meijin
```
