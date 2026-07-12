from fastapi import APIRouter, Depends
from pydantic import BaseModel
from app.database.models import User
from app.utils.auth_dependency import get_current_user

router = APIRouter()


class DietPlanRequest(BaseModel):
    height_cm: float
    weight_kg: float
    activity_level: str  # "sedentary", "light", "moderate", "active", "very_active"
    goal: str  # "maintain", "lose", "gain"


ACTIVITY_MULTIPLIERS = {
    "sedentary": 1.2,
    "light": 1.375,
    "moderate": 1.55,
    "active": 1.725,
    "very_active": 1.9
}

GOAL_ADJUSTMENTS = {
    "maintain": 0,
    "lose": -500,
    "gain": 500
}


@router.post("/diet/calorie-plan")
def calculate_diet_plan(
    data: DietPlanRequest,
    current_user: User = Depends(get_current_user)
):
    age = current_user.age or 25
    gender = (current_user.gender or "male").lower()

    if gender == "male":
        bmr = (10 * data.weight_kg) + (6.25 * data.height_cm) - (5 * age) + 5
    else:
        bmr = (10 * data.weight_kg) + (6.25 * data.height_cm) - (5 * age) - 161

    activity_multiplier = ACTIVITY_MULTIPLIERS.get(data.activity_level, 1.2)
    tdee = bmr * activity_multiplier

    goal_adjustment = GOAL_ADJUSTMENTS.get(data.goal, 0)
    target_calories = tdee + goal_adjustment

    protein_g = round((target_calories * 0.30) / 4, 1)
    carbs_g = round((target_calories * 0.40) / 4, 1)
    fat_g = round((target_calories * 0.30) / 9, 1)

    foods_to_avoid = [
        "Sugary drinks and sodas",
        "Deep-fried foods",
        "Processed/packaged snacks high in trans fats",
        "Excess refined sugar and white bread",
        "Excessive salt/sodium-heavy processed foods"
    ]

    return {
        "bmr": round(bmr, 0),
        "tdee": round(tdee, 0),
        "target_daily_calories": round(target_calories, 0),
        "macros": {
            "protein_g": protein_g,
            "carbs_g": carbs_g,
            "fat_g": fat_g
        },
        "foods_to_avoid": foods_to_avoid,
        "note": "This is a general estimate based on the Mifflin-St Jeor formula. Individual needs vary — consult a nutritionist or doctor for a personalized plan, especially if you have existing health conditions."
    }