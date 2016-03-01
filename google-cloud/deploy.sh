#!/bin/sh
# gcloud container clusters get-credentials ${name_of_cluster} --zone=${name_of_zone}
yo(){ echo "`date` $@";}
yn(){ echo -n "`date` $@";}

[ "x$1" = "xclean" ] && {
  yo "Deleting sshscp:"
  kubectl delete rc sshscp
  kubectl delete service sshscp
  yn "Waiting for pods to terminate..."
  while [ "`kubectl get pods|egrep ^sshscp`" ]; do sleep 1; echo -n '.'; done
  echo "...done!"
}

yo "Creating pod and service:"

kubectl run sshscp --image=jhazelwo/sshscp --port=22022 || exit $?
kubectl expose rc sshscp --port=22022 --type=LoadBalancer || exit $?

yn "Waiting for EXTERNAL_IP, this takes a while..."
while ! [ "`kubectl get service sshscp|tail -1|awk '{print $6}'`" ]; do sleep 1; echo -n '.'; done
echo "...done!"

kubectl get service sshscp

