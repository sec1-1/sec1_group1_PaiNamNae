-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ReviewTag" ADD VALUE 'DIRTY';
ALTER TYPE "ReviewTag" ADD VALUE 'RUDE_DRIVER';
ALTER TYPE "ReviewTag" ADD VALUE 'LATE';
ALTER TYPE "ReviewTag" ADD VALUE 'UNSAFE_DRIVING';
ALTER TYPE "ReviewTag" ADD VALUE 'UNFRIENDLY_SERVICE';
