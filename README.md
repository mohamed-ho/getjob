# Get Job

**Get Job** is a Flutter-based application designed to connect job seekers and employers. It provides an efficient platform for employers to post job requirements and communicate directly with potential candidates. The app ensures a seamless and user-friendly experience, featuring secure authentication, real-time chat, and comprehensive job management functionalities.

## Features

### For Employers:
- Post job vacancies with detailed requirements.
- Review applications submitted by job seekers.
- Communicate with applicants via an integrated chat system.

### For Job Seekers:
- Browse and search for job opportunities.
- Apply to jobs by submitting personal information and a CV.
- Chat directly with employers for further discussions.

### General:
- Secure user authentication using Firebase Auth.
- Real-time data management with Firestore.
- File uploads (e.g., CVs) stored securely using Firebase Storage.

## Screenshots
<div>
  <img src = https://github.com/user-attachments/assets/989f48d5-97b3-451e-b293-ac4ed2d58a8b width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/8e6f1ed9-545f-4731-a85a-ee595d7ca39e width = 200 height = 400>
   <img src = https://github.com/user-attachments/assets/3b1579fe-ab49-426e-92bd-b98690b2c49f width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/0e26c005-659b-48c8-8cef-bc8192326b67 width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/702d56d9-36d2-4958-b344-f19e4f0f8bcb width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/bcd49498-eb36-4ad5-8999-b6b557705465 width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/1bc3a54e-d8dc-417e-9128-ab82347dfb6e width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/a43cc3ff-7f6f-4174-b1e0-c2ace31e8e11 width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/824c7bca-131a-42c3-a415-96deb06da761 width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/9a71949f-0ced-46c5-9e04-a83168b92bb6 width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/38b20c69-7be8-4d76-a2d1-2a3e27aa5a80 width = 200 height = 400>
  <img src = https://github.com/user-attachments/assets/e81cfa5a-a8ad-4aa8-957b-063eadb7bc57 width = 200 height = 400>  
</div>

##Demo Video
["get job" demo video](https://drive.google.com/file/d/1qSdgcpsOnj9s_ohzFF4BlN__BfEbDuzR/view?usp=drive_link)

## Tech Stack

- **Flutter**: Frontend framework for building cross-platform applications.
- **Firebase**:
  - Authentication
  - Firestore (Database)
  - Storage (File management)
- **State Management**: Cubit/Bloc architecture for managing application state.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/get-job.git
   ```

2. Navigate to the project directory:
   ```bash
   cd get-job
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Google Play
The app is available on Google Play. [Download here](https://play.google.com/store/apps/details?id=dev.hosny.getjob).

## Folder Structure

```
get-job/
├── lib/
│   ├── config/       
│   ├── core/      
│   └── features/
|   |   └── feature/
|   |   |   ├── data/
|   |   |   |   ├── data source/
|   |   |   |   ├── models/
|   |   |   |   ├── repositories/
|   |   |   ├── domain/
|   |   |   |   ├── entities/
|   |   |   |   ├── repositories/
|   |   |   |   ├── usecases/
|   |   |   ├── presentation/
|   |   |   |   ├── bloc/
|   |   |   |   ├── screens/
|   |   |   |   ├── widgets/
|   |   |   └── feature enjection.dart   
│   |
|   ├── app enjection.dart     
│   └── main.dart
|       
├── assets/           
└── pubspec.yaml      
```


## Contact

For any inquiries or feedback, feel free to contact:

- **Developer**: Mohamed Hosny
- **Email**: [engmohosny110@gmail.com]
- **LinkedIn**: (www.linkedin.com/in/mohamed-hosny-hassan)
