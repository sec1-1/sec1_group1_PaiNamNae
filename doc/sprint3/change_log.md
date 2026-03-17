# Changelog

All notable changes to this project will be documented in this file.

The format is based on **Keep a Changelog**, and this project adheres to **Semantic Versioning**.

---

## AI Declaration
Parts of this changelog were drafted with the assistance of an AI language model (GitHub Copilot). All entries were reviewed and edited by the project author for accuracy and completeness.

---

## [Unreleased]

## Admin Report Update & Driver Incident Tracking

### User Stories
1. As an admin, I want to keep the users updated on their reported incidents.
2. As a driver, I want to report incidents to the admin and get the update on the filed case.

---

### Added

#### Driver Incident Report Flow (`frontend/pages/myRoute/index.vue`)
- **Driver report actions and case tracking**
	- Added report action for completed routes so drivers can file incidents directly to admin.
	- Added "ดูสถานะรายงาน" action when a report already exists.
	- Added route-level report state display (e.g., ยังไม่เคยรายงาน, รอการตรวจสอบ, รับเรื่องแล้ว, ไม่พบปัญหา, ดำเนินการแก้ไขแล้ว).

- **Report submission modal**
	- Added incident category selection and description input for driver reports.
	- Added optional passenger selection when reporting `PASSENGER_ISSUE`.
	- Added evidence attachment support for image, video, and audio files.
	- Added optional link attachment with URL format validation.

- **Report status modal**
	- Added report tracking modal showing current status, category, submitted detail, and timestamp.
	- Added admin response area to display follow-up notes and resolved time.
	- Added admin contact guidance for additional incident information.

#### Backend & API Integration (`backend/src/routes/report.routes.js`)
- Added and integrated endpoints used in the driver/admin flow:
	- `POST /api/reports` for submitting incident reports.
	- `GET /api/reports/me` for fetching user's submitted reports and latest status.
	- `GET /api/reports/admin` for admin report management list.
	- `PATCH /api/reports/admin/:id` for updating report status and admin notes.

---

### Changed

#### Admin Report Management UI (`frontend/pages/admin/reports/index.vue`)
- Improved report management workflow for status updates.
- Enhanced status filtering and status badge display for faster triage.
- Improved report detail modal to support better review and follow-up response.

#### Driver Report Validation & UX (`frontend/pages/myRoute/index.vue`)
- Updated validation flow to enforce required fields before submission:
	- At least one category must be selected.
	- Description is required and limited to 501 characters.
	- Passenger must be selected when reporting passenger-related incidents.
- Improved toast error messaging for invalid input and failed submission.
- Updated submit button behavior to prevent invalid submissions.
- Added post-submit state refresh so drivers can immediately see latest case status.

---

### Fixed

#### Report Status Consistency
- Fixed driver-side report status synchronization by refreshing route report state from `GET /api/reports/me`.
- Fixed UI state transitions after report submission so newly submitted cases appear as pending without requiring manual page reload.
