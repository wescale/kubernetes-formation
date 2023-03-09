# Install Helm and try it

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

You will create your first Helm chart and get familiar with its basic commands

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Install Helm

Helm is already installed on the Cloud Shell instance.

If you had to install it, just get the binary from a package repository. See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/).

## Create a new Chart

With the command `helm create`, create a new Chart named `simpleapp`.

Browse the generated files: templates, values ... and try to understand what this chart deploysa and works.

What is the default project in the Helm chart?

## Install a release

With the `helm install` command, install the `simpleapp` chart as a release named `my-release`.

And voila you have an application up and running in the kubernetes cluster. Check it out.

---
NOTES generally we prefer to use `helm upgrade --install` command rather than `helm install`

## Checkout the revision, version saved by Helm and using Helm API.

List the installed releases:

```sh
helm ls
```

Get the generated YAML manifest:

```sh
helm get manifest my-release
```

Get the generated notes:

```sh
helm get notes my-release
```

## Clean up this installation using helm commands

Use the `helm uninstall` command to delete the `my-release` release

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
