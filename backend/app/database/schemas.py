from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date, datetime


class UserCreate(BaseModel):
    name: str
    age: Optional[int] = None
    gender: Optional[str] = None
    phone_number: str
    emergency_contact: Optional[str] = None
    email: EmailStr
    password: str


class UserResponse(BaseModel):
    id: int
    name: str
    age: Optional[int] = None
    gender: Optional[str] = None
    phone_number: str
    emergency_contact: Optional[str] = None
    email: EmailStr

    class Config:
        from_attributes = True
        
        



# ---------- Medicine ----------

class MedicineCreate(BaseModel):
    medicine_name: str
    dosage: Optional[str] = None
    frequency: Optional[str] = None
    time: Optional[str] = None
    start_date: Optional[date] = None
    end_date: Optional[date] = None


class MedicineResponse(MedicineCreate):
    id: int
    user_id: int

    class Config:
        from_attributes = True


# ---------- Health Log ----------

class HealthLogCreate(BaseModel):
    blood_pressure: Optional[str] = None
    sugar_level: Optional[float] = None
    weight: Optional[float] = None
    sleep_hours: Optional[float] = None
    mood: Optional[str] = None
    symptoms: Optional[str] = None
    heart_rate: Optional[int] = None
    calories_burned: Optional[float] = None
    steps: Optional[int] = None


class HealthLogResponse(HealthLogCreate):
    id: int
    user_id: int
    logged_at: datetime

    class Config:
        from_attributes = True


# ---------- Appointment ----------

class AppointmentCreate(BaseModel):
    doctor_name: str
    hospital: Optional[str] = None
    appointment_date: date
    appointment_time: str


class AppointmentResponse(AppointmentCreate):
    id: int
    user_id: int

    class Config:
        from_attributes = True


# ---------- Family Member ----------

class FamilyMemberCreate(BaseModel):
    name: str
    relation: Optional[str] = None
    phone_number: Optional[str] = None


class FamilyMemberResponse(FamilyMemberCreate):
    id: int
    user_id: int

    class Config:
        from_attributes = True


# ---------- SOS Log ----------

class SOSLogCreate(BaseModel):
    location: Optional[str] = None


class SOSLogResponse(SOSLogCreate):
    id: int
    user_id: int
    triggered_at: datetime
    status: str

    class Config:
        from_attributes = True     
        
class LoginRequest(BaseModel):
    email: EmailStr
    password: str           
    

# ---------- OCR Report ----------

class OCRReportResponse(BaseModel):
    id: int
    user_id: int
    file_url: str
    raw_extracted_text: Optional[str] = None
    structured_data: Optional[dict] = None
    report_date: Optional[datetime] = None
    created_at: datetime

    class Config:
        from_attributes = True


# ---------- Timeline ----------

class TimelineEntryCreate(BaseModel):
    title: str
    content: Optional[str] = None
    occurred_at: Optional[datetime] = None


class TimelineEntryResponse(BaseModel):
    id: int
    user_id: int
    source_type: str
    source_id: Optional[int] = None
    title: str
    content: Optional[str] = None
    occurred_at: datetime
    created_at: datetime

    class Config:
        from_attributes = True


# ---------- AI Assistant ----------

class AIAskRequest(BaseModel):
    question: str    