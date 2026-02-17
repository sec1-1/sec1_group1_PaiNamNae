# Change Log

All notable changes to the "findtrip" and "mytrip" modules.

## AI Declaration
Parts of this changelog text were drafted with the assistance of an AI language model (Gemini 3 Pro).
All entries were reviewed and edited by the project author for accuracy and completeness.

### Added

#### Features
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

### UI/UX
- **MyTrip Page**: Added "Review Driver" button for completed trips.
- **FindTrip Page**: Added clickable driver profile/rating to view past reviews before booking.
- **Modals**: Created responsive modals for both submitting reviews and viewing driver history.
