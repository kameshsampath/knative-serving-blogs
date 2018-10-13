#!/bin/bash -x

# define the container base image
javacontainer=$(buildah from gcr.io/distroless/java)
# mount the container root FS
javamnt=$(buildah mount $javacontainer)

# make the java app directory
mkdir $javamnt/deployment

# copy the application jar, with Knative build templates, the app sources gets loaded in the /workspace directory
# adjust application name accordingly
cp /workspace/${CONTEXT_DIR}/target/greeter.jar $javamnt/deployment/app.jar

chmod +x $javamnt/deployment/app.jar

buildah config --workingdir /deployment $javacontainer
buildah config --cmd app.jar $javacontainer

buildah commit $IMAGE_NAME

# build push $IMAGE_NAME
