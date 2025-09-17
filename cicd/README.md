# GitLab CI/CD Pipeline - Cloud Run Deployment

## Overview
Pipeline ini membangun aplikasi container sederhana, push image ke **Google Artifact Registry**, lalu otomatis deploy ke **Cloud Run** ketika ada commit ke branch `main`.

## Prerequisites
1. **GCP Project** sudah dibuat.
2. **Artifact Registry** repository sudah ada:
   ```bash
   gcloud artifacts repositories create hello-world --repository-format=docker --location=asia-southeast2 --description="Hello World Docker repo"

## Cloud Run API sudah di-enable:
```
gcloud services enable run.googleapis.com artifactregistry.googleapis.com
```

## Service Account dengan role:

- Artifact Registry Writer
- Cloud Run Admin
- Service Account User
- Tambahkan key JSON ke GitLab CI/CD variables: GCP_SA_KEY (isi base64 dari file JSON service account) dan PROJECT_ID, REGION, dll bisa juga diset via CI/CD Variables

## GitLab Runner harus punya akses Docker (pakai executor docker).

## Pipeline Stages

### Build
#### Build container image dari source code aplikasi.

### Push
#### Push image ke Artifact Registry:
```
$REGION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE:$CI_COMMIT_SHORT_SHA
```

### Deploy
#### Deploy image terbaru ke Cloud Run service $SERVICE. Hanya jalan di branch main.

## Run Manual Deploy (optional)
```
gcloud run deploy hello-service \
  --image asia-southeast2-docker.pkg.dev/<PROJECT_ID>/hello-world/hello-app:latest \
  --platform managed \
  --allow-unauthenticated
```