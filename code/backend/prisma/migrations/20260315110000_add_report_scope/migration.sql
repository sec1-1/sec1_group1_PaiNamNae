-- Add ReportScope enum and reportScope column to distinguish system reports vs post-trip reports
CREATE TYPE "ReportScope" AS ENUM ('SYSTEM', 'POST_TRIP');

ALTER TABLE "Report"
ADD COLUMN "reportScope" "ReportScope" NOT NULL DEFAULT 'SYSTEM';
