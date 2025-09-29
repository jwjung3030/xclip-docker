# XCLIP GPU CPU Docker 배포 템플릿

이 리포지토리는 NVIDIA GPU 또는 CPU에서 XCLIP 모델을 실행할 수 있도록 구성된 Docker 환경입니다.

## 💡 구성 파일

- `Dockerfile`: CUDA + Python + XCLIP 설치
- `docker-compose.yml`: XCLIP 실행 구성
- `main.py`: XCLIP 테스트 코드

## ⚙️ 사용 방법

### 1. GPU 동작 확인
```bash
git clone https://github.com/jwjung3030/xclip-docker-dual.git
cd xclip-docker-dual

CPU용 이미지 빌드:
docker compose build xclip-cpu

GPU용 이미지 빌드:
docker compose build xclip-gpu

CPU용 이미지 docker 접속:
docker run -it --rm -v ${PWD}:/app  xclip-cpu

GPU용 이미지 docker 접속:
docker run -it --rm --gpus all -v ${PWD}:/app  xclip-gpu

실행
python main.py
