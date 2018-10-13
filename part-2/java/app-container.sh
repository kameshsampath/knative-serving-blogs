#!/bin/bash -x

# define the container base image
javacontainer=$(buildah from gcr.io/distroless/java)
# mount the container root FS
javamnt=$(buildah mount $javacontainer)

# make the java app directory
mkdir $javamnt/deployment

# copy the application jar, with Knative build templates, the app sources gets loaded in the /workspace directory
# adjust application name accordingly
cp /workspace/${CONTEXT_DIR}/target/${JAVA_APP_NAME} $javamnt/deployment/app.jar

chmod +x $javamnt/deployment/app.jar

buildah config --workingdir /deployment $javacontainer
buildah config --cmd app.jar $javacontainer

imageID=$(buildah commit $javacontainer $IMAGE_NAME)

# Push the image back to local default docker registry
# you can also push to external registry 
# Refer to https://github.com/containers/buildah/blob/master/docs/buildah-push.md
buildah push --cert-dir=/var/run/secrets/kubernetes.io \
  --creds=openshift:$(cat /var/run/secrets/kubernetes.io/serviceaccount/token) \
   $imageID \
   docker://docker-registry.default.svc.cluster.local:5000/$IMAGE_NAME
