
# 📘 Project Overview – Okwomi Connect

## 📛 App Name: Okwomi Connect
A mobile-first app for The Okwomi’s Family to manage contributions, communication, events, and heritage.

## 🧩 Core Features

### 1. 💰 Contribution Tracker
- Log one-time or recurring contributions
- Track by event, story/tribute, and month
- Link contributions to events or stories
- Monthly dashboard with export (PDF/Excel)
- Admin manually notifies members via SMS/WhatsApp

### 2. 📇 Member Directory
- Editable profiles with contact & family info
- Admin approval workflow
- Search/filter members
- Optional family line tagging

### 3. 📢 Messaging (via Admin's Phone)
- Admins select recipients and compose message
- Launches native SMS or WhatsApp with prefilled data
- No third-party API integration

### 4. 📆 Event Management
- Create, manage and RSVP to events
- Link contributions
- Event reminders and RSVP list export

### 5. 📝 Stories & Tributes
- Submit and approve family stories
- Link stories to causes
- Public/private visibility

### 6. 📂 Meeting Minutes Archive
- Upload and categorize PDFs or Word docs
- Editable by Secretary only
- Searchable archive for members

## 🔐 User Roles

| Role                 | Access Rights                                                                 |
|----------------------|-------------------------------------------------------------------------------|
| Chairman             | Full access, manage users/roles                                               |
| Secretary            | Manage profiles, minutes, stories                                             |
| Treasurer            | Manage contributions, track dues                                              |
| Organizing Secretary | Handle event logistics and RSVPs                                              |
| Member               | View content, RSVP, submit stories                                            |

## 🔄 App Workflows

### Registration
- User registers → Admin approves → Role assigned

### Contributions
- Treasurer logs contributions → Links to story/event → Tracks monthly status

### Messaging
- Admin selects group → Prefills SMS/WhatsApp → Sends manually via device

### Events
- Admin creates → Members RSVP → Admin exports attendance

### Stories
- Member submits → Secretary approves → Story published

### Meeting Minutes
- Secretary uploads → Members view

## ⚙️ Architecture

- **Frontend**: Flutter + Riverpod/Provider
- **Backend**: Firebase Firestore, Auth, Storage
- **Messaging**: Native device interaction (no API)
- **Cloud Functions**: Optional background tasks

## 🗃️ Firestore Schema (Simplified)

```
users/
  {userId} -> name, phone, role, approved

contributions/
  {contributionId} -> userId, amount, date, type, linkedTo, month

events/
  {eventId} -> title, date, rsvpList, contributions

stories/
  {storyId} -> title, content, isPublic, contributionRefs

minutes/
  {minuteId} -> title, fileUrl, date, uploadedBy
```

## 📁 Repo Structure

```
okwomi-connect/
├── README.md
├── lib/
├── firebase/
├── assets/
├── docs/
│   └── ProjectOverview.md
```

## ✅ MVP Timeline

| Week | Milestone |
|------|-----------|
| 1    | Firebase setup, login |
| 2    | Member directory |
| 3    | Contributions |
| 4    | Monthly dashboard |
| 5    | Events + RSVP |
| 6    | Manual messaging |
| 7    | Stories + Minutes |
| 8    | QA and deploy |

---

## 🚀 GitHub Import Guide

1. Create a new repo at: https://github.com/new
2. Clone it locally:
   ```bash
   git clone https://github.com/yourusername/okwomi-connect.git
   cd okwomi-connect
   ```
3. Copy this `ProjectOverview.md` file to `docs/`
4. Add, commit, and push:
   ```bash
   git add .
   git commit -m "Initial commit with project overview"
   git push origin main
   ```

You're ready to start building 🚀
