const prisma = require("../utils/prisma")

const findActiveBanByUserId = async(userId) => {
    const now = new Date()

    return await prisma.blacklist.findFirst({
        where: {
            userId , 
            revokedAt: null ,
            OR: [
                { type: 'PERMANENT' } , 
                {
                    type: 'TEMPORARY' , 
                    expiresAt: { gt: now }
                }
            ]
        }
    })
}

const checkBlacklistBeforeRegister = async(email , nationalIdNumber , phoneNumber) => {
    
    const existingUser = await prisma.user.findFirst({
        where: {
            OR: [
                nationalIdNumber ? { nationalIdNumber } : undefined , 
                phoneNumber ? { phoneNumber } : undefined , 
                email ? { email } : undefined  
            ].filter(Boolean)
        }
    })

    if(!existingUser) {
        return null
    }

    return await findActiveBanByUserId(existingUser.id)
}

module.exports = {
  findActiveBanByUserId,
  checkBlacklistBeforeRegister
}