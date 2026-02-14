const prisma = require("../../prisma")

exports.createReview = async (req, res) => {
  try {
    const userId = req.user.sub
    const { bookingId, rating, comment, tags, images } = req.body

    // หา booking
    const booking = await prisma.booking.findUnique({
      where: { id: bookingId },
      include: {
        route: true
      }
    })

    if (!booking)
      return res.status(404).json({ message: "Booking not found" })

    // เช็คว่าเป็นเจ้าของ booking
    if (booking.passengerId !== userId)
      return res.status(403).json({ message: "Not allowed" })

    // เช็ค route ต้อง COMPLETED
    if (booking.route.status !== "COMPLETED")
      return res.status(400).json({ message: "Trip not completed yet" })

    // กันรีวิวซ้ำ
    const existing = await prisma.review.findUnique({
      where: { bookingId }
    })

    if (existing)
      return res.status(400).json({ message: "Already reviewed" })

    // สร้าง review
    const review = await prisma.review.create({
    data: {
        bookingId,
        routeId: booking.routeId,
        reviewerId: userId,
        revieweeId: booking.route.driverId,
        rating: Number(rating),
        comment: comment || null,
        tags: tags || [],
        images: images || []
    }
})

    res.json(review)

  } catch (error) {
   console.error(error)
   res.status(500).json({
     message: error.message
   })
  }
}

exports.getDriverReviews = async (req, res) => {
  try {
    const driverId = parseInt(req.params.id)

    const reviews = await prisma.review.findMany({
      where: {
        revieweeId: driverId
      },
      include: {
        reviewer: {
          select: {
            id: true,
            name: true,
            profileImage: true
          }
        }
      },
      orderBy: {
        createdAt: "desc"
      }
    })

    res.json(reviews)

  } catch (err) {
    console.error(err)
    res.status(500).json({ message: "Server error" })
  }
}
