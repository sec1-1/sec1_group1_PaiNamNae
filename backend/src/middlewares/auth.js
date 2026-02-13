const asyncHandler = require('express-async-handler');
const ApiError = require('../utils/ApiError');
const { verifyToken } = require('../utils/jwt');
const prisma = require('../utils/prisma');

const protect = asyncHandler(async (req, res, next) => {
    let token;
    const authHeader = req.headers.authorization;

    if (authHeader && authHeader.startsWith('Bearer')) {
        try {
            // Get token from header
            token = authHeader.split(' ')[1];

            // Verify token
            const decoded = verifyToken(token);

            // Attach user to the request object
            req.user = {
                sub: decoded.sub,
                role: decoded.role,
            };

            next();
        } catch (error) {
            console.error(error);
            throw new ApiError(401, 'Not authorized, token failed');
        }
    }

    if (!token) {
        throw new ApiError(401, 'Not authorized, no token');
    }
});

const requireAdmin = (req, res, next) => {
    if (req.user && req.user.role === 'ADMIN') {
        next();
    } else {
        throw new ApiError(403, 'Forbidden: Admin access required');
    }
};

const checkSuspension = async(req , res , next) => {
    const user = await prisma.user.findUnique({
        where: { id: req.user.sub }
    })

    const now = new Date()

    if(user.driverSuspendedUntil && now < user.driverSuspendedUntil) {
        return res.status(403).json({
            message: "Driver suspended" , 
            until: user.driverSuspendedUntil
        })
    }

    if(user.passengerSuspendedUntil && now < user.passengerSuspendedUntil) {
        return res.status(403).json({
            message: "Passenger suspended" , 
            until: user.passengerSuspendedUntil
        })
    }

    next()
}

module.exports = { protect, requireAdmin , checkSuspension };