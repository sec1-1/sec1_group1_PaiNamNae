# Changelog

All notable changes to this project will be documented in this file.

The format is based on **Keep a Changelog**, and this project adheres to **Semantic Versioning**.

## AI Declaration
Parts of this changelog text were drafted with the assistance of an AI language model (Gemini 3 Pro).
All entries were reviewed and edited by the project author for accuracy and completeness.

### Added
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

### Changed
- **User Management page** (`frontend/pages/admin/users/index.vue`)
  - Imported and registered `BanUserModal`.
  - Added ban flow logic: `onBanUser`, `showBanModal`, and `confirmBan`.
  - Added Ban button UI to the **Actions** column in the user table.

- **User Details page** (`frontend/pages/admin/users/[id]/index.vue`)
  - Added **Ban User** and **Unban User** buttons in the notification section.
  - Integrated `BanUserModal` for the ban process.
  - Implemented logic to suspend/reactivate users directly from the details page.
  - Integrated `UnbanUserModal` to confirm user reactivation.
