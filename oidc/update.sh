#!/usr/bin/env bash
set -e

function get_os_name() {
  if [ "$(uname -s)" == "Darwin" ]; then
    os_name="mac"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    os_name="linux"
  elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    os_name="windows"
  fi
}

get_os_name
cpu_arch=$(uname -m)

function get_os_bin_name() {
  ctl_filename="$1-${os_name}"
  if [ $os_name == 'windows' ]; then
    if [ $cpu_arch == 'arm64' ] || [ $cpu_arch == 'aarch64' ]; then
      ctl_filename="${ctl_filename}-arm64.exe"
    else
      ctl_filename="${ctl_filename}.exe"
    fi
  else
    if [ $cpu_arch == 'arm64' ] || [ $cpu_arch == 'aarch64' ]; then
      ctl_filename="${ctl_filename}-arm64"
    fi
  fi
}

function download_yudai() {
  get_os_bin_name yudai
  bin_url="https://yudai-bin.fireboom.io/build-env/${ctl_filename}.tar.gz"
  echo $bin_url

  curl -o ${ctl_filename}.tar.gz $bin_url
  tar -zxvf ${ctl_filename}.tar.gz
  rm -f oidc 2>/dev/null || true
  mv ${ctl_filename} oidc
  rm -rf ${ctl_filename}.tar.gz

  chmod +x oidc
  rm -rf oidc.old
}

download_yudai
echo "oidc updated!"
