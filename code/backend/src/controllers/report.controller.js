const reportService = require('../services/report.service');
const ApiError = require('../utils/ApiError');
const asyncHandler = require('express-async-handler');
const { uploadToCloudinary } = require('../utils/cloudinary');

/**
 * @desc    Create report
 * @route   POST /reports
 */
const createReport = asyncHandler(async (req, res) => {

  const { type, category, description, routeId, bookingId, targetUserId } = req.body;

  let imageUrls = [];
  let videoUrls = [];
  let audioUrls = [];
  if (req.files) {
    if (req.files.images) {
      const uploads = req.files.images.map(file =>
        uploadToCloudinary(file.buffer, 'reports')
      );
      const results = await Promise.all(uploads);
      imageUrls = results.map(r => r.url);
    }
    if (req.files.videos) {
      const uploads = req.files.videos.map(file =>
        uploadToCloudinary(file.buffer, 'reports', { resource_type: 'video' })
      );
      const results = await Promise.all(uploads);
      videoUrls = results.map(r => r.url);
    }
    if (req.files.audios) {
      const uploads = req.files.audios.map(file =>
        uploadToCloudinary(file.buffer, 'reports', { resource_type: 'video' })
      );
      const results = await Promise.all(uploads);
      audioUrls = results.map(r => r.url);
    }
  }

  const reportData = {
    reporterId: req.user.sub,
    type,
    category,
    reportScope: (bookingId || routeId) ? 'POST_TRIP' : 'SYSTEM',
    description,
    images: imageUrls.length > 0 ? imageUrls : null,
    videos: [...videoUrls, ...audioUrls].length > 0 ? [...videoUrls, ...audioUrls] : null,
    routeId: routeId || null,
    bookingId: bookingId || null,
    targetUserId: targetUserId || null,
  };

  const newReport = await reportService.createReport(reportData);

  res.status(201).json({
    success: true,
    message: "Report created successfully",
    data: newReport
  });
});

/**
 * @desc    Get report by id
 * @route   GET /reports/:id
 */
const getReportById = async (req, res, next) => {
  try {
    const report = await reportService.getReportById(req.params.id);

    if (!report) {
      throw new ApiError(404, 'Report not found');
    }

    res.json({ data: report });
  } catch (err) {
    next(err);
  }
};

/**
 * @desc    Update report status (ADMIN)
 * @route   PATCH /reports/:id/status
 */
const updateReportStatus = async (req, res, next) => {
  try {
    const adminId = req.user.id;
    const { status, adminNotes } = req.body;

    if (!status) {
      throw new ApiError(400, 'Status is required');
    }

    const report = await reportService.updateReportStatus(
      req.params.id,
      status,
      adminNotes,
      adminId
    );

    res.json({
      message: 'Report status updated',
      data: report,
    });
  } catch (err) {
    next(err);
  }
};

/**
 * @desc    Delete report (ADMIN)
 * @route   DELETE /reports/:id
 */
const deleteReport = async (req, res, next) => {
  try {
    await reportService.deleteReport(req.params.id);

    res.json({
      message: 'Report deleted successfully',
    });
  } catch (err) {
    next(err);
  }
};

/**
 * @desc    Get my reports
 * @route   GET /reports/me
 */
const getMyReports = async (req, res, next) => {
  try {
    const userId = req.user.sub || req.user.id;

    if (!userId) {
      throw new ApiError(401, 'Not authorized');
    }

    const reports = await reportService.getReportsByUser(userId);

    res.json({ data: reports });
  } catch (err) {
    next(err);
  }
};

/**
 * @desc    Get report by booking id
 * @route   GET /reports/booking/:bookingId
 */
const getReportByBookingId = async (req, res, next) => {
  try {
    const reporterId = req.user.sub;

    const report = await reportService.getReportByBookingId(
      req.params.bookingId,
      reporterId
    );

    res.json({ data: report });
  } catch (err) {
    next(err);
  }
};

/**
 * @desc    Search reports (ADMIN)
 * @route   GET /reports
 */
const searchReports = async (req, res, next) => {
  try {
    const result = await reportService.searchReports(req.query);

    res.json(result);
  } catch (err) {
    next(err);
  }
};

/**
 * @desc    Get report statistics (ADMIN)
 * @route   GET /reports/stats
 */
const getReportStats = async (req, res, next) => {
  try {
    const stats = await reportService.getReportStats();

    res.json(stats);
  } catch (err) {
    next(err);
  }
};

module.exports = {
  createReport,
  getReportById,
  updateReportStatus,
  deleteReport,
  getMyReports,
  getReportByBookingId,
  searchReports,
  getReportStats,
};