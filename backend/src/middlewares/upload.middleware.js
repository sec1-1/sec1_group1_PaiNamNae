const multer = require('multer');
const ApiError = require('../utils/ApiError');

// กำหนดค่า Multer ให้เก็บไฟล์ใน memoryชั่วคราวเพื่อรอส่งต่อไปยัง Cloudinary
const storage = multer.memoryStorage();

const upload = multer({
    storage: storage,
    limits: { fileSize: 10 * 1024 * 1024 }, // ขยายเป็น 10 MB
    fileFilter: (req, file, cb) => {
        // อนุญาตไฟล์รูปภาพและวิดีโอ
        if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
            cb(null, true);
        } else {
            cb(new ApiError(400, 'Only image or video files are allowed!'), false);
        }
    },
});

module.exports = upload;
