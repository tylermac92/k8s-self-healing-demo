from fastapi import FastAPI, Response
import uvicorn
import os

app = FastAPI()

unhealthy = False
ready = False

@app.get("/healthz")
def healthz():
    return Response(status_code=500) if unhealthy else Response(status_code=200)

@app.get("/readyz")
def readyz():
    return Response(status_code=200) if ready else Response(status_code=500)

@app.post("/fail")
def fail():
    global unhealthy
    unhealthy = not unhealthy
    return {"unhealthy": unhealthy}

@app.post("/ready")
def set_ready():
    global ready
    ready = True
    return {"ready": ready}

@app.get("/")
def root():
    return {"message": "Self-healing demo app"}

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)