from sqlalchemy import Column, Integer, String, ForeignKey, Date, DateTime, Float , Text, JSON
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database.connection import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    age = Column(Integer, nullable=True)
    gender = Column(String, nullable=True)
    phone_number = Column(String, unique=True, nullable=False)
    emergency_contact = Column(String, nullable=True)
    email = Column(String, unique=True, nullable=False)
    hashed_password = Column(String, nullable=False)

    medicines = relationship("Medicine", back_populates="user")
    health_logs = relationship("HealthLog", back_populates="user")
    appointments = relationship("Appointment", back_populates="user")
    family_members = relationship("FamilyMember", back_populates="user")
    sos_logs = relationship("SOSLog", back_populates="user")
    ocr_reports = relationship("OCRReport", back_populates="user")
    timeline_entries = relationship("TimelineEntry", back_populates="user")


class Medicine(Base):
    __tablename__ = "medicines"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    medicine_name = Column(String, nullable=False)
    dosage = Column(String, nullable=True)
    frequency = Column(String, nullable=True)
    time = Column(String, nullable=True)
    start_date = Column(Date, nullable=True)
    end_date = Column(Date, nullable=True)

    user = relationship("User", back_populates="medicines")


class HealthLog(Base):
    __tablename__ = "health_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    blood_pressure = Column(String, nullable=True)
    sugar_level = Column(Float, nullable=True)
    weight = Column(Float, nullable=True)
    sleep_hours = Column(Float, nullable=True)
    mood = Column(String, nullable=True)
    symptoms = Column(String, nullable=True)
    heart_rate = Column(Integer, nullable=True)
    calories_burned = Column(Float, nullable=True)
    steps = Column(Integer, nullable=True)
    logged_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="health_logs")

class Appointment(Base):
    __tablename__ = "appointments"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    doctor_name = Column(String, nullable=False)
    hospital = Column(String, nullable=True)
    appointment_date = Column(Date, nullable=False)
    appointment_time = Column(String, nullable=False)

    user = relationship("User", back_populates="appointments")


class FamilyMember(Base):
    __tablename__ = "family_members"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    name = Column(String, nullable=False)
    relation = Column(String, nullable=True)
    phone_number = Column(String, nullable=True)

    user = relationship("User", back_populates="family_members")


class SOSLog(Base):
    __tablename__ = "sos_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    triggered_at = Column(DateTime, default=datetime.utcnow)
    location = Column(String, nullable=True)
    status = Column(String, default="active")

    user = relationship("User", back_populates="sos_logs")
    


class OCRReport(Base):
    __tablename__ = "ocr_reports"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    file_url = Column(String, nullable=False)
    raw_extracted_text = Column(Text, nullable=True)
    structured_data = Column(JSON, nullable=True)
    report_date = Column(DateTime, nullable=True)

    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="ocr_reports")
    timeline_entries = relationship(
        "TimelineEntry",
        primaryjoin="and_(foreign(TimelineEntry.source_id)==OCRReport.id, TimelineEntry.source_type=='ocr_report')",
        back_populates="ocr_report",
        viewonly=True,
    )

class TimelineEntry(Base):
    __tablename__ = "timeline_entries"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    source_type = Column(String, nullable=False)  # "health_log" | "ocr_report" | "manual_note"
    source_id = Column(Integer, nullable=True)     # points to health_logs.id or ocr_reports.id; null for manual_note

    title = Column(String, nullable=False)
    content = Column(Text, nullable=True)

    occurred_at = Column(DateTime, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="timeline_entries")
    ocr_report = relationship(
        "OCRReport",
        primaryjoin="foreign(TimelineEntry.source_id)==OCRReport.id",
        back_populates="timeline_entries",
        viewonly=True,
    ) 
    
