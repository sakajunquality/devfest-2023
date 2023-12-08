#!/bin/bash

if [ -z "$PROJECT_ID" ]; then
    echo "export PROJECT_ID as environment variable."
    exit 1
fi

export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')

gcloud services enable compute.googleapis.com \
    run.googleapis.com \
    artifactregistry.googleapis.com \
    cloudbuild.googleapis.com \
    clouddeploy.googleapis.com \
    monitoring.googleapis.com \
    logging.googleapis.com \
    --project=${PROJECT_ID}

gcloud beta services identity create --service=run.googleapis.com \
    --project=${PROJECT_NUMBER}

gcloud artifacts repositories create app --location=asia-northeast1 --repository-format docker --project ${PROJECT_ID}

gcloud iam service-accounts create deployer \
   --description="cloud deploy deployer" \
   --display-name="deployer" \
   --project=${PROJECT_ID}

# Fix this in production
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
   --member "serviceAccount:deployer@${PROJECT_ID}.iam.gserviceaccount.com" \
   --role="roles/storage.objectAdmin"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
   --member "serviceAccount:deployer@${PROJECT_ID}.iam.gserviceaccount.com" \
   --role="roles/run.developer"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
   --member "serviceAccount:deployer@${PROJECT_ID}.iam.gserviceaccount.com" \
   --role="roles/clouddeploy.jobRunner"

gcloud artifacts repositories add-iam-policy-binding app \
   --location=asia-northeast1 \
   --member="serviceAccount:deployer@${PROJECT_ID}.iam.gserviceaccount.com" \
   --role="roles/artifactregistry.writer" \
   --project=${PROJECT_ID}

gcloud artifacts repositories add-iam-policy-binding app \
   --location=asia-northeast1 \
   --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
   --role="roles/artifactregistry.writer" \
   --project=${PROJECT_ID}

gcloud artifacts repositories add-iam-policy-binding app \
   --location=asia-northeast1 \
   --member="serviceAccount:service-${PROJECT_NUMBER}@serverless-robot-prod.iam.gserviceaccount.com" \
   --role="roles/artifactregistry.reader" \
   --project=${PROJECT_ID}

gcloud iam service-accounts create test-app \
   --description="cloud deploy test-app" \
   --display-name="test-app" \
   --project=${PROJECT_ID}

gcloud iam service-accounts add-iam-policy-binding test-app@${PROJECT_ID}.iam.gserviceaccount.com \
    --member=serviceAccount:deployer@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser \
    --project=${PROJECT_ID}


---
gcloud iam service-accounts create automation \
   --description="cloud deploy automation" \
   --display-name="automation" \
   --project=${PROJECT_ID}


gcloud projects add-iam-policy-binding ${PROJECT_ID} \
   --member "serviceAccount:automation@${PROJECT_ID}.iam.gserviceaccount.com" \
   --role="roles/clouddeploy.releaser"


gcloud iam service-accounts add-iam-policy-binding deployer@${PROJECT_ID}.iam.gserviceaccount.com \
    --member=serviceAccount:automation@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser \
    --project=${PROJECT_ID}
