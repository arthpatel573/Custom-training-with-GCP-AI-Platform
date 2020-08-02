#!/bin/bash
echo "Training on GCP AI platform"

# IMAGE_REPO_NAME: the image will be stored on Cloud Container Registry
IMAGE_REPO_NAME=pytorch_gpu_taxi_container

# IMAGE_TAG: an easily identifiable tag for your docker image
IMAGE_TAG=taxi_pytorch_gpu

# IMAGE_URI: the complete URI location for Cloud Container Registry
IMAGE_URI=gcr.io/${PROJECT_ID}/${IMAGE_REPO_NAME}:${IMAGE_TAG}

# JOB_NAME: the name of your job running on AI Platform.
JOB_NAME=custom_gpu_container_job_$(date +%Y%m%d_%H%M%S)

# REGION: select a region where the model will be deployed.
REGION=us-central1

# Build the docker image
docker build -f Dockerfile -t ${IMAGE_URI} .

# Deploy the docker image to Cloud Container Registry
docker push ${IMAGE_URI}

# Submit your training job
echo "Submitting the training job"

# These variables are passed to the docker image
JOB_DIR=gs://${BUCKET_ID}/models/gpu

TRAIN_FILES=taxi_trips_train.csv
EVAL_FILES=taxi_trips_eval.csv

gcloud ai-platform jobs submit training ${JOB_NAME} \
    --region ${REGION} \
    --master-image-uri ${IMAGE_URI} \
    --scale-tier BASIC_GPU \
    -- \
    --train-files ${TRAIN_FILES} \
    --eval-files ${EVAL_FILES} \
    --num-epochs=5 \
    --batch-size=64 \
    --learning-rate=0.001 \
    --job-dir=${JOB_DIR}

# Stream the logs from the job
gcloud ai-platform jobs stream-logs ${JOB_NAME}