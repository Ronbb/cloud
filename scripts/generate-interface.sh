#!/usr/bin/env bash

SCRIPTS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPTS_DIR/.."

cd $PROJECT_ROOT

MODELS_ROOT="$PROJECT_ROOT/models"
MODELS_GLOB="$MODELS_ROOT/*.proto"
GO_MODELS_DIR="$PROJECT_ROOT/servers"
DART_MODELS_DIR="$PROJECT_ROOT/apps/models/lib"

# rm -r $GO_MODELS_DIR
# rm -r $DART_MODELS_DIR

# mkdir $GO_MODELS_DIR
# mkdir $DART_MODELS_DIR

protoc -I=$PROJECT_ROOT \
    --go_out=paths=source_relative:$GO_MODELS_DIR \
    --go-grpc_out=paths=source_relative:$GO_MODELS_DIR \
    --go-route_out=paths=source_relative:$GO_MODELS_DIR \
    --dart_out=$DART_MODELS_DIR\
    $MODELS_GLOB
