#!/bin/bash

echo "###############################################################################"
echo "#  MAKE SURE YOU ARE LOGGED IN:                                               #"
echo "#  $ oc login http://console.your.openshift.com                               #"
echo "###############################################################################"

// Settting up the environements
for project in serv-tst serv-e2e serv- projectd
do

    oc project $project
    // Allowing jenkins to create resources into another project
    oc policy add-role-to-user edit system:serviceaccount:project-jenkins:jenkins -n $project
    // Creating secret to pull image from a private registry
    oc create secret docker-registry quay-registry --docker-server=quay.io --docker-username=**** --docker-password=*** -n $project
    // Linknig defautl service account to the secret
    oc secrets link default quay-registry --for=pull

done

