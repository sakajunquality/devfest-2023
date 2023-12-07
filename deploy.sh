---
gcloud builds submit --tag asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v1 --project sakajun-devfest23 .

gcloud deploy apply --file=manifests/1/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}


gcloud deploy releases create "release-3" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v1 \
    --skaffold-file=manifests/1/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"

---


gcloud deploy apply --file=manifests/2/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-4" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v1 \
    --skaffold-file=manifests/2/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"


gcloud run services add-iam-policy-binding test-app-prd \
--project="${PROJECT_ID}" \
--region=asia-northeast1 \
--member="allUsers" \
--role="roles/run.invoker"

gcloud run services add-iam-policy-binding test-app-stg \
--project="${PROJECT_ID}" \
--region=asia-northeast1 \
--member="allUsers" \
--role="roles/run.invoker"


---
gcloud deploy apply --file=manifests/3/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-7" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v1 \
    --skaffold-file=manifests/3/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"

---

gcloud deploy apply --file=manifests/3-b/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}

gcloud deploy releases create "release-8" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v1 \
    --skaffold-file=manifests/3-b/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"

---

gcloud builds submit --tag asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v7 --project sakajun-devfest23 .

gcloud deploy apply --file=manifests/4/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}
gcloud deploy releases create "release-21" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v6 \
    --skaffold-file=manifests/4/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"


---

gcloud deploy apply --file=manifests/5/clouddeploy.yaml --region=asia-northeast1 --project=${PROJECT_ID}
gcloud deploy releases create "release-23" \
    --project="${PROJECT_ID}" \
    --region=asia-northeast1 \
    --delivery-pipeline=test-app \
    --images=app=asia-northeast1-docker.pkg.dev/sakajun-devfest23/app/test-app:v6 \
    --skaffold-file=manifests/5/skaffold.yaml \
    --deploy-parameters="run_sa=test-app@${PROJECT_ID}.iam.gserviceaccount.com"

