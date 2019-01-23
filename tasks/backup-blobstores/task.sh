#!/bin/bash

set -eu

GCP_CREDFILE="./gcpcreds.json"

cat > ${GCP_CREDFILE} <<EOF
${GCP_CREDFILE_CONTENTS}
EOF

# Activate service account
gcloud auth activate-service-account --key-file ${GCP_CREDFILE}

# copy director bucket
gsutil -m cp -r gs://${GCP_STORAGE_BUCKET_DIRECTOR} gs://${GCP_STORAGE_BUCKET_BACKUP}/$(date +"%Y-%b-%d")/${GCP_STORAGE_BUCKET_DIRECTOR} &

# copy buildpacks bucket
gsutil -m cp -r gs://${GCP_STORAGE_BUCKET_BUILDPACKS} gs://${GCP_STORAGE_BUCKET_BACKUP}/$(date +"%Y-%b-%d")/${GCP_STORAGE_BUCKET_BUILDPACKS} &

# copy droplets bucket
gsutil -m cp -r gs://${GCP_STORAGE_BUCKET_DROPLETS} gs://${GCP_STORAGE_BUCKET_BACKUP}/$(date +"%Y-%b-%d")/${GCP_STORAGE_BUCKET_DROPLETS} &

# copy packages bucket
gsutil -m cp -r gs://${GCP_STORAGE_BUCKET_PACKAGES} gs://${GCP_STORAGE_BUCKET_BACKUP}/$(date +"%Y-%b-%d")/${GCP_STORAGE_BUCKET_PACKAGES} &

# copy resources bucket
gsutil -m cp -r gs://${GCP_STORAGE_BUCKET_RESOURCES} gs://${GCP_STORAGE_BUCKET_BACKUP}/$(date +"%Y-%b-%d")/${GCP_STORAGE_BUCKET_RESOURCES} &
