import os, sys, json, requests

OLLAMA_HOST = os.getenv("OLLAMA_HOST", "http://localhost:11434")
MODEL = os.getenv("OLLAMA_MODEL", "gemma3:4b")

def translate(text: str, temperature: float = 0.2) -> str:
    url = f"{OLLAMA_HOST}/api/chat"
    payload = {
        "model": MODEL,
        "messages": [
            {"role": "system", "content": "You are a translation engine. Output only the translation."},
            {"role": "user", "content": f"Translate to English:\n{text}"}
        ],
        "options": {"temperature": temperature},
        "stream": False
    }
    r = requests.post(url, data=json.dumps(payload), timeout=120)
    r.raise_for_status()
    data = r.json()
    if "message" in data and "content" in data["message"]:
        return data["message"]["content"]
    if "messages" in data and data["messages"]:
        return data["messages"][-1].get("content", "")
    return json.dumps(data, ensure_ascii=False)

from transformers import XCLIPProcessor, XCLIPModel
import torch

def load_xclip():
    device = "cuda" if torch.cuda.is_available() else "cpu"
    print(f"Using device: {device}")
    
    processor = XCLIPProcessor.from_pretrained("microsoft/xclip-base-patch16")
    model = XCLIPModel.from_pretrained("microsoft/xclip-base-patch16").to(device)
    
    print("XCLIP 모델이 성공적으로 로드되었습니다.")

if __name__ == "__main__":

    load_xclip()
    
    if len(sys.argv) < 2:
        print("Usage: python main.py '<Korean sentence or prompt>'")
        sys.exit(1)
    try:
        print(translate(sys.argv[1]).strip())
    except Exception as e:
        print(f"ERROR: {e}")
        sys.exit(2)
