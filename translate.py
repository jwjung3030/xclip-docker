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

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python translate.py '<Korean sentence or prompt>'")
        sys.exit(1)
    try:
        print(translate(sys.argv[1]).strip())
    except Exception as e:
        print(f"ERROR: {e}")
        sys.exit(2)
