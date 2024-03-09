# kubernetes-formation

This repository contains hands-on instructions for the **Containers and Kubernetes fundamentals** and **Kubernetes fundamentals** trainings.

Each exercise is a tutorial written for [Google Cloud Shell](https://cloud.google.com/shell/docs/), the hosted
development environment managing resources hosted on Google Cloud Platform.
 
## kubectl extra configuration

Allow completion in kubectl command (activate with `TAB`). bash-completion package should be installed first :

```sh
source <(kubectl completion bash)
```

Create a shortcut alias `k` to `kubectl` and activation completion for this alias :

```sh
alias k=kubectl
complete -o default -F __start_kubectl k
```