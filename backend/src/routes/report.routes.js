const express = require('express')
const router = express.Router()
const reportController = require("../controllers/report.controller")
const { protect, requireAdmin } = require('../middlewares/auth');


// --- Admin Routes
// GET /api/reports/admin
router.get(
    '/admin' ,
    protect ,
    requireAdmin , 
    reportController.searchReports
)

// GET /api/reports/admin/:id
router.get(
    '/admin/:id' , 
    protect , 
    requireAdmin , 
    reportController.getReportById
)

// PATCH /api/reports/admin/:id
router.patch(
    '/admin/:id' , 
    protect , 
    requireAdmin , 
    reportController.updateReportStatus
)

// DELETE /api/reports/admin/:id
router.delete(
    '/admin/:id' , 
    protect , 
    requireAdmin , 
    reportController.deleteReport
)

// --- User Routes ---
// GET /api/reports/me (user's own reports)
router.get(
    '/me' , 
    protect , 
    reportController.getMyReports
)

// GET /api/reports/booking/:bookingId (check if report exists for booking)
router.get(
    '/booking/:bookingId' , 
    protect , 
    reportController.getReportByBookingId
) 

// POST /api/reports (Create a new report with image upload)
router.post(
    '/' , 
    protect , 
    reportController.createReport
)

// GET /api/reports/:id (Get report details)
router.get(
    '/:id' , 
    protect , 
    reportController.getReportById
)

module.exports = router