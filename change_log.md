# Changelog

All notable changes to this project will be documented in this file.

The format is based on **Keep a Changelog**

### AI Declaration
Parts of this changelog text were drafted with the assistance of an AI language model (Gemini 3 Pro).
All entries were reviewed and edited by the project author for accuracy and completeness.

### Added

#### Admin Features (Ban User)
- **Ban User feature (Admin)**
  - Created `frontend/components/BanUserModal.vue` to allow admins to select a suspension reason.
  - Added a **Ban** icon/button to the user management table in `frontend/pages/admin/users/index.vue`.
  - Implemented modal flow + logic to suspend users via the backend.
  - Added a confirmation step to prevent accidental suspensions.
  - Added a success confirmation step to notify admins after a successful suspension.
  - Updated the user table to show a **Suspended** badge in the **Verification** column for banned users.
  - Added an **Unban** (check) icon in the **Actions** column for banned users to reactivate them quickly.

- **Unban User modal (Admin)**
  - Created `frontend/components/UnbanUserModal.vue` for user reactivation.
  - Implemented a 2-step flow (**Confirm → Success**) to match the ban UX and reduce accidental actions.

#### User & Driver Features (Review System)
- **User to Driver Review System**: 
  - Implemented a review submission interface in `frontend/pages/myTrip/index.vue`.
  - Users can now rate drivers (1-5 stars) after a trip is marked as "completed".
  - Support for review tags (e.g., "Polite Driver", "Clean Car", "Safe Driving").
  - Added text comment and image upload capabilities for detailed feedback.

- **Driver Review History Display**:
  - Added a review modal in `frontend/pages/findTrip/index.vue` and `frontend/pages/myTrip/index.vue`.
  - Clicking on a driver's profile now opens their review history.
  - Displays average rating, valid review count, and individual review details (reviewer name, date, comment, tags, images).
  - Added filtering functionality to view reviews by specific tags.

#### Backend & API (Ginny421)
- Add review system (Frontend & Backend)
- Add create review API
- Add review summary API (average, total, distribution)
- Add review tag categories
- Add review image upload (Cloudinary integration)
- Add duplicate review prevention
- Add review filter by tag
- `.env` add `NUXT_PUBLIC_CLOUDINARY_CLOUD=xxxxx`, `NUXT_PUBLIC_CLOUDINARY_PRESET=xxxxxxxx`
- `server.js` add Main API Routes (reviews,drivers)
- `schema.prisma` add model `Review`, enum `ReviewTag`

### Changed

#### Admin UI
- **User Management page** (`frontend/pages/admin/users/index.vue`)
  - Imported and registered `BanUserModal`.
  - Added ban flow logic: `onBanUser`, `showBanModal`, and `confirmBan`.
  - Added Ban button UI to the **Actions** column in the user table.

- **User Details page** (`frontend/pages/admin/users/[id]/index.vue`)
  - Added **Ban User** and **Unban User** buttons in the notification section.
  - Integrated `BanUserModal` for the ban process.
  - Implemented logic to suspend/reactivate users directly from the details page.
  - Integrated `UnbanUserModal` to confirm user reactivation.

#### User UI/UX
- **MyTrip Page**: Added "Review Driver" button for completed trips.
- **FindTrip Page**: Added clickable driver profile/rating to view past reviews before booking.
- **Modals**: Created responsive modals for both submitting reviews and viewing driver history.
