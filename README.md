# Custom-training-with-GCP-AI-Platform

This repo is for demonstrating an example of custom training of `PyTorch` models on GCP AI-platform using dockerized container.

* [Setup docker with Cloud Container Registry](https://cloud.google.com/container-registry/docs/pushing-and-pulling)
  

### Scripts

* [train-local.sh](scripts/train-local) This script trains a model locally. 
  It generates a SavedModel in local folder on the Docker Image.

* [train-cloud.sh](scripts/train-cloud.sh) This script submits a training job to AI Platform.

## How to run

Once the prerequisites are satisfied, you may:

1. For local testing, run: (Note: if you don't have a GPU, the program will be run on the CPU)
    ```
    source ./scripts/train-local.sh
    ```
2. For cloud testing, run:
    ```
    source ./scripts/train-cloud.sh
    ```
### Versions
PyTorch 1.6.0