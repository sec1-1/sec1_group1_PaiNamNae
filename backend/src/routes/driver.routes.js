const express = require("express")
const prisma = require("../utils/prisma")

const router = express.Router()

router.get("/:driverId/review-summary", async (req, res) => {
  try {
    const { driverId } = req.params

    const reviews = await prisma.review.findMany({
      where: { revieweeId: driverId },
      select: {
        rating: true,
        comment: true,
        createdAt: true,
        images: true,
        tags: true,
        reviewer: {
          select: {
            firstName: true,
            profilePicture: true
          }
        }
      },
      orderBy: { createdAt: "desc" }
    })

    const totalReviews = reviews.length

    const distribution = { 5:0,4:0,3:0,2:0,1:0 }
    let totalScore = 0

    reviews.forEach(r => {
      distribution[r.rating]++
      totalScore += r.rating
    })

    const average =
      totalReviews > 0
        ? (totalScore / totalReviews).toFixed(2)
        : 0

    const latestReviews = reviews.slice(0, 3)

    res.json({
      totalReviews,
      average,
      distribution,
      latestReviews
    })

  } catch (error) {
    console.error(error)
    res.status(500).json({ message: "Failed to fetch summary" })
  }
})

module.exports = router
