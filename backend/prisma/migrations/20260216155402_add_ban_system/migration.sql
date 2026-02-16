-- CreateEnum
CREATE TYPE "BanType" AS ENUM ('TEMPORARY', 'PERMANENT');

-- AlterTable
ALTER TABLE "Blacklist" ADD COLUMN     "expiresAt" TIMESTAMP(3),
ADD COLUMN     "revokeReason" TEXT,
ADD COLUMN     "revokedAt" TIMESTAMP(3),
ADD COLUMN     "revokedBy" TEXT,
ADD COLUMN     "type" "BanType" NOT NULL DEFAULT 'PERMANENT';
