# how to get started

```bash
export PROJECT_ID=foo
./bootstrap.sh
```

```bash
find . -type f -exec sed -i '' 's/'"FIX_ME_PROJECT_ID"'/'"$PROJECT_ID"'/g' {} +
```


# Instructions

## bulld images

```bash
gcloud builds submit --tag asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 --project FIX_ME_PROJECT_ID .
```

## test 1

```bash
gcloud deploy apply --file=manifests/1/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-1" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 \
    --skaffold-file=manifests/1/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud run services add-iam-policy-binding test-app-prd \
--project="${PROJECT_ID}" \
--region=asia-northeast1 \
--member="allUsers" \
--role="roles/run.invoker"
```

## test 2

```bash
gcloud deploy apply --file=manifests/2/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-2" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 \
    --skaffold-file=manifests/2/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud run services add-iam-policy-binding test-app-stg \
--project="${PROJECT_ID}" \
--region=asia-northeast1 \
--member="allUsers" \
--role="roles/run.invoker"
```

## test 3

```bash
gcloud deploy apply --file=manifests/3/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-3" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 \
    --skaffold-file=manifests/3/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"
```

## test 3-b

```bash
gcloud deploy apply --file=manifests/3-b/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-3-b" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 \
    --skaffold-file=manifests/3-b/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"
```

## test 4

```bash
gcloud deploy apply --file=manifests/4/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}
gcloud deploy releases create "release-4" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 \
    --skaffold-file=manifests/4/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"
```

## test 5

```bash
gcloud deploy apply --file=manifests/5/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}
gcloud deploy releases create "release-5" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/$PROJECT_ID/app/test-app:v1 \
    --skaffold-file=manifests/5/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"
```
