FROM nvidia/cuda:12.1.0-base-ubuntu20.04

# 비대화형 모드 및 타임존 설정
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apt-get clean

RUN pip3 install --upgrade pip

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

RUN pip3 install \
    transformers \
    timm \
    accelerate \
    opencv-python \
    decord \
    einops

WORKDIR /app

CMD ["/bin/bash"]
