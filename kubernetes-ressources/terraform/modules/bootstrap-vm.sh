#!/bin/bash

# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg

# Update the package list and install the Cloud SDK
apt-get update && sudo apt-get install -y kubectl nano unzip git xsel jq google-cloud-sdk-gke-gcloud-auth-plugin

# Remove nodejs 12.X
apt-get remove -y nodejs
apt autoremove -y

# Install nodejs 14.X
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt-get install -y nodejs

npm i -g create-react-app

gcloud config set compute/zone europe-west1-b

cat <<EOF > /tmp/get-credential-cluster-$1.sh
#!/bin/bash

until gcloud container clusters list | grep RUNNING
do
    echo "Wait for cluster provisionning"
    sleep 1
done

USE_GKE_GCLOUD_AUTH_PLUGIN=True gcloud container clusters get-credentials "training-cluster-$1" --zone europe-west1-b

#kubectl proxy --address="0.0.0.0" --accept-hosts='.*' &

EOF

chmod +x /tmp/get-credential-cluster-$1.sh





