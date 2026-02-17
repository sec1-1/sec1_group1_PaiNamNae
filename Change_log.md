# Changelog

All notable changes to this project will be documented in this file.

### Ginny421
## [1.2.0] - 2026-02-17
#### Added
    - Add review system (Frontend & Backend)
    - Add create review API
    - Add review summary API (average, total, distribution)
    - Add review tag categories
    - Add review image upload (Cloudinary integration)
    - Add duplicate review prevention
    - Add review filter by tag

#### Changed
    -.env add NUXT_PUBLIC_CLOUDINARY_CLOUD= xxxxx , NUXT_PUBLIC_CLOUDINARY_PRESET= xxxxxxxx
    -server.js add Main API Routes (reviews,drivers)
    -schema.prisma add model Review , enum ReviewTag
