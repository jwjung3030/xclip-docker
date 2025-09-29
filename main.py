from transformers import XCLIPProcessor, XCLIPModel
import torch

device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Using device: {device}")

processor = XCLIPProcessor.from_pretrained("microsoft/xclip-base-patch16")
model = XCLIPModel.from_pretrained("microsoft/xclip-base-patch16").to(device)

print("XCLIP 모델이 성공적으로 로드되었습니다.")
