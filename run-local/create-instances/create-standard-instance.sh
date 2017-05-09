
# creates a standard instance with 1 CPU, 3.75 GB ram
# running Ubuntu
gcloud compute instances create standard-server-1 \
  --machine-type n1-standard-1 \
  --zone us-east1-d \
  --image-family ubuntu-1604-lts \
  --image-project ubuntu-os-cloud \
  --boot-disk-size 50GB \
  --boot-disk-device-name standard-disk-1 \
  --no-boot-disk-auto-delete \
  --maintenance-policy=TERMINATE  
 
# set default zone for gcloud
gcloud config set compute/zone us-east1-d