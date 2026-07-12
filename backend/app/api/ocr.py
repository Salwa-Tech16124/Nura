import os
import uuid
from fastapi import APIRouter, Depends, HTTPException, status, UploadFile, File
from sqlalchemy.orm import Session
from datetime import datetime

from app.database.connection import get_db
from app.database.models import OCRReport, TimelineEntry, User
from app.database.schemas import OCRReportResponse
from app.utils.auth_dependency import get_current_user
from app.services.gemini_service import analyze_report_document

router = APIRouter()

UPLOAD_DIR = "uploads/reports"
os.makedirs(UPLOAD_DIR, exist_ok=True)


@router.post("/ocr/upload", response_model=OCRReportResponse, status_code=status.HTTP_201_CREATED)
async def upload_report(
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    contents = await file.read()
    mime_type = file.content_type or "image/jpeg"

    # Save file to disk
    unique_name = f"{uuid.uuid4()}_{file.filename}"
    file_path = os.path.join(UPLOAD_DIR, unique_name)
    with open(file_path, "wb") as f:
        f.write(contents)

    # Extract via Gemini
    result = analyze_report_document(contents, mime_type)

    report_date = None
    if result.get("report_date"):
        try:
            report_date = datetime.strptime(result["report_date"], "%Y-%m-%d")
        except (ValueError, TypeError):
            report_date = None

    new_report = OCRReport(
        user_id=current_user.id,
        file_url=file_path,
        raw_extracted_text=result.get("raw_text"),
        structured_data=result.get("structured_data"),
        report_date=report_date
    )

    db.add(new_report)
    db.commit()
    db.refresh(new_report)

    # Create matching Timeline entry
    structured = result.get("structured_data") or {}
    title = structured.get("report_type", "Lab Report")
    content = structured.get("summary", "Report uploaded — see details.")

    timeline_entry = TimelineEntry(
        user_id=current_user.id,
        source_type="ocr_report",
        source_id=new_report.id,
        title=title,
        content=content,
        occurred_at=report_date or new_report.created_at
    )

    db.add(timeline_entry)
    db.commit()

    return new_report


@router.get("/ocr/{report_id}", response_model=OCRReportResponse)
def get_report(
    report_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    report = db.query(OCRReport).filter(OCRReport.id == report_id).first()

    if not report:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Report not found")

    if report.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not your report")

    return report