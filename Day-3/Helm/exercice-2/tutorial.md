# Chart an existing application

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

The objective of this exercise is to migrate the k8s configuration from an application to Helm.
This is a simple two-tiered application: frontend and backend.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Directives

You find here:

- <walkthrough-editor-open-file filePath="frontend-deployment.yaml">frontend-deployment.yaml</walkthrough-editor-open-file>
- <walkthrough-editor-open-file filePath="backend-deployment.yaml">backend-deployment.yaml</walkthrough-editor-open-file>
- <walkthrough-editor-open-file filePath="backend-service.yaml">backend-service.yaml</walkthrough-editor-open-file>
- <walkthrough-editor-open-file filePath="frontend-service.yaml">frontend-service.yaml</walkthrough-editor-open-file>

The steps are:

- Create a new Helm chart
- Copy the given `yaml` files inside the templates directory of the chart
- Modify the `yaml` files to use templating capabilities from the helpers. You can use the `helm template` command to test the rendering.
  - labels must be templated
  - resource names must be templated
- Install a release of this chart
