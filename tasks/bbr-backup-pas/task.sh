#!/usr/bin/env bash

set -eu

scripts="$(dirname "$0")/../../scripts"

# shellcheck disable=SC1090
source "$scripts/export-director-metadata"
# shellcheck disable=SC1090
source "$scripts/export-cf-metadata"

# remove bbr credhub job
bosh --environment="$BOSH_ENVIRONMENT" \
  --deployment="$DEPLOYMENT_NAME" \
  --ca-cert "$BOSH_CA_CERT_PATH" \
  ssh backup_restore -c 'sudo rm -rf /var/vcap/jobs/bbr-credhubdb/bin/bbr/'

pushd pas-backup-artifact
  # shellcheck disable=SC1090
  source "../$scripts/deployment-backup"
  tar -cvf $(date +"%Y-%b-%d")-pas-backup.tar -- *
popd
