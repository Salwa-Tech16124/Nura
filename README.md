# <img src="docs/images/nura_banner.png" width="100%" alt="NURA - AI Health Copilot" />

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![Gemini](https://img.shields.io/badge/Google_Gemini-8E75C2?style=for-the-badge&logo=google&logoColor=white)](https://deepmind.google/technologies/gemini/)

<h3>🤖 AI-Powered Health Copilot & Voice Care Companion for Seniors</h3>

*Empowering elderly independence while delivering real-time peace of mind to families & caregivers.*
</div>

---

## 📖 Project Vision

**NURA** translates complex, fragmented health data into a simple, chronological, and easy-to-read **AI Health Timeline**. Built with an **elder-friendly Neobrutalist design system**, NURA stands out as a voice-enabled care companion. It actively listens to patient symptoms, organizes medication routines, parses prescriptions via OCR, and triggers immediate Emergency SOS responses with location tracking.

---

## 🏗️ System Architecture & Data Flow

Our system uses a modern, highly secure, and decoupled backend-frontend architecture:

<img src="docs/images/nura_arch_diagram.png" width="100%" alt="NURA System Architecture" />

---

## 🚀 Core Features Showcase

<img src="docs/images/nura_features.png" width="100%" alt="NURA Key Features" />

### 1. 📅 AI Health Timeline
*   **Dynamic Chronicle:** Captures vitals logs (Heart Rate, BP, Blood Sugar, Temperature, Water intake), medication schedules, and clinical report uploads in a single stream.
*   **AI Insight Cards:** Automatically generates daily health summaries and daily wellness tips using Google Gemini.

### 2. 💊 Smart Medication & OCR Scan
*   **Adherence Tracker:** Simple checkboxes to mark medicines as taken/skipped.
*   **Prescription Scanner:** Elder-friendly camera view allowing users to scan prescription papers to extract medication details using advanced OCR.

### 3. 🎙️ Voice AI Companion ("Ask NURA")
*   **Ambient Mic Interface:** Orbit-mic animation with listening pulse waves.
*   **Smart Suggestions:** Quick cards like *"Explain my medications"* or *"Summarize my vitals"* to minimize typing.

### 4. 🔊 Interactive High-Fidelity Audio
*   Integrated audio indicators powered by `audioplayers` that respond dynamically to screens (Startup chimes, Button tap clicks, SOS countdown beeps, Voice connect clips).

### 5. 🚨 One-Tap Emergency SOS
*   Initiates an immediate 3-second warnings countdown, broadcasts location coordinates, and alerts emergency caregivers.

---

## 🛠️ Technology Stack

| Layer | Component | Tech Stack | Style / Details |
| :--- | :--- | :--- | :--- |
| **Frontend** | Mobile/Web App | `Flutter 3.x (Dart)` | **Neobrutalist UI** (Thick borders, `#E8F1F5` Sky, `#FED782` Yellow) |
| **State** | State Management | `Riverpod 2.x` | Strongly typed, compile-time safe, decoupled providers |
| **Routing** | Navigation Routing | `GoRouter 13.x` | Nested routing, deep linking, auth-guarded redirects |
| **Network** | REST Client | `Dio 5.x` | Base client singleton, JSON interceptor, auto-JWT authorization header |
| **Backend** | API Server | `FastAPI (Python 3.11)` | Fast, structured endpoints, auto OpenAPI docs, Async PG |
| **Database** | Database Engine | `PostgreSQL 15+` | Relational schema with cascading foreign keys for secure accounts |
| **AI Intelligence** | Large Language Model | `Gemini Pro 1.5` | Vitals trend analysis, clinical prescription OCR parsing |

---

## 📦 Directory Structure

```text
nura/
├── backend/                   # FastAPI Web Server, APIs & SQL Models
│   ├── app/
│   │   ├── database/          # Database models, connections, and table schemas
│   │   ├── routers/           # Controller endpoints (auth, medicine, health, SOS, reports)
│   │   ├── services/          # Gemini AI services, JWT helpers, OCR processors
│   │   └── main.py            # FastAPI entrypoint configuration
│   ├── requirements.txt       # Python dependencies
│   └── init_db.py             # Database table initialization script
├── database/                  # Schema seeding, queries, and raw migrations
├── docs/                      # UI Mockups, API specifications, and architecture diagrams
└── frontend/                  # Flutter Multi-Platform App
    ├── assets/                # Audio files (alerts/startup) and image branding
    ├── lib/
    │   ├── core/              # Theme details, centralized API Constants, space layout tokens
    │   ├── models/            # Vitals, User, Medicine, Report, ChatMessage strongly-typed models
    │   ├── providers/         # Riverpod providers for asynchronous API bindings
    │   ├── screens/           # Onboarding, Login, Medication, Reports, SOS, AI screens
    │   └── services/          # HTTP service client layers (Auth, Health, Meds, OCR, Reports)
```

---

## 🔌 API Endpoints Reference

All endpoints automatically attach the `Authorization: Bearer <JWT>` header via our central `ApiClient` wrapper once the user logs in.

### 🔑 Authentication Service
| Method | Endpoint | Description | Public / Private |
| :---: | :--- | :--- | :---: |
| <kbd>POST</kbd> | `/auth/register` | Register a new account (hashes password with bcrypt) | **Public** |
| <kbd>POST</kbd> | `/auth/login` | Login credentials validation, returns JWT access token | **Public** |
| <kbd>GET</kbd> | `/auth/profile` | Retrieves current logged-in user profile details | **Private** |

### 💊 Medication Service
| Method | Endpoint | Description | Public / Private |
| :---: | :--- | :--- | :---: |
| <kbd>GET</kbd> | `/medicine/` | Fetch list of all active medications for current user | **Private** |
| <kbd>POST</kbd> | `/medicine/` | Add a new medication (dosage, timing, frequency) | **Private** |
| <kbd>PUT</kbd> | `/medicine/{id}` | Update details of an existing medication | **Private** |
| <kbd>DELETE</kbd> | `/medicine/{id}` | Delete/remove a medication from user schedule | **Private** |

### 📊 Health Vitals Service
| Method | Endpoint | Description | Public / Private |
| :---: | :--- | :--- | :---: |
| <kbd>GET</kbd> | `/health-history` | Fetch historical list of logged vitals/symptoms | **Private** |
| <kbd>POST</kbd> | `/health-log` | Log heart rate, BP, sugar, temperature, or water intake | **Private** |
| <kbd>DELETE</kbd> | `/health-log/{id}` | Delete a specific vitals history log entry | **Private** |

### 🤖 AI Companion & Reports
| Method | Endpoint | Description | Public / Private |
| :---: | :--- | :--- | :---: |
| <kbd>POST</kbd> | `/ai/chat` | Query voice/text companion (processes context via LLM) | **Private** |
| <kbd>POST</kbd> | `/ai/prescription` | Analyze uploaded prescription images via Gemini OCR | **Private** |
| <kbd>GET</kbd> | `/weekly-report` | Generates 7-day health trend summary and scores | **Private** |
| <kbd>GET</kbd> | `/monthly-report` | Generates 30-day health trend summary and scores | **Private** |

---

## ⚙️ Installation & Setup Instructions

### 1. Prerequisite Environment Variables
Create a `.env` file inside the `backend/` directory matching the variables from [backend/.env.example](file:///S:/Nura-Backend/backend/.env.example):
```env
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/ai_care_copilot
SECRET_KEY=your_jwt_secret_key_here
GEMINI_API_KEY=your_gemini_api_key_here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

---

### 2. Backend Server Setup (FastAPI)
Navigate to the backend directory, activate a virtual environment, install dependencies, initialize the database tables, and run the hot-reload server:

```powershell
# Navigate to backend
cd backend

# Create & activate virtual environment (Windows)
python -m venv .venv
.venv\Scripts\activate

# Install requirements
pip install -r requirements.txt

# Initialize tables in Postgres database
python init_db.py

# Launch local FastAPI server
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```
* Once running, interactive Swagger API docs are available at **`http://localhost:8000/docs`**

---

### 3. Exposing Server to Mobile/Web (ngrok)
To allow your web app, local browser, or mobile emulator to hit the backend without CORS or localhost resolution issues, run ngrok:
```bash
ngrok http 8000
```
Copy the secure forwarding URL (e.g., `https://ceroplastic-evaluative-emeline.ngrok-free.dev`) and update [api_constants.dart](file:///S:/Nura-Backend/frontend/lib/core/constants/api_constants.dart):
```dart
static const String baseUrl = 'https://ceroplastic-evaluative-emeline.ngrok-free.dev';
```

---

### 4. Frontend Application Setup (Flutter)
Ensure you have the Flutter SDK configured. Clean the project and launch it on your chosen device:

```powershell
# Navigate to frontend
cd S:\Nura-Backend\frontend

# Clean build caches (highly recommended for web)
flutter clean

# Get Dart packages
flutter pub get

# Run on Chrome
flutter run -d chrome
```

---

## 💡 Flutter Web Cache Warning!
> [!WARNING]
> Chrome aggressively caches the Flutter Web application's `flutter_service_worker.js` and compiled JS assets.
> If you launch the app and see an older screen/behavior, execute the following:
> 1. Open Chrome DevTools (`F12` or `Ctrl + Shift + I`).
> 2. Go to the **Application** tab -> **Storage** section on the left sidebar.
> 3. Click **Clear Site Data** to wipe out cached service workers and databases.
> 4. Perform a hard refresh using **`Ctrl + Shift + R`** or **`Shift + F5`**.

---

## 👥 Developers & Collaborators
*   **Salwa:** Frontend Developer (Flutter Multiplatform & Neobrutalist UI)
*   **Tarun:** Backend Developer (FastAPI Server, JWT Auth, Database Relational Schemas)
*   **Deepti:** AI/ML Engineer (Google Gemini API & Vitals Summarization)
*   **Arpit:** UI/UX Designer & Systems Deployment

---
*Created with ❤️ by the NURA Development Team.*
