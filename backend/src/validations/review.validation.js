const Joi = require('joi')

exports.createReviewSchema = Joi.object({
  bookingId: Joi.string().required(),
  rating: Joi.number().min(1).max(5).required(),
  comment: Joi.string().allow('').optional(),
  tags: Joi.array().items(
    Joi.string().valid(
      'CLEAN',
      'POLITE_DRIVER',
      'ON_TIME',
      'SAFE_DRIVING',
      'FRIENDLY_SERVICE'
    )
  ).optional(),
  images: Joi.array().items(Joi.string()).optional()
})
