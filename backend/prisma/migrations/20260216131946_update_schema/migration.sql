-- AlterTable
ALTER TABLE "Route" ADD COLUMN     "actualEndTime" TIMESTAMP(3),
ADD COLUMN     "actualStartTime" TIMESTAMP(3),
ADD COLUMN     "optimizeWaypoints" BOOLEAN DEFAULT false;
