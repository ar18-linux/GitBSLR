#!/bin/bash


set -e
set -x

if [[ "$(whoami)" != "root" ]]; then
  read -p "[ERROR] must be root!"
  exit 1
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

. "${script_dir}/vars"

mkdir "${script_dir}/build"
cd "${script_dir}/build"
git clone https://github.com/Alcaro/GitBSLR.git
cd "${script_dir}/build/GitBSLR"
make

mkdir -p "${install_dir}/${module_name}"

cp "${script_dir}/build/stderred/build/libtest_stderred.so" "${install_dir}/${module_name}/GitBSLR.so"