# XCLIP GPU Docker 배포 템플릿(dual 사용하기 전 버전)

이 리포지토리는 NVIDIA GPU에서 XCLIP 모델을 실행할 수 있도록 구성된 Docker 환경입니다.

## 💡 구성 파일

- `Dockerfile`: CUDA + Python + XCLIP 설치
- `docker-compose.yml`: XCLIP 실행 구성
- `main.py`: XCLIP 테스트 코드

## ⚙️ 사용 방법

### 1. GPU 동작 확인
```bash
git clone https://github.com/jwjung3030/xclip-docker.git
cd xclip-docker
docker compose up --build
