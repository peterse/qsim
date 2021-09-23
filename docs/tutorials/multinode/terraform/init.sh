# ---- Edit below -----#

export TF_VAR_project=peters-5
export TF_VAR_project_id=peters-5
export TF_VAR_zone=us-central1-b
export TF_VAR_region=us-central1
export TF_VAR_multizone=true
export TF_VAR_numzones=4  # for regional/multizone, set to the number of regions in the zone

export TF_VAR_family=???  # for using qsim/gpu images on Fermi project
# ---- Do not edit below -----#

export TF_VAR_project_id=${TF_VAR_project_id}
export TF_VAR_service_account="htcondor@"${TF_VAR_project}".iam.gserviceaccount.com"

gcloud config set project $TF_VAR_project
gcloud services enable compute.googleapis.com
gcloud services enable monitoring.googleapis.com
gcloud config set compute/zone $TF_VAR_zone
gcloud config set compute/region $TF_VAR_region

gcloud config list

gcloud iam service-accounts create htcondor --display-name="Run HTCondor"

# Add roles
gcloud projects add-iam-policy-binding ${TF_VAR_project} --member serviceAccount:${TF_VAR_service_account} --role roles/compute.admin
gcloud projects add-iam-policy-binding ${TF_VAR_project} --member serviceAccount:${TF_VAR_service_account} --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding ${TF_VAR_project} --member serviceAccount:${TF_VAR_service_account} --role roles/monitoring.admin
gcloud projects add-iam-policy-binding ${TF_VAR_project} --member serviceAccount:${TF_VAR_service_account} --role roles/logging.admin
gcloud projects add-iam-policy-binding ${TF_VAR_project} --member serviceAccount:${TF_VAR_service_account} --role roles/autoscaling.metricsWriter
