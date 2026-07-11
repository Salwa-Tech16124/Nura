# 🌟 NURA — AI Health Copilot & Care Companion

NURA is a state-of-the-art, AI-powered health assistant designed specifically to empower seniors to manage their daily healthcare independently, while providing absolute peace of mind to their families and caregivers.

---

## 📖 Project Vision

NURA translates complex, fragmented health data into one chronological, easy-to-read **AI Health Timeline**. 
It stands out as a voice-enabled care companion, listening to patient symptoms, organizing medication routines, scanning prescriptions via OCR, and triggering immediate Emergency SOS responses when needed.

---

## 🛠️ Technology Stack

NURA utilizes a secure, modern, and highly scalable decoupled stack:
*   **Mobile App (Frontend):** Flutter (Dart) — Multiplatform, high-contrast neobrutalist elder-friendly UI.
*   **Gateway Orchestrator (Backend):** FastAPI (Python) — Fast, structured REST endpoints.
*   **Database:** PostgreSQL — Secure relational storage for vitals logs, user credentials, and medicine data.
*   **Intelligence:** Dedicated AI Engine — Natural language queries, report formatting, and prescription parsing.

---

## 📦 Directory Structure

```text
nura/
├── ai-engine/                # LLM prompts, clinical summaries, and OCR parsing models
├── backend/                  # FastAPI web server, routes, and DB models
├── database/                 # PostgreSQL schemas, migrations, and seed scripts
├── docs/                     # API specification, git workflows, and dev guidelines
└── frontend/                 # Flutter mobile application
    ├── assets/               # Image branding and high-fidelity sound effects
    │   └── audio/            # Sound beeps, alerts, voice guide connectors, and connect clips
    └── lib/
        ├── core/             # Central route mapping, app themes, constants
        ├── models/           # Strongly typed data models for JSON parsing
        ├── screens/          # UI modules (Home, Wellness Timeline, Profile, SOS)
        └── widgets/          # Animated voice waves, neobrutalist cards, customized buttons
```

---

## 🚀 Core Features & Experience

### 1. AI Health Timeline (Primary Interface)
A chronological timeline capturing the user’s healthcare updates, designed with neobrutalist cards:
*   **Report Uploaded & OCR Scans:** Displays analyzed details from prescription uploads.
*   **Medicine Started & Taken:** Interactive tracking of drug compliance.
*   **Vitals Logs & Symptoms:** Chronological updates for Heart Rate, BP, Blood Sugar, Temperature, and Water.
*   **AI Insight Card:** Auto-generated wellness guides.
*   **Doctor Summary:** Exportable clinical summaries for physician consults.

### 2. Medication Management & OCR Scan
An elder-friendly medicine scheduler displaying daily adherence. Includes a custom **prescriptions camera/upload scanner** simulating optical character recognition (OCR) and verifying scanned names, patient details, and dosages with 98%+ confidence.

### 3. Voice AI & "Ask NURA" Companion
Accessible from every primary page via a global, floating voice companion button (**"Ask NURA"**). It features a smooth breathing scale animation, glowing pulses, and tactile haptic-shrink scale transitions.
*   **Voice Standby Screen:** Interactive orbital-mic UI with listening indicators.
*   **Voice Suggestion Cards:** Quick queries such as *"Explain my medicines"* or *"Summarize my latest report"*.

### 4. Interactive High-Fidelity Audio Experience
Fully integrated audio indicators powered by `audioplayers` that respond dynamically to screens and actions:
*   **Startup Sound:** Plays `startup.mp3` once during the Splash screen animation.
*   **Button Taps:** Reusable click sound triggers BEFORE the onPressed callbacks in `PrimaryButton`, `SecondaryButton`, `OutlinedButtonWidget`, and `DangerButton`.
*   **Reminders:** Automatic entry chime in the Medication Reminder Notification screen (`notification.mp3`).
*   **SOS Activation:** Interactive countdown beep synchronization (`countdown_beep.mp3`) and success chiming (`success.mp3`).
*   **Voice Assistant:** Sound indicators mapping mic starts (`mic_start.mp3`), listening triggers (`listening.mp3`), voice guides (`voice_play.mp3`), call connections (`call_connect.mp3`), and disconnect cleanups (`call_end.mp3`).

### 5. Emergency SOS
One-tap activation screen initiating a 3-second warnings countdown. Shows real-time location transmitting grids and alerts emergency services and caregivers instantly.

---

## 🎨 Design System & Theming

NURA is crafted with a high-contrast **Neobrutalist Design System** engineered for accessibility:
*   **Elder-friendly typography:** Bold layout structures, large high-contrast fonts, and clear touch targets.
*   **Color Theme:** Consistent light sky-blue background (`#E8F1F5`) combined with neobrutalist pastel accents (Lilac, Pink, Yellow, Cyan, Green) and solid black borders (`width: 1.8`, `offset: Offset(2, 4)` shadow depth).

---

## 🏗️ Architecture & State Management

The frontend codebase is decoupled using **Clean Architecture** patterns:
*   **Presentation Layer:** Standardized screen and widget segments completely isolated from backend endpoints.
*   **State Management:** Powered by **Riverpod** for robust, compile-time safe, and context-independent data flow.
*   **Routing:** Managed centrally using **GoRouter** to enable deep linking, tab branching, and nested view routing.

---

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/Salwa-Tech16124/Nura.git
cd nura
```

### 2. Setup the Flutter Frontend
```bash
cd frontend
flutter pub get
flutter run -d chrome  # or run on connected mobile emulator
```
*(Make sure sound files are present in `assets/audio/` to hear audio effects).*

### 3. Setup the FastAPI Backend
```bash
cd backend
python -m venv venv
# Activate virtual environment (Windows: venv\Scripts\activate, Linux/macOS: source venv/bin/activate)
pip install -r requirements.txt
uvicorn main:app --reload
```

### 4. Database Setup
Ensure PostgreSQL is active on your device. Configure the credentials inside your backend configuration environment and execute sql migration scripts found in `database/`.

---

## 👥 Team Members

*   **Salwa:** Frontend Developer (Flutter)
*   **Tarun:** Backend Developer (FastAPI + PostgreSQL)
*   **Deepti:** AI/ML Engineer
*   **Arpit:** UI/UX Designer, Documentation & Deployment

---

## 📄 License

This project is licensed under the MIT License.
