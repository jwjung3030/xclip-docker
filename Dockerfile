FROM nvidia/cuda:12.6.2-cudnn8-runtime-ubuntu22.04

RUN apt update && apt install -y python3 python3-pip git ffmpeg libsm6 libxext6

WORKDIR /workspace

# PyTorch Nightly with CUDA 12.6
RUN pip install --upgrade pip
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu126

# XCLIP dependencies
RUN pip install transformers timm accelerate

CMD ["/bin/bash"]
