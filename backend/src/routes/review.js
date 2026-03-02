const express = require("express")
const router = express.Router()

const { protect } = require("../middlewares/auth")
const upload = require("../middlewares/upload.middleware")

const {
  createReview,
  getDriverReviews
} = require("../controllers/reviewController")

router.post("/", protect, upload.fields([
    { name: 'images', maxCount: 3 },
    { name: 'videos', maxCount: 3 }
]), createReview)
router.get("/driver/:id", getDriverReviews)

module.exports = router
