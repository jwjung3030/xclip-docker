#!/bin/bash
set -e

echo "[1] NVIDIA Container Toolkit 설치 중..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | \
    sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit.gpg

curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
    sed 's#deb #deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit.gpg] #' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

echo "[2] Docker에 NVIDIA 런타임 등록 중..."
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

echo "[3] Docker GPU 테스트 중..."
docker run --rm --runtime=nvidia nvidia/cuda:12.1.1-base-ubuntu22.04 nvidia-smi

echo "✅ GPU 런타임 설정 완료!"
