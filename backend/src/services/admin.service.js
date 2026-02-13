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

module.exports = {
  approveReport
}
