# 📚 GrowMind – E-Learning App

GrowMind is a full-featured e-learning platform built using Flutter. It empowers users to learn from tutors, enables tutors to manage content, and provides an admin interface for overseeing the platform. The app supports video-based courses, secure payments, chat functionality, and role-based access.

---

## 🚀 Features

### 👨‍🎓 User
- Browse and purchase courses
- Watch video content
- Chat with tutors
- Track learning progress

### 👩‍🏫 Tutor
- Upload and manage courses
- Edit profile and UPI payment details
- Communicate with students

### 🧑‍💼 Admin (Web)
- Approve tutors and courses
- Manage platform-wide data and access

---

## 🧱 Architecture

The app follows **Clean Architecture** with **BLoC State Management**, structured into:

- **Presentation Layer**: Flutter UI + Bloc logic
- **Domain Layer**: Entities and Use Cases (pure Dart)
- **Data Layer**: Firebase service integration and repositories

This separation ensures maintainability, testability, and scalability.
