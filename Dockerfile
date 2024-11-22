FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

WORKDIR /app
RUN pip install --no-cache-dir fastapi uvicorn
RUN git clone --depth 1 https://github.com/facebookresearch/audiocraft
RUN pip install --no-cache-dir -r audiocraft/requirements.txt
RUN pip install --no-cache-dir -e audiocraft

# clear cache
RUN pip cache purge



