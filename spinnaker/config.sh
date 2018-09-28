
hal config storage gcs edit \
    --project sumorelevansteamet-project001 \
    --json-path gcs_service_account_key2.json
hal config storage edit --type gcs

hal config provider google account add my-gce-account \
    --project sumorelevansteamet-project001 \
    --json-path gce_service_account_key2.json

hal config provider google enable


hal config provider kubernetes enable



hal config provider docker-registry enable

hal config provider docker-registry account add my-docker-registry \
 --address eu.gcr.io \
 --username _json_key \
 --password-file gcr_service_account_key2.json


hal config provider kubernetes account add my-k8s-account \
    --docker-registries my-docker-registry


hal config deploy edit --type distributed --account-name my-k8s-account

hal config storage gcs edit --project sumorelevansteamet-project001\
    --bucket-location eu \
    --json-path gcs_service_account_key2.json

hal config storage edit --type gcs

# hal version list

hal config version edit --version 1.9.4


# Deploy the shit out of it
hal deploy apply