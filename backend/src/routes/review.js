const express = require("express")
const router = express.Router()

const { protect } = require("../middlewares/auth")

const {
  createReview,
  getDriverReviews
} = require("../controllers/reviewController")

router.post("/", protect, createReview)
router.get("/driver/:id", getDriverReviews)

module.exports = router
