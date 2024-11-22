import fastapi
from audiocraft.models import MusicGen
from audiocraft.data.audio import audio_write
from fastapi import FastAPI, Query
from fastapi.responses import FileResponse
from pathlib import Path
import uuid

app = FastAPI()
output_dir = Path("output")
output_dir.mkdir(exist_ok=True)

@app.post("/generate_music")
async def generate_music(
    descriptions: list[str] = Query(..., description="List of descriptions for the audio generation"),
    model_name: str = Query('facebook/musicgen-small', description="Pretrained model name"),
    duration: int = Query(8, description="Duration of the generated audio in seconds")
):
    if not hasattr(app.state, "models_cache"):
        app.state.models_cache = {}

    if model_name not in app.state.models_cache:
        app.state.models_cache[model_name] = MusicGen.get_pretrained(model_name)
    
    model = app.state.models_cache[model_name]
    model.set_generation_params(duration=duration)
    wav = model.generate(descriptions)
    filename = output_dir / f"{uuid.uuid4()}"
    filename = audio_write(filename, wav[0].cpu(), model.sample_rate, strategy="loudness", loudness_compressor=True)
    return FileResponse(filename, media_type="audio/wav")
