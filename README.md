# NURA - AI-Powered Care Copilot

## Project Overview
NURA is an AI-powered Care Copilot designed to help elderly users manage their daily healthcare through AI-assisted health monitoring, medication reminders, voice interaction, emergency support, and personalized health insights.

## Problem Statement
Elderly individuals often struggle with managing complex medication schedules, tracking daily wellness, and accessing immediate help during emergencies. Existing solutions are often fragmented, difficult to navigate, and lack empathetic, intelligent assistance tailored to seniors.

## Solution
NURA bridges this gap by providing an intuitive, voice-enabled Flutter mobile application powered by an intelligent FastAPI backend and an advanced AI Engine. It acts as a 24/7 personalized care companion, simplifying healthcare management and providing peace of mind to both users and their families.

## Core Features
1. **AI Health Assistant**: Conversational AI for health queries and guidance.
2. **Medication Reminder**: Smart scheduling, notifications, and adherence tracking.
3. **Voice Assistant**: Hands-free navigation and interaction tailored for accessibility.
4. **Emergency SOS**: One-tap emergency alerts to caregivers and services.
5. **AI Doctor Report**: Automated summarization of daily wellness and health metrics for doctors.
6. **Daily Wellness Check-in**: Routine logging of mood, vitals, and symptoms.

## System Architecture
NURA follows a strict microservices-inspired architecture ensuring separation of concerns:
- **Frontend (Flutter)**: Handles UI/UX and user interaction. Never communicates with the database or AI directly.
- **Backend (FastAPI)**: Acts as the central orchestrator and REST API gateway.
- **Database (PostgreSQL)**: Manages structured relational data (users, logs, schedules).
- **AI Engine**: A dedicated service for natural language processing, insights, and report generation.

[Read detailed Architecture Documentation](docs/architecture.md)

## Repository Structure
```
nura/
├── ai-engine/           # AI models, NLP processing, and prompt engineering
├── assets/              # Shared assets (images, fonts, icons)
├── backend/             # FastAPI application and routing logic
├── database/            # PostgreSQL schemas, migrations, and seed data
├── demo-video/          # Project demonstration recordings
├── docs/                # Developer documentation, guidelines, and API specs
├── frontend/            # Flutter mobile application
│   └── lib/             # Frontend source code (core, screens, widgets, etc.)
├── postman/             # API collections for testing
├── presentation/        # Hackathon pitch deck and assets
├── .gitignore           # Git ignore rules
├── LICENSE              # Project license
└── README.md            # Project overview and setup instructions
```

## Installation
*(Detailed installation instructions will be added as modules are developed. General steps below.)*

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd nura
   ```

2. **Frontend Setup:**
   ```bash
   cd frontend
   flutter pub get
   ```

3. **Backend Setup:**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

4. **Database:**
   Ensure PostgreSQL is running and apply necessary schema migrations found in `database/`.

## Project Workflow & Development Guidelines
This is a collaborative hackathon project. To ensure smooth integration:
- **Git Strategy**: Follow the established [Git Branch Workflow](docs/git_workflow.md).
- **Coding Standards**: Adhere to the [Flutter Coding Standards](docs/coding_standards.md).
- **Module Integration**: Review the [Developer Guide](docs/developer_guide.md) before adding new modules.

## Team Members
1. **Salwa** - Frontend Developer (Flutter)
2. **Tarun** - Backend Developer (FastAPI + PostgreSQL)
3. **Deepti** - AI/ML Engineer
4. **Arpit** - UI/UX Designer, Documentation & Deployment

## Future Scope
- Wearable integration (Smartwatches, IoT health devices)
- Multilingual voice support for diverse elderly populations
- Family portal for remote monitoring and caregiver alerts

## License
MIT License
