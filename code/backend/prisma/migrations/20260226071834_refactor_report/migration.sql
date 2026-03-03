/*
  Warnings:

  - The values [INAPPROPRIATE_BEHAVIOR,NO_SHOW,SCAM,SAFETY_CONCERN,OTHER] on the enum `ReportType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `evidenceUrl` on the `Report` table. All the data in the column will be lost.
  - You are about to drop the column `penaltyApplied` on the `Report` table. All the data in the column will be lost.
  - You are about to drop the column `reportedUserId` on the `Report` table. All the data in the column will be lost.
  - You are about to drop the column `reviewedAt` on the `Report` table. All the data in the column will be lost.
  - You are about to drop the column `reviewedBy` on the `Report` table. All the data in the column will be lost.
  - Added the required column `category` to the `Report` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Report` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ReportCategory" AS ENUM ('VEHICLE_ISSUE', 'PASSENGER_ISSUE', 'ROAD_ISSUE', 'SAFETY_ISSUE', 'PAYMENT_ISSUE', 'NO_SHOW', 'OTHER');

-- AlterEnum
ALTER TYPE "ReportStatus" ADD VALUE 'RESOLVED';

-- AlterEnum
BEGIN;
CREATE TYPE "ReportType_new" AS ENUM ('DRIVER', 'PASSENGER');
ALTER TABLE "Report" ALTER COLUMN "type" TYPE "ReportType_new" USING ("type"::text::"ReportType_new");
ALTER TYPE "ReportType" RENAME TO "ReportType_old";
ALTER TYPE "ReportType_new" RENAME TO "ReportType";
DROP TYPE "ReportType_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Report" DROP CONSTRAINT "Report_reportedUserId_fkey";

-- DropForeignKey
ALTER TABLE "Report" DROP CONSTRAINT "Report_reporterId_fkey";

-- DropIndex
DROP INDEX "Report_reportedUserId_idx";

-- AlterTable
ALTER TABLE "Report" DROP COLUMN "evidenceUrl",
DROP COLUMN "penaltyApplied",
DROP COLUMN "reportedUserId",
DROP COLUMN "reviewedAt",
DROP COLUMN "reviewedBy",
ADD COLUMN     "adminNotes" TEXT,
ADD COLUMN     "category" "ReportCategory" NOT NULL,
ADD COLUMN     "images" JSON,
ADD COLUMN     "resolvedAt" TIMESTAMP(3),
ADD COLUMN     "resolvedById" TEXT,
ADD COLUMN     "routeId" TEXT,
ADD COLUMN     "targetUserId" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE INDEX "Report_reporterId_idx" ON "Report"("reporterId");

-- CreateIndex
CREATE INDEX "Report_routeId_idx" ON "Report"("routeId");

-- CreateIndex
CREATE INDEX "Report_bookingId_idx" ON "Report"("bookingId");

-- CreateIndex
CREATE INDEX "Report_type_idx" ON "Report"("type");

-- CreateIndex
CREATE INDEX "Report_createdAt_idx" ON "Report"("createdAt");

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_reporterId_fkey" FOREIGN KEY ("reporterId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_routeId_fkey" FOREIGN KEY ("routeId") REFERENCES "Route"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_targetUserId_fkey" FOREIGN KEY ("targetUserId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_resolvedById_fkey" FOREIGN KEY ("resolvedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
