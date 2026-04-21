# MASE Docker

Docker images for running MASE. Two variants are provided:

- `Dockerfile-cpu` — CPU-only, used for CI and general development
- `Dockerfile-gpu` — CUDA-enabled, for GPU-accelerated training and inference

## Prerequisites

- [Docker Desktop](https://docs.docker.com/get-docker/) with `buildx` support
- A [Docker Hub](https://hub.docker.com/) account
- For GPU image: an NVIDIA GPU with drivers installed on the host

## Build and Push

Replace `<your-dockerhub-username>` with your Docker Hub username before running.

**CPU image:**

```bash
DOCKER_USER=<your-dockerhub-username>
TAG=$(date -u +%Y%m%d%H%M%S) && \
docker buildx build --no-cache \
  --platform linux/amd64 \
  -f Dockerfile-cpu \
  --tag docker.io/$DOCKER_USER/mase-cpu:$TAG \
  --tag docker.io/$DOCKER_USER/mase-cpu:latest \
  --push \
  .
```

**GPU image** (see `Dockerfile-gpu` comments for CUDA version options):

```bash
DOCKER_USER=<your-dockerhub-username>
TAG=$(date -u +%Y%m%d%H%M%S) && \
docker buildx build --no-cache \
  --platform linux/amd64 \
  --build-arg CUDA_VERSION=12.1.1 \
  --build-arg TORCH_CUDA_ARCH=cu121 \
  -f Dockerfile-gpu \
  --tag docker.io/$DOCKER_USER/mase-gpu:$TAG \
  --tag docker.io/$DOCKER_USER/mase-gpu:latest \
  --push \
  .
```