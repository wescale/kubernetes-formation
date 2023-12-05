
# Exercise 2.2 - Taints and tolerations

## Verify the taints are ok

**Question**: Is the no-toleration-pod still running ? Why?
> No, because it is not tolerated by the taints.

## Schedule a pod to the dev environment

**Question**: On which node is it running ? Why ?
> On the node `node01` because it is the only one with the taint `node-type=dev:NoExecute`.

## Allow a pod to be scheduled on the prod environment

**Question**: Is the prod pod running ? Why ?
> No, because it is not tolerated by the taints.
> The taint `node-type=prod:NoSchedule` is not tolerated by the pod. 
> Only the taint `node-type=prod:NoExecute` is tolerated.
