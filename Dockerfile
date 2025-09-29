# ------------------------
# 1단계: 베이스 이미지 선택
# ------------------------
# 기본값 = GPU
ARG BASE_IMAGE=nvidia/cuda:12.1.0-base-ubuntu20.04
FROM ${BASE_IMAGE} AS runtime

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Asia/Seoul
ENV TZ=${TZ}

# 필수 패키지 (둘 다 공통으로 필요)
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 python3-pip git ffmpeg libsm6 libxext6 \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ------------------------
# 2단계: Python 라이브러리
# ------------------------
# gpu | cpu
ARG DEVICE=gpu
RUN pip3 install --upgrade pip

RUN if [ "$DEVICE" = "gpu" ]; then \
        # GPU 휠 (CUDA 12.1) ──> 약 600 MB
        pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 ; \
    else \
        # CPU 휠 ──> 약 200 MB, CUDA 라이브러리 미포함
        pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu ; \
    fi

RUN pip3 install transformers timm accelerate opencv-python decord einops

WORKDIR /app
CMD ["/bin/bash"]
