
#!/bin/bash

### Variables
IMAGE_NAME="my-react-app"        
TAG="latest"               
DOCKERFILE="Dockerfile"       
BUILD_CONTEXT="."            



# Build the Docker image
echo "Building Docker image: $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG -f $DOCKERFILE $BUILD_CONTEXT

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker image $IMAGE_NAME:$TAG built successfully."
else
  echo "Failed to build Docker image $IMAGE_NAME:$TAG."
  exit 1
fi

echo "Build complete."
echo "bye"
