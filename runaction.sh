#!/bin/bash

declare statuscode
statuscode=0

echo "::info:: Running version"
hass --version

if [ -d "${INPUT_CONFIG_PATH}/custom_components/" ]; then
  echo "::info:: Install requirements for custom integrations"
  shopt -s globstar nullglob
  for manifest in "$INPUT_CONFIG_PATH"/custom_components/**/manifest.json; do
    echo "::info:: Checking manifest file $manifest"

      for requirement in $(jq -r '.[]' <<< "$(jq '.requirements' "$manifest")"); do
        echo "::info:: Installing requirement '$requirement'"
        python3 -m pip install --disable-pip-version-check "$requirement" || statuscode=1
      done
    done
fi

echo "::info:: Running config check"
hass --script check_config --config "${GITHUB_WORKSPACE}"/"${INPUT_CONFIG_PATH}" || statuscode=1

echo "::info:: Config check is complete"
exit "$statuscode"