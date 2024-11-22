FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN pip install --no-cache-dir fastapi uvicorn
RUN git clone --depth 1 https://github.com/facebookresearch/audiocraft
RUN pip install --no-cache-dir -r audiocraft/requirements.txt
RUN pip install --no-cache-dir -e audiocraft

# clear cache
RUN pip cache purge



