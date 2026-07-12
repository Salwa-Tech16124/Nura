from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.connection import get_db
from app.database.models import HealthLog, User , TimelineEntry
from app.database.schemas import HealthLogCreate, HealthLogResponse
from app.utils.auth_dependency import get_current_user

router = APIRouter()


@router.post("/health-log", response_model=HealthLogResponse, status_code=status.HTTP_201_CREATED)
def add_health_log(
    log_data: HealthLogCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_log = HealthLog(
        user_id=current_user.id,
        blood_pressure=log_data.blood_pressure,
        sugar_level=log_data.sugar_level,
        weight=log_data.weight,
        sleep_hours=log_data.sleep_hours,
        mood=log_data.mood,
        symptoms=log_data.symptoms,
        heart_rate=log_data.heart_rate,
        calories_burned=log_data.calories_burned,
        steps=log_data.steps
    )

    db.add(new_log)
    db.commit()
    db.refresh(new_log)

    # Auto-create matching Timeline entry
    title = f"Health log: {log_data.symptoms}" if log_data.symptoms else "Health log entry"

    content_parts = []
    if log_data.blood_pressure:
        content_parts.append(f"BP: {log_data.blood_pressure}")
    if log_data.sugar_level is not None:
        content_parts.append(f"Sugar: {log_data.sugar_level}")
    if log_data.weight is not None:
        content_parts.append(f"Weight: {log_data.weight}")
    if log_data.heart_rate is not None:
        content_parts.append(f"Heart rate: {log_data.heart_rate}")
    if log_data.mood:
        content_parts.append(f"Mood: {log_data.mood}")

    timeline_entry = TimelineEntry(
        user_id=current_user.id,
        source_type="health_log",
        source_id=new_log.id,
        title=title,
        content=", ".join(content_parts) if content_parts else None,
        occurred_at=new_log.logged_at
    )

    db.add(timeline_entry)
    db.commit()

    return new_log

@router.get("/health-history", response_model=List[HealthLogResponse])
def get_health_history(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    logs = db.query(HealthLog).filter(HealthLog.user_id == current_user.id).order_by(HealthLog.logged_at.desc()).all()
    return logs

@router.put("/health-log/{log_id}", response_model=HealthLogResponse)
def update_health_log(
    log_id: int,
    log_data: HealthLogCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    log = db.query(HealthLog).filter(HealthLog.id == log_id).first()

    if not log:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Health log not found")

    if log.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to update this log")

    log.blood_pressure = log_data.blood_pressure
    log.sugar_level = log_data.sugar_level
    log.weight = log_data.weight
    log.sleep_hours = log_data.sleep_hours
    log.mood = log_data.mood
    log.symptoms = log_data.symptoms
    log.heart_rate = log_data.heart_rate
    log.calories_burned = log_data.calories_burned
    log.steps = log_data.steps

    db.commit()
    db.refresh(log)

    # Sync matching Timeline entry
    timeline_entry = db.query(TimelineEntry).filter(
        TimelineEntry.source_type == "health_log",
        TimelineEntry.source_id == log.id
    ).first()

    if timeline_entry:
        title = f"Health log: {log_data.symptoms}" if log_data.symptoms else "Health log entry"

        content_parts = []
        if log_data.blood_pressure:
            content_parts.append(f"BP: {log_data.blood_pressure}")
        if log_data.sugar_level is not None:
            content_parts.append(f"Sugar: {log_data.sugar_level}")
        if log_data.weight is not None:
            content_parts.append(f"Weight: {log_data.weight}")
        if log_data.heart_rate is not None:
            content_parts.append(f"Heart rate: {log_data.heart_rate}")
        if log_data.mood:
            content_parts.append(f"Mood: {log_data.mood}")

        timeline_entry.title = title
        timeline_entry.content = ", ".join(content_parts) if content_parts else None
        db.commit()

    return log


@router.delete("/health-log/{log_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_health_log(
    log_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    log = db.query(HealthLog).filter(HealthLog.id == log_id).first()

    if not log:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Health log not found")

    if log.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to delete this log")

    # Delete matching Timeline entry first
    db.query(TimelineEntry).filter(
        TimelineEntry.source_type == "health_log",
        TimelineEntry.source_id == log.id
    ).delete()

    db.delete(log)
    db.commit()
# @router.get("/health/step-goal")
# def get_step_goal(current_user: User = Depends(get_current_user)):
#     age = current_user.age

#     if age is None:
#         recommended_steps = 10000
#         note = "Age not set — showing general recommendation."
#     elif age < 18:
#         recommended_steps = 12000
#         note = "Children and teens generally benefit from higher activity levels."
#     elif age <= 64:
#         recommended_steps = 10000
#         note = "Standard recommendation for adults."
#     else:
#         recommended_steps = 7000
#         note = "Adjusted recommendation for older adults — consult a doctor for personalized advice."

#     return {
#         "recommended_daily_steps": recommended_steps,
#         "note": note,
#         "source": "Based on general public health guidelines (CDC/WHO-aligned averages), not a personalized medical recommendation."
#     }