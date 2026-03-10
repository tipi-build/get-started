### The NO-INSTALL get started

If you want a quick, no-install way to test cmake-re builds against an EngFlow cluster and you already have `docker` (and `jq`) installed on your local machine, this guide is the easiest way to build the `getting-started` project.

```
docker pull tipibuild/tipi-ubuntu:latest
```

```bash
# Extract the manifest digest for the specific tag we just pulled
IMAGE_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' tipibuild/tipi-ubuntu:latest) && echo "$IMAGE_DIGEST"

# Expected output format:
# tipibuild/tipi-ubuntu@sha256:fd838a788786a67257dfce7e8f9e0e4881cef6071f52b486f15f828c6c06a9ce

# Hardcode the usage of that image into the packer environment file.
# This prevents the need for Docker-in-Docker and the docker-cli inside the machine.
UPDATED_JSON=$(jq --indent 2 --arg new_img "$IMAGE_DIGEST" '.builders[0].image = $new_img' environments/linux.pkr.js/linux.pkr.js) \
  && echo "$UPDATED_JSON" > environments/linux.pkr.js/linux.pkr.js
```

```bash
# Prerequisite: Your working directory must be a git clone of https://github.com/tipi-build/get-started/
# Prerequisite: EngFlow mTLS keys should be extracted into ~/.engflow/

export RBE_service=<cluster-address:port>
export RBE_tls_client_auth_key=/path/to/engflow.key
export RBE_tls_client_auth_cert=/path/to/engflow.crt

# Disable the tipi.build cache (which would otherwise require a user account setup first)
export TIPI_CACHE_CONSUME_ONLY=ON
export TIPI_CACHE_FORCE_ENABLE=OFF

docker run -it \
  --rm \
  --init \
  -v "$PWD":"$PWD" \
  -v "$(dirname "$RBE_tls_client_auth_key")":"$(dirname "$RBE_tls_client_auth_key")" \
  -e RBE_service \
  -e RBE_tls_client_auth_cert \
  -e RBE_tls_client_auth_key \
  -e TIPI_CACHE_CONSUME_ONLY \
  -e TIPI_CACHE_FORCE_ENABLE \
  --workdir "$PWD" \
  tipibuild/tipi-ubuntu:v0.0.83 \
  /bin/bash
```

> **Command details:**
>
> `docker run -it`: Runs as an interactive session / TTY (allows you to use bash)
> 
> `--rm`: Automatically deletes the container on exit
> 
> `--init`: Starts an init process to reap child processes after termination (prevents zombie processes)
> 
> `-v "$PWD":"$PWD"`: Mounts the current working directory to the exact same path inside the container
> 
> `-v "$(dirname "$RBE_tls_client_auth_key")":...`: Mounts the parent directory of the auth keys as a volume so the container can read them
> 
> `-e RBE_*`: Passes the specific environment variables from your host into the container
> 
> `--workdir "$PWD"`: Sets the starting directory inside the container
> 
> `tipibuild/tipi-ubuntu:v0.0.83`: The container image to run
> 
> `/bin/bash`: The process to start inside the container


Then run the following commands in the container:

```bash
# Configure a --distributed build from --host (which is the container here).
# This works because the environments/linux references the same container image, so everything matches.
cmake-re --host --distributed -B ./build -S . -GNinja -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake

# finally build
cmake-re --build ./build -j 500
```

If you run this for the first time on your cluster, expect a tiny wait when you're seeing `Remote execution proxy started sucessfully` as the 
cluster will have to pull the docker image on the runners it is starting to execute your build.