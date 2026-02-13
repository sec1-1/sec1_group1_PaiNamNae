/*
  Warnings:

  - You are about to drop the column `distance` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `distanceMeters` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `duration` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `durationSeconds` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `landmarks` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `routePolyline` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `routeSummary` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `steps` on the `Route` table. All the data in the column will be lost.
  - You are about to drop the column `waypoints` on the `Route` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "ReportStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "ReportType" AS ENUM ('INAPPROPRIATE_BEHAVIOR', 'NO_SHOW', 'SCAM', 'SAFETY_CONCERN', 'OTHER');

-- DropIndex
DROP INDEX "DriverVerification_createdAt_idx";

-- DropIndex
DROP INDEX "DriverVerification_licenseExpiryDate_idx";

-- DropIndex
DROP INDEX "DriverVerification_licenseIssueDate_idx";

-- DropIndex
DROP INDEX "Notification_adminReviewedAt_idx";

-- DropIndex
DROP INDEX "Notification_userId_readAt_idx";

-- DropIndex
DROP INDEX "Route_createdAt_idx";

-- DropIndex
DROP INDEX "Route_departureTime_idx";

-- DropIndex
DROP INDEX "Route_status_idx";

-- DropIndex
DROP INDEX "Route_vehicleId_idx";

-- DropIndex
DROP INDEX "Vehicle_createdAt_idx";

-- DropIndex
DROP INDEX "Vehicle_seatCapacity_idx";

-- DropIndex
DROP INDEX "Vehicle_vehicleType_idx";

-- AlterTable
ALTER TABLE "Route" DROP COLUMN "distance",
DROP COLUMN "distanceMeters",
DROP COLUMN "duration",
DROP COLUMN "durationSeconds",
DROP COLUMN "landmarks",
DROP COLUMN "routePolyline",
DROP COLUMN "routeSummary",
DROP COLUMN "steps",
DROP COLUMN "waypoints";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "strikeCount" INTEGER NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "Report" (
    "id" TEXT NOT NULL,
    "reporterId" TEXT NOT NULL,
    "reportedUserId" TEXT NOT NULL,
    "bookingId" TEXT,
    "type" "ReportType" NOT NULL,
    "description" TEXT NOT NULL,
    "evidenceUrl" TEXT,
    "status" "ReportStatus" NOT NULL DEFAULT 'PENDING',
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Blacklist" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "createdBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Blacklist_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Report_reportedUserId_idx" ON "Report"("reportedUserId");

-- CreateIndex
CREATE INDEX "Report_status_idx" ON "Report"("status");

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_reporterId_fkey" FOREIGN KEY ("reporterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_reportedUserId_fkey" FOREIGN KEY ("reportedUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Blacklist" ADD CONSTRAINT "Blacklist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
