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

### Changed

#### Report Popup
- Updated report submission popup UI and interaction flow.
- Improved validation logic and error messaging.
- Enhanced confirmation feedback after report submission.
- Improved modal behavior and UX consistency.

#### Backend & API (Reviews)
