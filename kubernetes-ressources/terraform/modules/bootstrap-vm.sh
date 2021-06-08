#!/bin/bash
# Create an environment variable for the correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Update the package list and install the Cloud SDK
apt-get update && sudo apt-get install -y google-cloud-sdk kubectl nano unzip git

# Install nodejs 10.X
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt-get install -y nodejs

apt-get install -y xsel jq
npm i -g create-react-app

gcloud config set compute/zone europe-west1-b

cat <<EOF > /tmp/get-credential-cluster-$1.sh
#!/bin/bash

until gcloud container clusters list | grep RUNNING
do
    echo "Wait for cluster provisionning"
    sleep 1
done

gcloud container clusters get-credentials "training-cluster-$1" --zone europe-west1-b

#kubectl proxy --address="0.0.0.0" --accept-hosts='.*' &

EOF

chmod +x /tmp/get-credential-cluster-$1.sh





