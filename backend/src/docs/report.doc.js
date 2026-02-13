/**
 * @swagger
 * tags:
 *   name: Report
 *   description: Reporting system
 */

/**
 * @swagger
 * /api/reports:
 *   post:
 *     summary: Create a report
 *     tags: [Report]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - reportedUserId
 *               - type
 *               - description
 *             properties:
 *               reportedUserId:
 *                 type: string
 *                 example: cmlkmye9g0003q81om5sngw4g
 *               type:
 *                 type: string
 *                 enum:
 *                   - INAPPROPRIATE_BEHAVIOR
 *                   - NO_SHOW
 *                   - SCAM
 *                   - SAFETY_CONCERN
 *                   - OTHER
 *                 example: SAFETY_CONCERN
 *               description:
 *                 type: string
 *                 example: ขับรถอันตราย
 *               bookingId:
 *                 type: string
 *                 nullable: true
 *                 example: cmxxxxbookingid
 *     responses:
 *       201:
 *         description: Report created successfully
 *       400:
 *         description: Validation error
 *       401:
 *         description: Unauthorized
 */
