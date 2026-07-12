from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import auth, medicine, health, appointment, sos, family, reports, ai, diet, ocr, timeline

app = FastAPI(title="AI Care Copilot API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/auth", tags=["Authentication"])
app.include_router(medicine.router, prefix="/medicine", tags=["Medicine"])
app.include_router(health.router, tags=["Health"])
# ROADMAP (post-MVP): Appointment Booking — disconnected per NURA MVP refactor
# app.include_router(appointment.router, tags=["Appointment"])
app.include_router(sos.router, tags=["SOS"])
app.include_router(family.router, tags=["Family"])
app.include_router(reports.router, tags=["Reports"])
app.include_router(ai.router, tags=["AI Bridge"])
app.include_router(ocr.router, tags=["OCR"])
app.include_router(timeline.router, tags=["Timeline"])
# ROADMAP (post-MVP): Diet Planner/Calorie Counter — disconnected per NURA MVP refactor
# app.include_router(diet.router, tags=["Diet"])


@app.get("/")
def root():
    return {"message": "AI Care Copilot backend is running!"}