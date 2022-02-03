#!/bin/bash
#
# Copyright 2018 The Outline Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
TASK=$1
PLATFORM=$2
BUILD_MODE=debug
for i in "$@"; do
    case $i in
    --buildMode=*)
        BUILD_MODE="${i#*=}"
        shift
        ;;
    -* | --*)
        echo "Unknown option: ${i}"
        exit 1
        ;;
    *) ;;
    esac
done

if [[ "${PLATFORM}" == "android" && "${BUILD_MODE}" == "release"  && ("${KEY_STORE_PASSWORD}" == "" || "${KEY_STORE_CONTENTS}" == "") ]]; then
    echo "Both 'KEY_STORE_PASSWORD' and 'KEY_STORE_CONTENTS' must be defined to sign an Android Release!"
    exit 1
fi


npx gulp "${TASK}" \
    --platform="${PLATFORM}" \
    --buildMode="${BUILD_MODE}" \
    --androidKeyStorePassword="${ANDROID_KEY_STORE_PASSWORD}"
