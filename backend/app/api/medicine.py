from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.connection import get_db
from app.database.models import Medicine, User
from app.database.schemas import MedicineCreate, MedicineResponse
from app.utils.auth_dependency import get_current_user

router = APIRouter()


@router.post("/", response_model=MedicineResponse, status_code=status.HTTP_201_CREATED)
def add_medicine(
    medicine_data: MedicineCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_medicine = Medicine(
        user_id=current_user.id,
        medicine_name=medicine_data.medicine_name,
        dosage=medicine_data.dosage,
        frequency=medicine_data.frequency,
        time=medicine_data.time,
        start_date=medicine_data.start_date,
        end_date=medicine_data.end_date
    )

    db.add(new_medicine)
    db.commit()
    db.refresh(new_medicine)

    return new_medicine


@router.get("/", response_model=List[MedicineResponse])
def get_medicines(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    medicines = db.query(Medicine).filter(Medicine.user_id == current_user.id).all()
    return medicines


@router.put("/{medicine_id}", response_model=MedicineResponse)
def update_medicine(
    medicine_id: int,
    medicine_data: MedicineCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    medicine = db.query(Medicine).filter(Medicine.id == medicine_id).first()

    if not medicine:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Medicine not found"
        )

    if medicine.user_id != current_user.id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You don't have permission to update this medicine"
        )

    medicine.medicine_name = medicine_data.medicine_name
    medicine.dosage = medicine_data.dosage
    medicine.frequency = medicine_data.frequency
    medicine.time = medicine_data.time
    medicine.start_date = medicine_data.start_date
    medicine.end_date = medicine_data.end_date

    db.commit()
    db.refresh(medicine)

    return medicine


@router.delete("/{medicine_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_medicine(
    medicine_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    medicine = db.query(Medicine).filter(Medicine.id == medicine_id).first()

    if not medicine:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Medicine not found"
        )

    if medicine.user_id != current_user.id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You don't have permission to delete this medicine"
        )

    db.delete(medicine)
    db.commit()