FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

WORKDIR /root

RUN apt-get update

# gsutil can be downloaded as a part of gcloud as 
# RUN apt-get curl; curl -sSL https://sdk.cloud.google.com | bash

# ENV PATH $PATH:/root/google-cloud-sdk/bin

COPY . /custom-deploy/

WORKDIR /custom-deploy

RUN pip install -r requirements.txt

# The data for this sample has been publicly hosted on a GCS bucket.
ARG TRAIN_FILES=gs://cloud-samples-data/ml-engine/chicago_taxi/training/small/taxi_trips_train.csv
ARG EVAL_FILES=gs://cloud-samples-data/ml-engine/chicago_taxi/training/small/taxi_trips_eval.csv

# Download the data from the public Google Cloud Storage bucket for this sample
RUN gsutil cp $TRAIN_FILES ./taxi_trips_train.csv
RUN gsutil cp $EVAL_FILES ./taxi_trips_eval.csv

# files can be downloaded alternatively as below
# RUN chmod +x download-taxi.sh
# RUN ./download-taxi.sh

# disable buffer with -u
ENTRYPOINT ["python", "-u", "trainer/task.py"]