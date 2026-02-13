const prisma = require("../utils/prisma")
const STRIKE_BLACKLIST = 3

const applyPenaltyAfterApproval = async (reportId) => {
  return await prisma.$transaction(async (tx) => {
    const report = await tx.report.findUnique({
      where: { id: reportId },
      select: {
        status: true,
        reportedUserId: true,
        penaltyApplied: true
      }
    })
    // เช็คว่ามีreportจริงๆไหม
    if (!report) {
      return { message: "Report not found" }
    }
    // เช็คว่าreportถูกแอดมินapproveยัง
    if (report.status !== "APPROVED") {
      return { message: "Report is not approved" }
    }
    // ห้ามapprove reportเก่าซ้ำ
    if (report.penaltyApplied) {
      return { message: "Penalty already applied" }
    }

    const userId = report.reportedUserId

    await tx.report.update({
      where: { id: reportId },
      data: { penaltyApplied: true }
    })

    const updatedUser = await tx.user.update({
      where: { id: userId },
      data: {
        strikeCount: { increment: 1 }
      },
      select: { strikeCount: true }
    })

    const currentStrike = updatedUser.strikeCount

    if (currentStrike < STRIKE_BLACKLIST) {
      return {
        message: `User warned (${currentStrike}/${STRIKE_BLACKLIST})`
      }
    }

    const existing = await tx.blacklist.findFirst({
      where: { userId }
    })

    if (existing) {
      return { message: "User already blacklisted" }
    }

    await tx.blacklist.create({
      data: {
        userId,
        reason: "Reached 3 approved reports",
        createdBy: "SYSTEM"
      }
    })

    await tx.user.update({
      where: { id: userId },
      data: { isActive: false }
    })

    return { message: "User moved to blacklist" }
  })
}


module.exports = {
  applyPenaltyAfterApproval
}
