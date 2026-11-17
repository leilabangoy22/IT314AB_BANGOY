# BangoySMS Flutter + Neon integration update

## What is included
- Student API CRUD with safer update validation and clearer database errors.
- Generic CRUD endpoints for the existing `Programs`, `Subject`, `Schedule`, `Enrollment`, `Students`, and `grades` tables.
- Flutter `Enrollment Database Modules` screen to add, view, edit, and delete records for Subjects, Schedules, Enrollments, and Grades, plus Programs.
- A shortcut from the Student List app bar to the database modules.
- Uses the existing Neon database configured by `backend/backend.env`; do not create a new database.

## Install
1. Back up your current project first.
2. Copy `main.dart`, `student_list_screen.dart`, `student_details_screen.dart`, `add_student_screen.dart`, `api_service.dart`, and `database_modules_screen.dart` into your Flutter `lib` folder.
3. Copy `server.js` into the existing `backend` folder. Keep your existing `backend.env` private and unchanged.
4. Make sure backend dependencies are installed in `backend`: `npm install express cors pg dotenv`.
5. Start the API from the backend folder with `node server.js`.
6. From the Flutter project root run `flutter pub get`, then `flutter run -d chrome`.
7. Open Student List and tap the database/storage icon to access the other modules.

## Important notes
- API uses `http://localhost:3000/api` for a Flutter app running on the same Windows computer.
- Primary keys have no defaults in the supplied schema, so the API allocates the next integer ID under a PostgreSQL advisory lock. If multiple clients create records concurrently, consider adding identity/sequence defaults through a planned migration later, not as part of this code replacement.
- For foreign keys, type an existing related ID. The backend returns an error if the selected ID does not exist or a related row prevents deletion.
- The supplied column listing does not include primary-key, foreign-key, unique, or check constraints. Verify those constraints before considering the assignment finished. This package does not alter your schema or invent missing constraints.
- The module screen uses your actual Grades columns: `student_id`, `subject`, `score`, `enrollment_id`, `remarks`, `date_recorded`. It does not silently replace them with a different schema.
- This package is a practical integration step, not proof that every rubric item is complete. The final submission still needs the ERD/data dictionary and tests for all business rules, including duplicate enrollment and schedule conflicts.
