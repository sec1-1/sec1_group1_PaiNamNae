const express = require('express');
const reportController = require('../controllers/report.controller');
const validate = require('../middlewares/validate');
const { protect, requireAdmin } = require('../middlewares/auth');
const upload = require('../middlewares/upload.middleware');
const { createReportSchema, updateReportStatusSchema, listReportsQuerySchema, idParamSchema, bookingIdParamSchema } = require('../validations/report.validation');

const router = express.Router();

// --- Admin Routes ---
// GET /api/reports/admin
router.get(
    '/admin',
    protect,
    requireAdmin,
    validate({ query: listReportsQuerySchema }),
    reportController.searchReports
);

// GET /api/reports/admin/:id
router.get(
    '/admin/:id',
    protect,
    requireAdmin,
    validate({ params: idParamSchema }),
    reportController.getReportById
);

// PATCH /api/reports/admin/:id
router.patch(
    '/admin/:id',
    protect,
    requireAdmin,
    validate({ params: idParamSchema, body: updateReportStatusSchema }),
    reportController.updateReportStatus
);

// DELETE /api/reports/admin/:id
router.delete(
    '/admin/:id',
    protect,
    requireAdmin,
    validate({ params: idParamSchema }),
    reportController.deleteReport
);

// --- User Routes ---
// GET /api/reports/me (user's own reports)
router.get(
    '/me',
    protect,
    reportController.getMyReports
);

// GET /api/reports/booking/:bookingId (check if report exists for booking)
router.get(
    '/booking/:bookingId',
    protect,
    validate({ params: bookingIdParamSchema }),
    reportController.getReportByBookingId
);

// POST /api/reports (Create a new report with image upload)
router.post(
    '/',
    protect,
    upload.fields([{ name: 'images', maxCount: 2 }]),
    validate({ body: createReportSchema }),
    reportController.createReport
);

// GET /api/reports/:id (Get report details)
router.get(
    '/:id',
    protect,
    validate({ params: idParamSchema }),
    reportController.getReportById
);

module.exports = router;