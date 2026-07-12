from fastapi import APIRouter, Depends
from pydantic import BaseModel
from app.database.models import User
from app.utils.auth_dependency import get_current_user
from fastapi import UploadFile, File
from app.services.gemini_service import analyze_medicine_photo


from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.models import TimelineEntry
from app.database.schemas import AIAskRequest
from app.services.gemini_service import ask_with_context

router = APIRouter()


class AIChatRequest(BaseModel):
    message: str


@router.post("/ai/chat")
def ai_chat(request: AIChatRequest, current_user: User = Depends(get_current_user)):
    # TODO: forward to Deepti's AI module once ready
    return {"reply": f"[Stub] Received: '{request.message}'. AI engine not connected yet."}


@router.post("/ai/summary")
def ai_summary(current_user: User = Depends(get_current_user)):
    return {"summary": "[Stub] AI-generated health summary not yet available."}


@router.post("/ai/report")
def ai_report(current_user: User = Depends(get_current_user)):
    return {"report": "[Stub] AI-generated report not yet available."}


@router.post("/ai/prescription")
def ai_prescription(current_user: User = Depends(get_current_user)):
    return {"prescription_analysis": "[Stub] Prescription analysis not yet available."}


@router.post("/ai/risk")
def ai_risk(current_user: User = Depends(get_current_user)):
    return {"risk_assessment": "[Stub] Risk assessment not yet available."}




@router.post("/ai/medicine-scan")
async def scan_medicine(
    photo: UploadFile = File(...),
    current_user: User = Depends(get_current_user)
):
    contents = await photo.read()

    ai_analysis = analyze_medicine_photo(contents, current_user.age)

    return {
        "filename": photo.filename,
        "analysis": ai_analysis,
        "disclaimer": "This is an AI-generated estimate based on image analysis. Always confirm with a doctor or pharmacist before taking any medication."
    } 
    
@router.post("/ai/ask")
def ask_ai_assistant(
    request: AIAskRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    entries = db.query(TimelineEntry).filter(
        TimelineEntry.user_id == current_user.id
    ).order_by(TimelineEntry.occurred_at.desc()).all()

    if not entries:
        context = "No health history recorded yet."
    else:
        lines = []
        for e in entries:
            date_str = e.occurred_at.strftime("%Y-%m-%d")
            lines.append(f"[{date_str}] ({e.source_type}) {e.title}: {e.content or 'No details'}")
        context = "\n".join(lines)

    answer = ask_with_context(context, request.question)

    return {"answer": answer}    
    
    