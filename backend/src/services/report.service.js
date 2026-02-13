const prisma = require("../utils/prisma")

const createReport = async ({
  reporterId,
  reportedUserId,
  type,
  description,
  bookingId,
}) => {
  return await prisma.report.create({
    data: {
      reporterId,
      reportedUserId,
      type,
      description,
      bookingId: bookingId || null,
    },
  })
}

const updateReportStatus = async (reportId, status, adminId) => {
  return await prisma.report.update({
    where: { id: reportId },
    data: {
      status,
      reviewedBy: adminId,
      reviewedAt: new Date(),
    },
  })
}

module.exports = {
  createReport,
  updateReportStatus,
}
