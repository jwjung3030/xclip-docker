# XCLIP GPU Docker 배포 템플릿

이 리포지토리는 NVIDIA GPU에서 XCLIP 모델을 실행할 수 있도록 구성된 Docker 환경입니다.

## 💡 구성 파일

- `Dockerfile`: CUDA + Python + XCLIP 설치
- `docker-compose.yml`: XCLIP 실행 구성
- `main.py`: XCLIP 테스트 코드

## ⚙️ 사용 방법

### 1. GPU 동작 확인
```bash
git clone https://github.com/jwjung3030/my-xclip-project.git
cd my-xclip-project
docker compose up --build

```bash
Compose can now delegate builds to bake for better performance.
 To do so, set COMPOSE_BAKE=true.
[+] Building 0.2s (11/11) FINISHED                                                                       docker:default
 => [xclip internal] load build definition from Dockerfile                                                         0.0s
 => => transferring dockerfile: 647B                                                                               0.0s
 => [xclip internal] load metadata for docker.io/nvidia/cuda:12.1.0-base-ubuntu20.04                               0.0s
 => [xclip internal] load .dockerignore                                                                            0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [xclip 1/6] FROM docker.io/nvidia/cuda:12.1.0-base-ubuntu20.04                                                 0.0s
 => CACHED [xclip 2/6] RUN apt-get update && apt-get install -y     python3     python3-pip     git     ffmpeg     0.0s
 => CACHED [xclip 3/6] RUN pip3 install --upgrade pip                                                              0.0s
 => CACHED [xclip 4/6] RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl  0.0s
 => CACHED [xclip 5/6] RUN pip3 install     transformers     timm     accelerate     opencv-python     decord      0.0s
 => CACHED [xclip 6/6] WORKDIR /app                                                                                0.0s
 => [xclip] exporting to image                                                                                     0.0s
 => => exporting layers                                                                                            0.0s
 => => writing image sha256:70568a6a46828b5fafa92e53949b7b162f1a4928f17fecbd04ee6e2caa985375                       0.0s
 => => naming to docker.io/library/my-xclip-project-xclip                                                          0.0s
 => [xclip] resolving provenance for metadata file                                                                 0.0s
[+] Running 2/2
 ✔ xclip            Built                                                                                          0.0s
 ✔ Container xclip  Created                                                                                        0.1s
Attaching to xclip
xclip  | Using device: cuda
preprocessor_config.json: 100% 310/310 [00:00<00:00, 18.8kB/s]
tokenizer_config.json: 100% 927/927 [00:00<00:00, 116kB/s]
vocab.json: 100% 1.06M/1.06M [00:00<00:00, 22.8MB/s]
merges.txt: 100% 525k/525k [00:00<00:00, 954kB/s]
tokenizer.json: 100% 2.22M/2.22M [00:00<00:00, 29.8MB/s]
special_tokens_map.json: 100% 472/472 [00:00<00:00, 388kB/s]
config.json: 100% 8.90k/8.90k [00:00<00:00, 306kB/s]
model.safetensors: 100% 780M/780M [00:08<00:00, 87.4MB/s]
xclip  | XCLIP 모델이 성공적으로 로드되었습니다.
xclip exited with code 0
