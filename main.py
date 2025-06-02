from transformers import XCLIPProcessor, XCLIPModel
import torch

device = "cuda" if torch.cuda.is_available() else "cpu"

processor = XCLIPProcessor.from_pretrained("microsoft/xclip-base-patch16")
model = XCLIPModel.from_pretrained("microsoft/xclip-base-patch16").to(device)

print(f"모델이 {device}에서 정상적으로 로드되었습니다.")
