const express = require("express")
const router = express.Router()
const adminController = require("../controllers/admin.controller")
const { protect, requireAdmin } = require('../middlewares/auth');

router.patch(
    '/reports/:id/approve' , 
    protect , 
    requireAdmin , 
    adminController.approveReport
)

router.patch(
    '/reports/:id/reject' , 
    protect , 
    requireAdmin , 
    adminController.rejectReport
)

router.post(
    '/users/:userId/blacklist' , 
    protect , 
    requireAdmin , 
    adminController.blacklistUser
)

module.exports = router