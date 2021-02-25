###### tags: `pipeline` `CICD`

# cicd-pipeline

### Setting up Jenkins

1. Create a new project where jenkins will be deployed.

    ``` bash
    oc new-project serv-jenkins
    ```

2. Create a persistent Jenkins instance with:

    * A persistent volume claim wit at elast 4GB.
    * CPU request 500m and CPU limit of 2 cores.
    * Memory request of 1Gi and memory limit of 2Gi.

    ``` bash
    oc new-app jenkins-persistent --param ENABLE_OAUTH=true --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true --as-deployment-config=true
    ```

    ```
    oc set resources dc jenkins --limits=memory=2Gi,cpu=2 --requests=memory=1Gi,cpu=500m
    ```

    ### Register a Jenkins agent pod

    3. Create a file with the pod agent definition.
    
    4. Create ConfigMap with the agent definition file podTemplate.xml.
    ``` bash
    oc create configmap serv-agent --from-file=./jenkins/podTemplate.xml -n serv-jenkins
    ```

    5.Label the ConfigMap so that Jenkins know it's the definition for the agent.
    ```
    oc label configmap serv-agent role=jenkins-slave
    ```
### Setting up Jenkins

    6. Use the provided script ./openshift/settingEnv.sh to setup the environments. Don't forget to provide the environments and the credentials to pull the images. 
       * Jenkins need to be able to create resources in the different environments
       * The environment must be able to pull images from private registries.

