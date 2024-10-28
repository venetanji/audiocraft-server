FROM python:3.9

RUN pip install \
    torch==2.1.0 \
    torchvision==0.16.0 \
    torchaudio==2.1.0 \
    --index-url https://download.pytorch.org/whl/cu121

WORKDIR /app
RUN pip install fastapi uvicorn
RUN git clone --depth 1 https://github.com/facebookresearch/audiocraft
RUN pip install -r audiocraft/requirements.txt
