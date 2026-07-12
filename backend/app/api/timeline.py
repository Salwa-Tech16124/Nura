from typing import List
from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session
from datetime import datetime

from app.database.connection import get_db
from app.database.models import TimelineEntry, User
from app.database.schemas import TimelineEntryCreate, TimelineEntryResponse
from app.utils.auth_dependency import get_current_user

from fastapi import APIRouter, Depends, HTTPException, status

router = APIRouter()


@router.get("/timeline", response_model=List[TimelineEntryResponse])
def get_timeline(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    entries = db.query(TimelineEntry).filter(
        TimelineEntry.user_id == current_user.id
    ).order_by(TimelineEntry.occurred_at.desc()).all()

    return entries


@router.post("/timeline", response_model=TimelineEntryResponse, status_code=status.HTTP_201_CREATED)
def add_manual_note(
    entry_data: TimelineEntryCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_entry = TimelineEntry(
        user_id=current_user.id,
        source_type="manual_note",
        source_id=None,
        title=entry_data.title,
        content=entry_data.content,
        occurred_at=entry_data.occurred_at or datetime.utcnow()
    )

    db.add(new_entry)
    db.commit()
    db.refresh(new_entry)

    return new_entry

@router.delete("/timeline/{entry_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_timeline_entry(
    entry_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    entry = db.query(TimelineEntry).filter(TimelineEntry.id == entry_id).first()

    if not entry:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Timeline entry not found")

    if entry.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to delete this entry")

    db.delete(entry)
    db.commit()
