#!/bin/bash

# IMAGE_REPO_NAME: set a local repo name to distinquish our image
IMAGE_REPO_NAME=pytorch_gpu_taxi_container

# IMAGE_TAG: an easily identifiable tag for your docker image
IMAGE_TAG=taxi_pytorch_gpu

# IMAGE_URI: the complete URI location for the image
IMAGE_URI=${IMAGE_REPO_NAME}:${IMAGE_TAG}

# Build the docker image if not built
docker build -f Dockerfile -t ${IMAGE_URI} ./

# These variables are passed to the docker image
# Note: these files have already been copied over when the image was built
TRAIN_FILES=taxi_trips_train.csv
EVAL_FILES=taxi_trips_eval.csv

# Test your docker image locally
echo "Running the Docker Image"
docker run ${IMAGE_URI} \
        --train-files ${TRAIN_FILES} \
        --eval-files ${EVAL_FILES} \
        --num-epochs=10 \
        --batch-size=100 \
        --learning-rate=0.001
