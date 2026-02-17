# Changelog

All notable changes to this project will be documented in this file.

The format is based on **Keep a Changelog**, and this project adheres to **Semantic Versioning**.

## AI Declaration
Parts of this changelog were drafted with the assistance of an AI language model (Gemini 3 Pro). All entries were reviewed and edited by the project author for accuracy and completeness.


### Added

#### Admin (User Suspension)
- **Ban user (Admin)**
  - Added `frontend/components/BanUserModal.vue` to allow admins to select a suspension reason.
  - Added **Ban** action (icon/button) to the user management table in `frontend/pages/admin/users/index.vue`.
  - Implemented ban modal flow to suspend users via the backend.
  - Added a confirmation step to reduce accidental suspensions.
  - Added a success step to confirm suspension completion.
  - Displayed a **Suspended** badge in the **Verification** column for banned users.
  - Added an **Unban** (check) action in the **Actions** column for quick reactivation.

- **Unban user (Admin)**
  - Added `frontend/components/UnbanUserModal.vue` for user reactivation.
  - Implemented a 2-step modal flow (**Confirm → Success**) consistent with the ban UX.

#### Reviews (User → Driver)
- **Driver review submission**
  - Added review submission UI in `frontend/pages/myTrip/index.vue`.
  - Enabled rating drivers (1–5 stars) after a trip is marked **completed**.
  - Added selectable review tags (e.g., *Polite Driver*, *Clean Car*, *Safe Driving*).
  - Added text comments and image upload support for detailed feedback.

- **Driver review history**
  - Added review history modal in `frontend/pages/findTrip/index.vue` and `frontend/pages/myTrip/index.vue`.
  - Enabled opening driver review history by clicking a driver profile.
  - Displayed summary metrics (average rating, valid review count) and review details (reviewer name, date, comment, tags, images).
  - Added filtering to view reviews by tag.

#### Backend & API (Reviews)
- Added review system (frontend + backend integration).
- Added API endpoints:
  - Create review
  - Review summary (average, totals, distribution)
  - Filter reviews by tag
- Added review tag categories.
- Added review image upload via Cloudinary.
- Added duplicate review prevention.
- Updated environment variables:
  - `NUXT_PUBLIC_CLOUDINARY_CLOUD=xxxxx`
  - `NUXT_PUBLIC_CLOUDINARY_PRESET=xxxxxxxx`
- Updated routing:
  - `server.js` registered main API routes (reviews, drivers).
- Updated Prisma schema:
  - `schema.prisma` added `Review` model and `ReviewTag` enum.

### Changed

#### Admin UI
- **User Management** (`frontend/pages/admin/users/index.vue`)
  - Registered `BanUserModal`.
  - Added ban flow logic: `onBanUser`, `showBanModal`, `confirmBan`.
  - Added Ban action UI to the **Actions** column.

- **User Details** (`frontend/pages/admin/users/[id]/index.vue`)
  - Added **Ban User** and **Unban User** buttons in the notification section.
  - Integrated `BanUserModal` to ban users from the details page.
  - Implemented suspend/reactivate logic from the details page.
  - Integrated `UnbanUserModal` to confirm user reactivation.

#### User UI/UX
- **MyTrip**: Added **Review Driver** button for completed trips.
- **FindTrip**: Made driver profile/rating clickable to view past reviews before booking.
- **Modals**: Implemented responsive modals for submitting reviews and viewing driver history.
