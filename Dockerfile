FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3.10 python3-pip git ffmpeg libsm6 libxext6 && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.10 /usr/bin/python
RUN pip install --upgrade pip

# XCLIP + 기타 패키지 설치
RUN pip install \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    pip install \
    transformers \
    accelerate \
    opencv-python \
    imageio \
    decord

WORKDIR /app
COPY . .
CMD ["python", "main.py"]
