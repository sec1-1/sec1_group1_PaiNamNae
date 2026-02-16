const adminService = require("../services/admin.service")
const reportService = require("../services/report.service")

const approveReport = async (req, res, next) => {
  try {
    const reportId = req.params.id
    const adminId = req.user.sub

    const result = await adminService.approveReport(
      reportId,
      adminId
    )

    res.json({
      message: "Report approved",
      data: result
    })
  } catch (error) {
    next(error)
  }
}

const rejectReport = async (req, res, next) => {
  try {
    const reportId = req.params.id
    const adminId = req.user.sub

    const report = await reportService.updateReportStatus(
      reportId,
      "REJECTED",
      adminId
    )

    res.json({
      message: "Report rejected",
      data: report
    })
  } catch (error) {
    next(error)
  }
}

const blacklistUser = async (req , res , next) => {
  try {
    const adminId = req.user.sub
    const userId = req.params.userId
    const { reason } = req.body

    const result = await adminService.blacklistUserDirectly(adminId , userId , reason)
    
    res.json({
      message: "User blacklisted" , 
      data: result
    })

  }catch(error) {
    next(error) 
  }
}

module.exports = { approveReport, rejectReport , blacklistUser }
