/**
 * @swagger
 * tags:
 *   name: Admin-Report
 *   description: Admin report management
 */

/**
 * @swagger
 * /api/admin/reports/{id}/approve:
 *   patch:
 *     summary: Approve a report (Admin only)
 *     tags: [Admin-Report]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         example: cmxxxxreportid
 *     responses:
 *       200:
 *         description: Report approved
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin access required
 *       404:
 *         description: Report not found
 */

/**
 * @swagger
 * /api/admin/reports/{id}/reject:
 *   patch:
 *     summary: Reject a report (Admin only)
 *     tags: [Admin-Report]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         example: cmxxxxreportid
 *     responses:
 *       200:
 *         description: Report rejected
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin access required
 *       404:
 *         description: Report not found
 */
