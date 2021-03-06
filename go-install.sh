#!/bin/bash

# useage: ./go-install.sh 1.17

# https://golang.org/dl

case "$(uname -s)" in
  Darwin)
    SYSTEM=darwin
    ;;
  Linux)
    SYSTEM=linux
    ;;
  *)
    error "Unexpected system"
    ;;
esac

case "$(uname -m)" in
  x86_64)
    HARDWARE=amd64
    ;;
  arm64)
    HARDWARE=arm64
    ;;
  *)
    error "Unexpected hardware"
    ;;
esac

GOVERSION=go"$1"
GOFILE=${GOVERSION}.${SYSTEM}-${HARDWARE}.tar.gz

wget https://golang.org/dl/"${GOFILE}" -O /tmp/"${GOFILE}"
mkdir -p "$HOME"/go
tar -xf /tmp/"${GOFILE}" -C "$HOME"/go

mv "$HOME"/go/go "$HOME"/go/"${GOVERSION}"

tee -a "$HOME"/.zshrc << 'EOF'

# Go envs
export GOVERSION=${GOVERSION} # Go 版本设置
export GO_INSTALL_DIR=$HOME/go # Go 安装目录
export GOROOT=$GO_INSTALL_DIR/$GOVERSION # GOROOT 设置
export GOPATH=$HOME/Syncthing/code/mac-golang # GOPATH 设置
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin # 将 Go 语言自带的和通过 go install 安装的二进制文件加入到 PATH 路径中
export GO111MODULE="on" # 开启 Go moudles 特性
EOF
