from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.connection import get_db
from app.database.models import Appointment, User
from app.database.schemas import AppointmentCreate, AppointmentResponse
from app.utils.auth_dependency import get_current_user

router = APIRouter()


@router.post("/appointment", response_model=AppointmentResponse, status_code=status.HTTP_201_CREATED)
def add_appointment(
    appointment_data: AppointmentCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_appointment = Appointment(
        user_id=current_user.id,
        doctor_name=appointment_data.doctor_name,
        hospital=appointment_data.hospital,
        appointment_date=appointment_data.appointment_date,
        appointment_time=appointment_data.appointment_time
    )

    db.add(new_appointment)
    db.commit()
    db.refresh(new_appointment)

    return new_appointment


@router.get("/appointment", response_model=List[AppointmentResponse])
def get_appointments(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    appointments = db.query(Appointment).filter(
        Appointment.user_id == current_user.id
    ).order_by(Appointment.appointment_date.asc()).all()
    return appointments


@router.put("/appointment/{appointment_id}", response_model=AppointmentResponse)
def update_appointment(
    appointment_id: int,
    appointment_data: AppointmentCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    appointment = db.query(Appointment).filter(Appointment.id == appointment_id).first()

    if not appointment:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Appointment not found")

    if appointment.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to update this appointment")

    appointment.doctor_name = appointment_data.doctor_name
    appointment.hospital = appointment_data.hospital
    appointment.appointment_date = appointment_data.appointment_date
    appointment.appointment_time = appointment_data.appointment_time

    db.commit()
    db.refresh(appointment)

    return appointment


@router.delete("/appointment/{appointment_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_appointment(
    appointment_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    appointment = db.query(Appointment).filter(Appointment.id == appointment_id).first()

    if not appointment:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Appointment not found")

    if appointment.user_id != current_user.id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You don't have permission to delete this appointment")

    db.delete(appointment)
    db.commit()