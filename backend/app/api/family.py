from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.connection import get_db
from app.database.models import FamilyMember, User
from app.database.schemas import FamilyMemberCreate, FamilyMemberResponse
from app.utils.auth_dependency import get_current_user

router = APIRouter()


@router.post("/family-member", response_model=FamilyMemberResponse, status_code=status.HTTP_201_CREATED)
def add_family_member(
    member_data: FamilyMemberCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_member = FamilyMember(
        user_id=current_user.id,
        name=member_data.name,
        relation=member_data.relation,
        phone_number=member_data.phone_number
    )

    db.add(new_member)
    db.commit()
    db.refresh(new_member)

    return new_member


@router.get("/family-member", response_model=List[FamilyMemberResponse])
def get_family_members(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    members = db.query(FamilyMember).filter(
        FamilyMember.user_id == current_user.id
    ).all()
    return members


@router.put("/family-member/{member_id}", response_model=FamilyMemberResponse)
def update_family_member(
    member_id: int,
    member_data: FamilyMemberCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    member = db.query(FamilyMember).filter(FamilyMember.id == member_id).first()

    if not member:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Family member not found")

    if member.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to update this family member")

    member.name = member_data.name
    member.relation = member_data.relation
    member.phone_number = member_data.phone_number

    db.commit()
    db.refresh(member)

    return member


@router.delete("/family-member/{member_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_family_member(
    member_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    member = db.query(FamilyMember).filter(FamilyMember.id == member_id).first()

    if not member:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Family member not found")

    if member.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to delete this family member")

    db.delete(member)
    db.commit()