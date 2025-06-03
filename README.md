
# 📱 Okwomi Connect

A private cross-platform family app built for The Okwomi’s Family. It enables secure contribution tracking, event planning, member communication, and family heritage preservation.

## 🔍 Features

- 💰 Monthly and one-time contribution tracking
- 🔗 Link contributions to stories or events
- 📇 Member directory with admin approval
- 📢 Broadcast SMS & WhatsApp via admin’s device
- 📆 Event management with RSVP
- 📝 Family stories and tributes archive
- 📂 Upload and search past meeting minutes

## 🛠️ Tech Stack

- **Flutter** – Frontend (iOS + Android)
- **Firebase** – Auth, Firestore, Cloud Storage
- **Local SMS/WhatsApp** – Admin-triggered messaging (no API)

## 👥 User Roles

| Role               | Responsibilities                                   |
|--------------------|----------------------------------------------------|
| Chairman           | Full control, user approvals, role assignment      |
| Secretary          | Member updates, minutes, stories                   |
| Treasurer          | Contributions & monthly tracking                   |
| Organizing Sec.    | Event planning and attendance tracking             |
| Member             | View content, RSVP, submit tributes                |

## 📁 Folder Structure

```
okwomi-connect/
├── lib/
│   ├── models/         # Dart data models
│   ├── screens/        # UI Screens
│   ├── services/       # Firebase & utilities
│   ├── widgets/        # Shared components
│   └── utils/          # Helpers and constants
├── firebase/
│   ├── firestore.rules # Security rules
│   └── cloud_functions/
├── docs/
│   └── ProjectOverview.md
├── assets/
│   ├── images/
│   └── icons/
├── pubspec.yaml
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.10+ recommended)
- Firebase project with Auth, Firestore & Storage configured

### Installation

```bash
git clone https://github.com/yourusername/okwomi-connect.git
cd okwomi-connect
flutter pub get
flutter run
```

## 🔐 Authentication

- Phone-based login with Firebase Auth
- Role-based dashboard access
- Admins approve and assign roles

## 📦 Dependencies (Sample)

```yaml
dependencies:
  flutter:
  cloud_firestore:
  firebase_auth:
  firebase_storage:
  flutter_local_notifications:
  url_launcher:
  intl:
```

## ✅ To Do

- [ ] Implement full contribution dashboard
- [ ] Integrate event RSVP tracking
- [ ] Upload & view minutes feature
- [ ] Push notification support (optional)
- [ ] Deployment to Play Store / App Store

## 📃 License

MIT © Zephania Mwando
