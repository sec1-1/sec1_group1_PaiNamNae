const prisma = require("../utils/prisma")
const penaltyService = require("./penalty.service")

const approveReport = async (reportId, adminId) => {
  // อัปเดตเฉพาะstatus = pending
  const report = await prisma.report.updateMany({
    where: {
      id: reportId , 
      status: "PENDING"
    } , 
    data: {
      status: "APPROVED" , 
      reviewedBy: adminId , 
      reviewedAt: new Date()
    }
  })

  if(report.count === 0) {
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

const blacklistUserDirectly  = async (userId , adminId , reason) => {
  return await prisma.$transaction(async (tx) => {
    // user check
    const user = await tx.user.findUnique({
      where: { id: userId } , 
      select: { id: true , isActive: true }
    })

    if(!user) {
      return { message: "User not found" }
    }

    const existing = await tx.blacklist.findFist({
      where: { userId }
    })

    if(existing) {
      return { message: "User already blacklisted" }
    }

    await tx.blacklist.create({
      data: {
        userId , 
        reason: reason || "Blacklisted by admin",
        createdBy: adminId
      }
    })

    await tx.user.update({
      where: { userId } , 
      data: { isActive: false }
    })

    return { message: "User blacklisted by admin" }
  })
}

module.exports = {
  approveReport , 
  blacklistUserDirectly
}
