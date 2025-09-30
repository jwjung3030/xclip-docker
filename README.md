# XCLIP GPU CPU Docker 배포 템플릿

이 리포지토리는 NVIDIA GPU 또는 CPU에서 XCLIP 모델을 실행할 수 있도록 구성된 Docker 환경입니다.

## 💡 구성 파일

- `Dockerfile`: CUDA + Python + XCLIP 설치
- `docker-compose.yml`: XCLIP 실행 구성
- `main.py`: XCLIP 테스트 코드

## ⚙️ 사용 방법

### 1. GPU 동작 확인
```bash
git clone https://github.com/jwjung3030/xclip-docker.git
cd xclip-docker


### 1️⃣ 빌드

- Ollama 서버와 xclip-cpu 빌드:

```bash
docker compose --profile ollama --profile xclip-cpu build

```

- Ollama 서버와 xclip-gpu 빌드:

```bash
docker compose --profile ollama --profile xclip-gpu build

```

> 한 번에 두 GPU/CPU 모두 빌드하려면:
> 

```bash
docker compose --profile ollama --profile xclip-gpu --profile xclip-cpu build

```

---

### 2️⃣ 실행

- Ollama + xclip-cpu 실행:

```bash
docker compose --profile ollama --profile xclip-cpu up -d

```

- Ollama + xclip-gpu 실행:

```bash
docker compose --profile ollama --profile xclip-gpu up -d

```

- 모든 컨테이너 실행:

```bash
docker compose --profile ollama --profile xclip-gpu --profile xclip-cpu up -d

```

---

### 3️⃣ 상태 확인

- 컨테이너 상태 확인:

```bash
docker ps

```

- Ollama health 확인:

```bash
docker inspect -f '{{.State.Health.Status}}' ollama

```

- 컨테이너 안에서 Ollama 접속 테스트:

```bash
docker exec -it xclip-cpu curl http://ollama:11434/api/tags
docker exec -it xclip-gpu curl http://ollama:11434/api/tags

```

---

### 4️⃣ 종료 및 정리

- 모든 컨테이너 종료:

```bash
docker compose --profile ollama --profile xclip-gpu --profile xclip-cpu down

```

- 볼륨 포함 완전 삭제:

```bash
docker compose --profile ollama --profile xclip-gpu --profile xclip-cpu down -v

```


### 4️⃣ 접속 실행

CPU용 이미지 docker 접속:
docker run -it --rm --network xclip-docker_ollama-net -e OLLAMA_HOST=http://ollama:11434 -v ${PWD}:/app  xclip-cpu

GPU용 이미지 docker 접속:
docker run -it --rm --network xclip-docker_ollama-net -e OLLAMA_HOST=http://ollama:11434 --gpus all -v ${PWD}:/app  xclip-gpu

실행
python main.py
