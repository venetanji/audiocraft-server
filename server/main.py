import fastapi

app = fastapi.FastAPI()

@app.get("/generate_audio")
def generate_audio():
    return {"audio": "audio.mp3"}