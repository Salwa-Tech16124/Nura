import os
from google import genai
from google.genai import types
from dotenv import load_dotenv

load_dotenv()

_client = None

def _get_client():
    global _client
    if _client is None:
        api_key = os.getenv("GEMINI_API_KEY")
        if not api_key:
            api_key = "DUMMY_GEMINI_API_KEY"
        _client = genai.Client(api_key=api_key)
    return _client

def analyze_medicine_photo(image_bytes: bytes, user_age: int | None) -> str:
    age_context = f"The user is {user_age} years old." if user_age else "The user's age is unknown."

    prompt = f"""You are a medical information assistant. Look at this photo of a medicine/pill/package.

{age_context}

Provide:
1. The likely medicine name (say "Unable to identify" if unclear — do not guess confidently on a blurry or unclear image)
2. What it's commonly used for
3. General dosage guidance appropriate for the user's age, if identifiable
4. Any important warnings

Keep it concise. Always end by reminding the user to confirm with a doctor or pharmacist before taking anything — this is guidance, not a prescription."""

    response = _get_client().models.generate_content(
        model="gemini-flash-latest",
        contents=[
            types.Part.from_bytes(data=image_bytes, mime_type="image/jpeg"),
            prompt
        ]
    )

import json


def analyze_report_document(file_bytes: bytes, mime_type: str) -> dict:
    prompt = """You are analyzing a medical lab report or document (image or PDF).

Extract the information and respond with ONLY a valid JSON object (no markdown, no backticks, no preamble) in this exact shape:

{
  "raw_text": "<full extracted text from the document, as accurately as possible>",
  "structured_data": {
    "report_type": "<e.g. Blood Test, X-Ray, Prescription, etc>",
    "test_results": {"<test name>": "<value with unit and normal/abnormal flag if visible>"},
    "summary": "<one sentence plain-language summary of key findings>"
  },
  "report_date": "<date found on the document in YYYY-MM-DD format, or null if not found>"
}

If a field can't be determined, use null. Do not guess medical values you can't clearly read."""

    response = _get_client().models.generate_content(
        model="gemini-flash-latest",
        contents=[
            types.Part.from_bytes(data=file_bytes, mime_type=mime_type),
            prompt
        ]
    )
    raw = response.text.strip()
    # Strip markdown code fences if the model added them anyway
    if raw.startswith("```"):
        raw = raw.split("```")[1]
        if raw.startswith("json"):
            raw = raw[4:]
        raw = raw.strip()

    try:
        parsed = json.loads(raw)
    except (json.JSONDecodeError, ValueError):
        # Fallback: model didn't return clean JSON — keep the raw text, no structured data
        parsed = {"raw_text": response.text, "structured_data": None, "report_date": None}

    return parsed


def ask_with_context(context: str, question: str) -> str:
    prompt = f"""You are a personal health assistant AI. You have access to this user's health history timeline below. Use it to answer their question accurately and helpfully. If the timeline doesn't contain relevant information, say so honestly rather than guessing.

HEALTH TIMELINE:
{context}

USER QUESTION:
{question}

Answer clearly and concisely. Always remind the user to consult a doctor for medical decisions, not just rely on this summary."""

    response = _get_client().models.generate_content(
        model="gemini-flash-latest",
        contents=[prompt]
    )
    return response.text