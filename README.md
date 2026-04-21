# MASE Docker

Docker images for running MASE. Two variants are provided:

- `Dockerfile-cpu` — CPU-only, used for CI and general development
- `Dockerfile-gpu` — CUDA-enabled, for GPU-accelerated training and inference

## Official Images (DeepWok)

The official MASE Docker images are automatically built and pushed to Docker Hub
by GitHub Actions whenever changes are merged into `main`:

| Image | Docker Hub |
|-------|-----------|
| CPU | `deepwok/mase-docker-cpu:latest` |
| GPU | `deepwok/mase-docker-gpu:latest` |

To use the official images:

```bash
# CPU
docker pull deepwok/mase-docker-cpu:latest

# GPU
docker pull deepwok/mase-docker-gpu:latest
```

---

## Build Your Own Image

If you need to customise the image (e.g. different CUDA version, private fork),
you can build and push it yourself.

**Prerequisites:**
- [Docker Desktop](https://docs.docker.com/get-docker/) with `buildx` support
- A [Docker Hub](https://hub.docker.com/) account
- For GPU image: check your host driver version with `nvidia-smi`

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

**GPU image** (see `Dockerfile-gpu` for available CUDA version options):

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