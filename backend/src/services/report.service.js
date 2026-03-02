const prisma = require('../utils/prisma');
const ApiError = require('../utils/ApiError');
const { createSystemNotification } = require('./notification.service');

const reportInclude = {
  reporter: {
    select: {
      id: true,
      firstName: true,
      lastName: true,
      email: true,
      profilePicture: true,
    },
  },
  targetUser: {
    select: {
      id: true,
      firstName: true,
      lastName: true,
      email: true,
      profilePicture: true,
    },
  },
  route: {
    select: {
      id: true,
      startLocation: true,
      endLocation: true,
      departureTime: true,
    },
  },
  booking: {
    select: {
      id: true,
      status: true,
      numberOfSeats: true,
    },
  },
  resolvedBy: {
    select: {
      id: true,
      firstName: true,
      lastName: true,
    },
  },
};

const createReport = async (reportData) => {
  return prisma.$transaction(async (tx) => {

    const report = await tx.report.create({
      data: {
        reporterId: reportData.reporterId,
        type: reportData.type,
        category: reportData.category,
        description: reportData.description,
        images: reportData.images || null,
        videos: reportData.videos || null,
        routeId: reportData.routeId || null,
        bookingId: reportData.bookingId || null,
        targetUserId: reportData.targetUserId || null,
      },
      include: reportInclude
    })

    // 🔔 แจ้งเตือนผู้ใช้ว่าส่งรีพอร์ตสำเร็จ
    await tx.notification.create({
      data: {
        userId: report.reporterId,
        type: 'SYSTEM',
        title: 'ส่งการรายงานสำเร็จ',
        body: 'เราได้รับการรายงานของคุณแล้ว และจะดำเนินการตรวจสอบโดยเร็วที่สุด',
        link: `/reports/${report.id}`,
        metadata: {
          reportId: report.id,
          status: report.status
        }
      }
    })

    return report
  })
}

const getReportById = async (id) => {
  return prisma.report.findUnique({
    where: { id },
    include: reportInclude
  })
}
const updateReportStatus = async (id, status, adminNotes, adminId) => {
  return prisma.$transaction(async (tx) => {

    const report = await tx.report.findUnique({ where: { id } })

    if (!report) {
      throw new ApiError(404, 'ไม่พบรีพอร์ต')
    }

    const statusChanged = report.status !== status

    const updateData = {
      status,
      adminNotes: adminNotes ?? report.adminNotes,
    }

    if (['RESOLVED', 'APPROVED', 'REJECTED'].includes(status)) {
      updateData.resolvedAt = new Date()
      updateData.resolvedById = adminId
    }

    const updatedReport = await tx.report.update({
      where: { id },
      data: updateData,
      include: reportInclude
    })

    // 🔔 สร้าง notification เมื่อสถานะเปลี่ยนจริง
    if (statusChanged) {

      // แปลงสถานะเป็นภาษาไทย
      const statusTextMap = {
        PENDING: 'รอดำเนินการ',
        APPROVED: 'กำลังตรวจสอบ',
        REJECTED: 'ปฏิเสธ',
        RESOLVED: 'ดำเนินการเสร็จสิ้น'
      }

      const oldStatusText = statusTextMap[report.status] || report.status
      const newStatusText = statusTextMap[status] || status

      await tx.notification.create({
        data: {
          userId: report.reporterId,
          type: 'SYSTEM',
          title: 'อัปเดตสถานะการรายงานของคุณ',
          body: `สถานะการรายงานของคุณถูกเปลี่ยนจาก "${oldStatusText}" เป็น "${newStatusText}"`,
          link: `/reports/${report.id}`,
          metadata: {
            reportId: report.id,
            oldStatus: report.status,
            newStatus: status,
          }
        }
      })
    }

    return updatedReport
  })
}

const deleteReport = async (id) => {
  const report = await prisma.report.findUnique({ where: { id } })

  if (!report) {
    throw new ApiError(404, 'Report not found')
  }

  return prisma.report.delete({ where: { id } })
}

const getReportsByUser = async (userId) => {
  return prisma.report.findMany({
    where: { reporterId: userId },
    include: reportInclude,
    orderBy: { createdAt: 'desc' }
  })
}

const getReportByBookingId = async (bookingId, reporterId) => {
  const where = { bookingId };
  if (reporterId) where.reporterId = reporterId;

  return prisma.report.findFirst({
    where,
    include: reportInclude,
    orderBy: { createdAt: 'desc' },
  });
};

const searchReports = async (opts = {}) => {
  const {
    page = 1,
    limit = 20,
    q,
    type,
    status,
    reporterId,
    reporterSearch,
    dateFrom,
    dateTo,
    sortBy = 'createdAt',
    sortOrder = 'desc',
  } = opts;

  const where = {};

  if (type) where.type = type;
  if (status) where.status = status;

  if (reporterSearch) {
    where.reporter = {
      OR: [
        { firstName: { contains: reporterSearch, mode: 'insensitive' } },
        { lastName: { contains: reporterSearch, mode: 'insensitive' } },
        { email: { contains: reporterSearch, mode: 'insensitive' } },
        { username: { contains: reporterSearch, mode: 'insensitive' } },
        { id: { contains: reporterSearch, mode: 'insensitive' } },
      ],
    };
  }

  if (opts.targetUserSearch) {
    const ts = opts.targetUserSearch;
    where.targetUser = {
      OR: [
        { firstName: { contains: ts, mode: 'insensitive' } },
        { lastName: { contains: ts, mode: 'insensitive' } },
        { email: { contains: ts, mode: 'insensitive' } },
        { username: { contains: ts, mode: 'insensitive' } },
        { id: { contains: ts, mode: 'insensitive' } },
      ],
    };
  }

  if (dateFrom || dateTo) {
    where.createdAt = {};
    if (dateFrom) where.createdAt.gte = new Date(dateFrom);
    if (dateTo) {
      const to = new Date(dateTo);
      to.setHours(23, 59, 59, 999);
      where.createdAt.lte = to;
    }
  }

  if (q) {
    where.OR = [
      { id: { contains: q, mode: 'insensitive' } },
      { description: { contains: q, mode: 'insensitive' } },
      { reporter: { firstName: { contains: q, mode: 'insensitive' } } },
      { reporter: { lastName: { contains: q, mode: 'insensitive' } } },
      { reporter: { email: { contains: q, mode: 'insensitive' } } },
      { reporter: { username: { contains: q, mode: 'insensitive' } } },
    ];
  }

  const [data, total] = await Promise.all([
    prisma.report.findMany({
      where,
      include: reportInclude,
      orderBy: { [sortBy]: sortOrder },
      skip: (page - 1) * limit,
      take: limit,
    }),
    prisma.report.count({ where }),
  ]);

  // flatten reporter info for admin convenience
  const formatted = data.map(r => ({
    ...r,
    reporterName: `${r.reporter?.firstName || ''} ${r.reporter?.lastName || ''}`.trim(),
    reporterEmail: r.reporter?.email || '',
    reporterAvatar: r.reporter?.profilePicture || null,
  }));

  return {
    data: formatted,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  };
};


module.exports = {
  createReport,
  getReportById,
  updateReportStatus,
  deleteReport,
  getReportsByUser,
  getReportByBookingId ,
  searchReports
}