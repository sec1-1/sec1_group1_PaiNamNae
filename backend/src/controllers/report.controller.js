const reportService = require("../services/report.service")

const createReport = async (req, res, next) => {
  try {
    const reporterId = req.user?.sub
    const { reportedUserId, type, description } = req.body

    if (!reporterId || !reportedUserId || !type || !description) {
      return res.status(400).json({
        success: false,
        message: "ข้อมูลส่งมาไม่ครบหรือไม่ถูกต้อง",
        data: null
      })
    }

    const report = await reportService.createReport({
      reporterId,
      reportedUserId,
      type,
      description,
    })


    res.status(201).json({
      success: true,
      message: "Report Created",
      data: report
    })
  } catch (error) {
    next(error)
  }
}

module.exports = { createReport }
