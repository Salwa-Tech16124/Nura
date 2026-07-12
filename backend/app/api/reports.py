from datetime import datetime, timedelta
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import func

from app.database.connection import get_db
from app.database.models import Medicine, HealthLog, Appointment, SOSLog, User
from app.utils.auth_dependency import get_current_user

router = APIRouter()


def build_report(db: Session, user_id: int, days: int):
    since = datetime.utcnow() - timedelta(days=days)

    active_medicines = db.query(Medicine).filter(Medicine.user_id == user_id).count()

    avg_sugar = db.query(func.avg(HealthLog.sugar_level)).filter(
        HealthLog.user_id == user_id, HealthLog.logged_at >= since
    ).scalar()

    avg_weight = db.query(func.avg(HealthLog.weight)).filter(
        HealthLog.user_id == user_id, HealthLog.logged_at >= since
    ).scalar()

    avg_sleep = db.query(func.avg(HealthLog.sleep_hours)).filter(
        HealthLog.user_id == user_id, HealthLog.logged_at >= since
    ).scalar()

    health_log_count = db.query(HealthLog).filter(
        HealthLog.user_id == user_id, HealthLog.logged_at >= since
    ).count()

    upcoming_appointments = db.query(Appointment).filter(
        Appointment.user_id == user_id,
        Appointment.appointment_date >= datetime.utcnow().date()
    ).count()

    sos_triggers = db.query(SOSLog).filter(
        SOSLog.user_id == user_id, SOSLog.triggered_at >= since
    ).count()

    return {
        "period_days": days,
        "active_medicines": active_medicines,
        "health_logs_recorded": health_log_count,
        "average_sugar_level": round(avg_sugar, 1) if avg_sugar else None,
        "average_weight": round(avg_weight, 1) if avg_weight else None,
        "average_sleep_hours": round(avg_sleep, 1) if avg_sleep else None,
        "upcoming_appointments": upcoming_appointments,
        "sos_triggers": sos_triggers
    }


@router.get("/weekly-report")
def weekly_report(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return build_report(db, current_user.id, days=7)


@router.get("/monthly-report")
def monthly_report(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return build_report(db, current_user.id, days=30)