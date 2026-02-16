const express = require('express')
const router = express.Router()
const reportController = require("../controllers/report.controller")
const { protect } = require('../middlewares/auth');


router.post('/' , protect , reportController.createReport)

module.exports = router