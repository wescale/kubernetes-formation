#  Install an application from a predefined chart

The objective of this exercise is to migrate the k8s configuration from an application to Helm.
This is a simple two-tiered application: frontend and backend.

You find here:

- frontend-deployment.yaml
- backend-deployment.yaml
- frontend-service.yaml
- backend-service.yaml

The steps are:
* create a new Helm chart
* copy the given `yaml` files inside the templates directory of the chart
* modify the `yaml` files to use templating capabilities from the helpers. You can use the `helm template` command to test the rendering.
  * labels must be templated
  * resource names must be templated
* install a release of this chart


