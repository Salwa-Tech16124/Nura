from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.connection import get_db
from app.database.models import SOSLog, User
from app.database.schemas import SOSLogCreate, SOSLogResponse
from app.utils.auth_dependency import get_current_user

router = APIRouter()


@router.post("/sos", response_model=SOSLogResponse, status_code=status.HTTP_201_CREATED)
def trigger_sos(
    sos_data: SOSLogCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_sos = SOSLog(
        user_id=current_user.id,
        location=sos_data.location
    )

    db.add(new_sos)
    db.commit()
    db.refresh(new_sos)

    return new_sos


@router.get("/sos/history", response_model=List[SOSLogResponse])
def get_sos_history(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    logs = db.query(SOSLog).filter(
        SOSLog.user_id == current_user.id
    ).order_by(SOSLog.triggered_at.desc()).all()
    return logs