# Changelog

All notable changes to this project will be documented in this file.

The format is based on **Keep a Changelog**, and this project adheres to **Semantic Versioning**.

---

## AI Declaration
Parts of this changelog were drafted with the assistance of an AI language model (ChatGPT). All entries were reviewed and edited by the project author for accuracy and completeness.

---

## [Unreleased]

### Added

#### Reviews (Video Support)
- **Video review support**
  - Added video upload functionality to the review system.
  - Enabled users to attach video files alongside text comments and images.
  - Implemented video validation and handling in the review controller.
  - Updated frontend review UI to preview and display video content.
  - Extended backend logic to store and return video URLs in review responses.

#### Reports
- **History Report Page**
  - Added new page: `frontend/pages/history-report.vue`.
  - Displays user report history in a structured layout.
  - Integrated API to fetch and render submitted reports dynamically.
  - Added status visibility for each report entry.

---

## Admin Report Management & User Report Tracking

### Added

#### Admin Reports Page (`frontend/pages/admin/reports/index.vue`)
- **Admin report management interface**
  - Created dedicated admin report review page with tabular layout and pagination.
  - Integrated backend APIs:
    - `GET /api/reports/admin`
    - `PATCH /api/reports/admin/:id`
    - `DELETE /api/reports/admin/:id`
  - Implemented **"ตรวจสอบรายงาน" modal** displaying:
    - Report type and category
    - Reporter information
    - Driver information
    - Description
    - Attached images
    - Attached videos
  - Added status action buttons:
    - `APPROVED` (กำลังตรวจสอบ)
    - `RESOLVED` (ตอบรับแล้ว)
    - `REJECTED` (ปฏิเสธแล้ว)
    - Delete report
  - Added scale–fade modal animation.
  - Added HTML5 `<video>` player support for attached videos.

#### Admin Sidebar (`frontend/components/admin/AdminSidebar.vue`)
- Added **"Check Report"** menu item linking to `/admin/reports`.

#### Admin Contact Information
- Added admin contact email section to report tracking views:
  - `frontend/pages/myTrip/index.vue`
  - `frontend/pages/profile/history-report.vue`
- Added contact email: **admin@example.com**
- Added explanatory message for direct admin communication.

---

### Changed

#### Report Popup
- Updated report submission popup UI and interaction flow.
- Improved validation logic and error messaging.
- Enhanced confirmation feedback after report submission.
- Improved modal behavior and UX consistency.
- Enabled closing modal by clicking on backdrop.

#### Admin Reports UI Adjustments
- Translated report status labels to Thai:
  - `PENDING` → รอดำเนินการ
  - `APPROVED` → กำลังตรวจสอบ
  - `REJECTED` → ปฏิเสธแล้ว
  - `RESOLVED` → ตอบรับแล้ว
- Updated table header:
  - "เป้าหมาย (ถ้ามี)" → "คนขับ"
- Renamed button:
  - "ดูรายละเอียด" → "ตรวจสอบรายงาน"

---

### Fixed

#### Backend & Validation
- Replaced invalid status `IN_PROGRESS` with `APPROVED` to align with Prisma enum schema.
- Removed duplicate `statusBadge` function causing Vite compilation failure.
- Increased modal `z-index` to `z-[1050]` to ensure proper overlay above sidebar and header.


### Test

#### UAT Test
- Add test cases for the “Report System” (report), covering scenarios such as successful submission, failed submission, cancellation, file size limit, invalid file format, and status changes by the administrator.
- Add test cases reviewed from Sprint 1 for further development, and refactor the code related to Checkbox, Comment, Rating, UploadImage, CloseReview, DoubleReview, and ViewReview.
