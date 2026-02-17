const prisma = require("../utils/prisma")
const penaltyService = require("./penalty.service")

const approveReport = async (reportId, adminId) => {
  // อัปเดตเฉพาะstatus = pending
  const report = await prisma.report.updateMany({
    where: {
      id: reportId,
      status: "PENDING"
    },
    data: {
      status: "APPROVED",
      reviewedBy: adminId,
      reviewedAt: new Date()
    }
  })

  if (report.count === 0) {
    return { message: "Report already reviewed" }
  }

  const updatedReport = await prisma.report.findUnique({
    where: { id: reportId }
  })

  const penaltyResult = await penaltyService.applyPenaltyAfterApproval(reportId)

  return {
    report: updatedReport,
    penalty: penaltyResult
  }
}

const blacklistUserDirectly = async (userId, adminId, options = {}) => {

  const { reason, type = "PERMANENT", durationDays } = options

  return await prisma.$transaction(async (tx) => {

    // กัน admin blacklist ตัวเอง
    if (adminId === userId) {
      return { message: "Admin cannot blacklist themselves" }
    }

    // user check
    const user = await tx.user.findUnique({
      where: { id: userId },
      select: { id: true, isActive: true }
    })

    if (!user) {
      return { message: "User not found" }
    }

    const existing = await tx.blacklist.findFirst({
      where: {
        userId,
        revokedAt: null
      }
    })

    if (existing) {
      return { message: "User already blacklisted" }
    }

    let expiresAt = null
    if (type === "TEMPORARY" && durationDays) {
      expiresAt = new Date()
      expiresAt.setDate(expiresAt.getDate() + durationDays)
    }

    await tx.blacklist.create({
      data: {
        userId,
        reason: reason || "Blacklisted by admin",
        createdBy: adminId,
        type,
        expiresAt
      }
    })

    await tx.user.update({
      where: { id: userId },
      data: { isActive: false }
    })

    return {
      message: "User blacklisted by admin",
      userId
    }
  })
}

const unblacklistUser = async (userId, adminId, reason) => {
  return await prisma.$transaction(async (tx) => {

    const record = await tx.blacklist.findFirst({
      where: {
        userId,
        revokedAt: null
      }
    })

    if (!record) {
      return { message: "User is not blacklisted" }
    }

    await tx.blacklist.update({
      where: { id: record.id },
      data: {
        revokedAt: new Date(),
        revokedBy: adminId,
        revokeReason: reason || "Unblacklisted by admin"
      }
    })

    await tx.user.update({
      where: { id: userId },
      data: { isActive: true }
    })

    return {
      message: "User unblacklisted",
      userId
    }

  })
}


module.exports = {
  approveReport,
  blacklistUserDirectly,
  unblacklistUser
}
