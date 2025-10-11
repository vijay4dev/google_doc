# google_doc

<p align="center">
  <img src="https://user-images.githubusercontent.com/13705472/162619976-6896a508-10b0-444f-84ac-894ada48e18a.gif" alt="Demo GIF" width="600"/>
</p>


Document collaboration app (Flutter client + Node.js server).

This repository contains a Flutter application (frontend) and a small Node.js backend used by the project.

## Project analysis — tech used

- Frontend: Flutter (Dart SDK) app
	- Minimum SDK constraint: Dart SDK ^3.9.0 (see `pubspec.yaml`)
	- State management: Riverpod (`riverpod`, `flutter_riverpod`)
	- Routing: Routemaster (`routemaster`)
	- Rich text editor: Flutter Quill (`flutter_quill`)
	- Authentication: `google_sign_in`, `google_identity_services_web`
	- Networking: `http`
	- Real-time: `socket_io_client`
	- Config: `flutter_dotenv` (loads `assets/.env`)
	- Local storage: `shared_preferences`

- Backend: Node.js (simple Express server in `/server`)
	- Framework: Express
	- Real-time: Socket.IO (`socket.io`)
	- Database: MongoDB via `mongoose`
	- Auth: `jsonwebtoken`
	- HTTP client (server-side): `axios`
	- Dev tooling: `nodemon` (dev dependency)

## Repository layout (important files)

- `lib/` — Flutter source
	- `main.dart` — app entry (loads `assets/.env`, sets up Riverpod and Routemaster)
	- `screens/`, `models/`, `repositry/`, `utils/` — app modules
- `assets/Images/` — app images
- `assets/.env` — app environment variables (loaded by `flutter_dotenv`)
- `server/` — Node.js backend
	- `server/index.js` — server entry (see `server/package.json`)
	- `server/package.json` — server dependencies and scripts

## Prerequisites

- Flutter SDK (compatible with Dart 3.9+). Install from https://flutter.dev
- Node.js (>= 18 recommended) and npm/yarn for the backend
- MongoDB (local or URI to a managed cluster)

## Setup and run

1) Clone the repo and open it:

```bash
cd /path/to/google_doc
```

2) Flutter app: install packages and run

```bash
flutter pub get
# Run on a connected device or simulator
flutter run
```

Notes:
- The app expects an `assets/.env` file. Example keys you may need (create `assets/.env`):

```text
# Example assets/.env (not checked into git)
API_URL=http://localhost:3000
GOOGLE_CLIENT_ID=your-google-client-id
# other keys used by the app
```

3) Backend server: install and run

```bash
cd server
npm install
# for development with auto-reload
npm run dev
# or to start normally
npm start
```

Notes:
- The server likely expects environment variables (create a `.env` in `server/` or set env vars when running):

```text
# Example server/.env
PORT=3000
MONGO_URI=mongodb://localhost:27017/google_doc
JWT_SECRET=some_secret_here
```

## Useful scripts

- Frontend: `flutter pub get`, `flutter run`, `flutter build` as usual
- Backend (inside `server/`):
	- `npm run dev` — runs `nodemon ./index.js`
	- `npm start` — runs `node ./index.js`

## Key dependencies (selected)

- Flutter: `flutter_quill`, `flutter_riverpod`, `google_sign_in`, `socket_io_client`, `flutter_dotenv`, `routemaster`
- Server: `express`, `socket.io`, `mongoose`, `jsonwebtoken`, `axios`, `cors`

## Dependencies — what they're used for

Below is a short mapping of the important packages and what they do in this project.

Frontend (Flutter/Dart)
- `flutter_quill` — rich-text editor widget used for collaborative document editing UI.
- `riverpod`, `flutter_riverpod` — state management (global app state, user data, docs state).
- `routemaster` — declarative routing and route guards (logged-in vs logged-out flows).
- `google_sign_in`, `google_identity_services_web` — Google authentication flows for mobile and web.
- `http` — making REST API calls to the backend.
- `socket_io_client` — Socket.IO client for realtime updates and collaboration.
- `flutter_dotenv` — loads environment variables from `assets/.env` into the app.
- `shared_preferences` — simple local key/value storage for small values (tokens, flags).
- `cupertino_icons` — iOS-style icons used by the UI.

Backend (Node.js)
- `express` — web framework for HTTP endpoints and middleware.
- `socket.io` — realtime bidirectional communication (documents collaboration, presence, cursors).
- `mongoose` — MongoDB object modeling and schema definitions; used for defining models and CRUD operations.
- `mongodb` — official MongoDB driver (sometimes used alongside `mongoose` in a project).
- `jsonwebtoken` — create and verify JWTs for authentication and route protection.
- `axios` — HTTP client used for calling external services/APIs from the server.
- `cors` — enables Cross-Origin Resource Sharing for the API when the client runs on a different origin.
- `nodemon` (devDependency) — restarts the server automatically during development when files change.

If you'd like, I can also add a small code snippet to the README showing a minimal auth middleware implementation (server) and an example of how the Flutter app connects to Socket.IO. Which one would you prefer first?

## Development notes & next steps

- The Flutter app loads environment values from `assets/.env` (see `lib/main.dart`). Keep secrets out of source control.
- The app uses Riverpod for state and Routemaster for route guarding (logged-in vs logged-out). Look at `lib/utils/router.dart` for route definitions.
- The server is a conventional Express app with Socket.IO and MongoDB; check `server/index.js` and the `server/models`/`server/routes` folders to see endpoints and models.

## What I learned

While building this project I learned several backend and realtime concepts while implementing the server and integrating it with the Flutter client:

- Node.js & Express: how to structure a small Express server, create routes, and organize middleware.
- Auth middleware: how to implement authentication middleware using JSON Web Tokens (`jsonwebtoken`) to protect routes and extract user info.
- MongoDB & Mongoose: connecting to MongoDB, defining schemas/models with Mongoose, and performing basic CRUD used by the app.
- Sockets (Socket.IO): how to set up Socket.IO on the server and use `socket_io_client` in the Flutter app to enable realtime collaboration features.

These learnings helped me wire authentication, persistence, and realtime collaboration between the Flutter frontend and the Node.js backend.

## Contact / Help

If you want, I can:

- Add a sample `.env` template file for both client and server (without secrets)
- Add a short CONTRIBUTING or DEVELOPMENT.md with step-by-step setup for new contributors
- Run a quick smoke test (flutter analyze / dart format / npm test) and report issues

Requirements coverage:

- Analyze project tech: Done (listed above)
- Update `README.md`: Done (this file)

---
Generated on: 2025-10-11
