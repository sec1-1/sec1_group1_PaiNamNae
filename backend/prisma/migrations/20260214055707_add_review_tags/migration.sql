-- CreateEnum
CREATE TYPE "ReviewTag" AS ENUM ('CLEAN', 'POLITE_DRIVER', 'ON_TIME', 'SAFE_DRIVING', 'FRIENDLY_SERVICE');

-- AlterTable
ALTER TABLE "Review" ADD COLUMN     "tags" "ReviewTag"[];
