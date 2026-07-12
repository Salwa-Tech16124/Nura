Server runs at `http://127.0.0.1:8000`
Interactive API docs: `http://127.0.0.1:8000/docs`

## API Endpoints

### Authentication
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /auth/register | Register new user | No |
| POST | /auth/login | Login, returns JWT | No |
| GET | /auth/profile | Get current user profile | Yes |

### Medicine
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /medicine/ | Add medicine | Yes |
| GET | /medicine/ | List user's medicines | Yes |
| PUT | /medicine/{id} | Update medicine | Yes |
| DELETE | /medicine/{id} | Delete medicine | Yes |

### Health
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /health-log | Add health log | Yes |
| GET | /health-history | Get health log history | Yes |
| PUT | /health-log/{id} | Update health log | Yes |
| DELETE | /health-log/{id} | Delete health log | Yes |

### Appointment
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /appointment | Add appointment | Yes |
| GET | /appointment | List appointments | Yes |
| PUT | /appointment/{id} | Update appointment | Yes |
| DELETE | /appointment/{id} | Delete appointment | Yes |

### Family Member
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /family-member | Add family member | Yes |
| GET | /family-member | List family members | Yes |
| PUT | /family-member/{id} | Update family member | Yes |
| DELETE | /family-member/{id} | Delete family member | Yes |

### SOS
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /sos | Trigger SOS alert | Yes |
| GET | /sos/history | Get SOS history | Yes |

### Reports
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| GET | /weekly-report | 7-day health summary | Yes |
| GET | /monthly-report | 30-day health summary | Yes |

### AI Bridge (stub — pending AI engine integration)
| Method | Endpoint | Description | Auth Required |
|--------|----------|--------------|----------------|
| POST | /ai/chat | Chat with AI assistant | Yes |
| POST | /ai/summary | AI health summary | Yes |
| POST | /ai/report | AI-generated report | Yes |
| POST | /ai/prescription | AI prescription analysis | Yes |
| POST | /ai/risk | AI risk assessment | Yes |

## Database Schema
6 tables: `users`, `medicines`, `health_logs`, `appointments`, `family_members`, `sos_logs`. All child tables reference `users.id` via foreign key. Full schema defined in `app/database/models.py`.

## Authentication Flow
1. User registers via `/auth/register` — password is hashed with bcrypt before storage.
2. User logs in via `/auth/login` — receives a JWT access token (30 min expiry).
3. Protected routes require `Authorization: Bearer <token>` header.
4. `get_current_user` dependency validates the token and injects the authenticated user into the route.
5. All resource endpoints (Medicine, Health, etc.) filter by the authenticated user's ID — users can only access their own data.

## Testing Guide
1. Start the server: `uvicorn app.main:app --reload`
2. Open `http://127.0.0.1:8000/docs`
3. Register a user via `/auth/register`
4. Login via `/auth/login`, copy the `access_token`
5. Click "Authorize" (top right), paste the token
6. Test any protected endpoint directly from the docs UI

## Future Improvements
- Replace AI bridge stubs with real integration once the AI engine module is ready
- Add refresh tokens for longer sessions
- Add pagination to list endpoints (medicine, health history, etc.)
- Add rate limiting on `/auth/login` to prevent brute-force attempts
- Deploy to a cloud provider (Render/Railway) with a managed PostgreSQL instance