FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# 기본 패키지 설치
RUN apt-get update && apt-get install -y \
    python3.10 python3-pip git ffmpeg libsm6 libxext6 \
    && rm -rf /var/lib/apt/lists/*

# 심볼릭 링크 (python3 -> python)
RUN ln -s /usr/bin/python3.10 /usr/bin/python

# pip 업그레이드
RUN pip install --upgrade pip

# Python 패키지 설치
RUN pip install \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    pip install \
    transformers \
    accelerate \
    opencv-python \
    imageio \
    decord

# 작업 디렉토리
WORKDIR /app

# 소스 복사
COPY . .

# 기본 명령
CMD [ "python", "main.py" ]
