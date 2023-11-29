# Exercise 2.4 - Persistent volume claims

## Create a Persistent Volume Claim

* Do you see a persistent volume automatically created?
> No

* Why?
> Because the Persistent Volume Claim is waiting for a first consumer.
> When the PVC will be bind, the PV will be created.

## Bonus: force the pod to be created on another node

* Is this possible ?
> Not with the `apply` command, cause pod updates is limited to some fields, and `nodeSelector` is not one of them.
> But it's possible if you delete and create the pod again.
