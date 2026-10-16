# SafeGuard Pro — API Contract (Worker App)

**Base URL:** `http://localhost:5000`
**Content-Type:** `application/json`

---

## 1. Start Session (Register Worker at Shift Start)

```
POST /api/session/start
```

**Request Body:**
```json
{
  "worker_name": "Ahmed Mohamed",
  "worker_id": "W001",
  "zone": "Floor 10 - Zone A",
  "device_id": "GW6-001"
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `worker_name` | string | Yes | Worker's full name |
| `worker_id` | string | Yes | Worker ID number |
| `zone` | string | Yes | Selected work zone/location |
| `device_id` | string | Yes | Paired smartwatch device ID |

**Success Response (201):**
```json
{
  "message": "Session started successfully",
  "session_id": 1,
  "worker_name": "Ahmed Mohamed",
  "zone": "Floor 10 - Zone A"
}
```

**Error Response (400):**
```json
{
  "error": "Field 'worker_id' is required"
}
```

---

## 2. End Session (End Worker Shift)

```
POST /api/session/end
```

**Request Body (Option A — by worker_id):**
```json
{
  "worker_id": "W001"
}
```

**Request Body (Option B — by session_id):**
```json
{
  "session_id": 1
}
```

**Success Response (200):**
```json
{
  "message": "Session ended successfully"
}
```

**Error Response (404):**
```json
{
  "error": "No active session found"
}
```

---

## 3. Vitals (For Reference — Sent by Smartwatch, NOT Worker App)

```
POST /api/vitals
```

The smartwatch (Kotlin app) sends data directly to the backend:
```json
{
  "device_id": "GW6-001",
  "heart_rate": 75,
  "spo2": 98,
  "skin_temp": 36.5
}
```

---

**Note:** The Worker App only uses endpoints #1 and #2. The rest (vitals, alerts, workers/status, incidents) are used by the smartwatch and the supervisor dashboard.
