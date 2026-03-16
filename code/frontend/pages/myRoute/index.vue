<template>
    <div>
        <div class="px-4 py-8 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900">คำขอจองเส้นทางของฉัน</h2>
                <p class="mt-2 text-gray-600">ดูและจัดการคำขอจองจากผู้โดยสารในเส้นทางที่คุณสร้าง</p>
            </div>

            <div class="p-6 mb-8 bg-white border border-gray-300 rounded-lg shadow-md">
                <div class="flex flex-wrap gap-2">
                    <button v-for="tab in tabs" :key="tab.status" @click="activeTab = tab.status"
                        :class="['tab-button px-4 py-2 rounded-md font-medium', { 'active': activeTab === tab.status }]">
                        {{ tab.label }} ({{ getTripCount(tab.status) }})
                    </button>
                </div>
            </div>

            <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
                <div class="lg:col-span-2">
                    <div class="bg-white border border-gray-300 rounded-lg shadow-md">
                        <div class="p-6 border-b border-gray-300">
                            <h3 class="text-lg font-semibold text-gray-900">
                                {{ activeTab === 'myRoutes' ? 'เส้นทางของฉัน' : 'รายการคำขอจอง' }}
                            </h3>
                        </div>

                        <div v-if="isLoading" class="p-12 text-center text-gray-500">
                            <p>กำลังโหลดข้อมูล...</p>
                        </div>

                        <!-- ===== แท็บ: เส้นทางของฉัน ===== -->
                        <div v-else-if="activeTab === 'myRoutes'" class="divide-y divide-gray-200">
                            <div v-if="myRoutes.length === 0" class="p-12 text-center text-gray-500">
                                <p>ยังไม่มีเส้นทางที่คุณสร้าง</p>
                            </div>

                            <div v-for="route in myRoutes" :key="route.id"
                                class="p-6 transition-colors duration-200 cursor-pointer trip-card hover:bg-gray-50"
                                @click="toggleTripDetails(route.id)">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-lg font-semibold text-gray-900">
                                                {{ route.origin }} → {{ route.destination }}
                                            </h4>
                                            <span class="status-badge" :class="{
                                                'status-confirmed': route.status === 'available',
                                                'status-pending': route.status === 'full',
                                            }">
                                                {{ route.status === 'available' ? 'เปิดรับผู้โดยสาร' : 'เต็ม' }}
                                            </span>
                                        </div>
                                        <p class="mt-1 text-sm text-gray-600">
                                            วันที่: {{ route.date }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เวลา: {{ route.time }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            ระยะเวลา: {{ route.durationText }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            ระยะทาง: {{ route.distanceText }}
                                        </p>
                                        <div class="mt-1 text-sm text-gray-600">
                                            <span class="font-medium">ที่นั่งว่าง:</span>
                                            <span class="ml-1">{{ route.availableSeats }}</span>
                                            <span class="mx-2 text-gray-300">|</span>
                                            <span class="font-medium">ราคาต่อที่นั่ง:</span>
                                            <span class="ml-1">{{ route.pricePerSeat }} บาท</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- รายละเอียดเมื่อเปิด -->
                                <div v-if="selectedTripId === route.id"
                                    class="pt-4 mt-4 mb-5 duration-300 border-t border-gray-300 animate-in slide-in-from-top">
                                    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">รายละเอียดเส้นทาง</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li>
                                                    • จุดเริ่มต้น:
                                                    <span class="font-medium text-gray-900">{{ route.origin }}</span>
                                                    <span v-if="route.originAddress"> — {{ route.originAddress }}</span>
                                                </li>

                                                <template v-if="route.stops && route.stops.length">
                                                    <li class="mt-2 text-gray-700">• จุดแวะระหว่างทาง ({{
                                                        route.stops.length }} จุด):</li>
                                                    <li v-for="(stop, idx) in route.stops" :key="idx">  - จุดแวะ {{ idx
                                                        + 1 }}: {{ stop }}</li>
                                                </template>

                                                <li class="mt-1">
                                                    • จุดปลายทาง:
                                                    <span class="font-medium text-gray-900">{{ route.destination
                                                    }}</span>
                                                    <span v-if="route.destinationAddress"> — {{ route.destinationAddress
                                                    }}</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">รายละเอียดรถ</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li v-for="detail in route.carDetails" :key="detail">• {{ detail }}</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="mt-4 space-y-4">
                                        <div v-if="route.conditions">
                                            <h5 class="mb-2 font-medium text-gray-900">เงื่อนไขการเดินทาง</h5>
                                            <p
                                                class="p-3 text-sm text-gray-700 border border-gray-300 rounded-md bg-gray-50">
                                                {{ route.conditions }}
                                            </p>
                                        </div>

                                        <div v-if="route.photos && route.photos.length > 0">
                                            <h5 class="mb-2 font-medium text-gray-900">รูปภาพรถยนต์</h5>
                                            <div class="grid grid-cols-3 gap-2 mt-2">
                                                <div v-for="(photo, index) in route.photos.slice(0, 3)" :key="index">
                                                    <img :src="photo" alt="Vehicle photo"
                                                        class="object-cover w-full transition-opacity rounded-lg shadow-sm cursor-pointer aspect-video hover:opacity-90" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- ผู้โดยสารของเส้นทางนี้ -->
                                        <div v-if="route.passengers && route.passengers.length">
                                            <h5 class="mb-2 font-medium text-gray-900">ผู้โดยสาร ({{
                                                route.passengers.length }} คน)</h5>
                                            <div class="space-y-3">
                                                <div v-for="p in route.passengers" :key="p.id"
                                                    class="flex items-center space-x-3">
                                                    <img :src="p.image" :alt="p.name"
                                                        class="object-cover w-12 h-12 rounded-full" />
                                                    <div class="flex-1">
                                                        <div class="flex items-center">
                                                            <span class="font-medium text-gray-900">{{ p.name }}</span>
                                                            <div v-if="p.isVerified"
                                                                class="relative group ml-1.5 flex items-center">
                                                                <svg class="w-4 h-4 text-blue-600" viewBox="0 0 24 24"
                                                                    fill="currentColor">
                                                                    <path fill-rule="evenodd"
                                                                        d="M8.603 3.799A4.49 4.49 0 0112 2.25c1.357 0 2.573.6 3.397 1.549a4.49 4.49 0 013.498 1.307 4.491 4.491 0 011.307 3.497A4.49 4.49 0 0121.75 12c0 1.357-.6 2.573-1.549 3.397a4.49 4.49 0 01-1.307 3.498 4.491 4.491 0 01-3.497 1.307A4.49 4.49 0 0112 21.75a4.49 4.49 0 01-3.397-1.549 4.49 4.49 0 01-3.498-1.306 4.491 4.491 0 01-1.307-3.498A4.49 4.49 0 012.25 12c0-1.357.6-2.573 1.549-3.397a4.49 4.49 0 011.307-3.497 4.49 4.49 0 013.497-1.307zm7.007 6.387a.75.75 0 10-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 00-1.06 1.06l2.25 2.25a.75.75 0 001.07-.01l3.5-4.875z"
                                                                        clip-rule="evenodd" />
                                                                </svg>
                                                            </div>
                                                        </div>
                                                        <div class="text-sm text-gray-600">
                                                            ที่นั่ง: {{ p.seats }}
                                                            <span v-if="p.email" class="mx-2 text-gray-300">|</span>
                                                            <a v-if="p.email" :href="`mailto:${p.email}`"
                                                                class="text-blue-600 hover:underline" @click.stop>
                                                                {{ p.email }}
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- รายงานปัญหาเส้นทาง (คนขับ) -->
                                        <div class="p-4 border border-gray-200 rounded-lg bg-gray-50">
                                            <div class="flex items-start justify-between gap-4">
                                                <div class="flex-1">
                                                    <h5 class="text-sm font-semibold text-gray-900">รายงานปัญหาเส้นทาง</h5>
                                                    <p class="mt-1 text-xs text-gray-600">
                                                        ใช้สำหรับแจ้งเหตุให้แอดมินและติดตามสถานะการตรวจสอบ
                                                    </p>
                                                    <div class="mt-2 text-xs text-gray-700">
                                                        <span class="font-medium">สถานะ:</span>
                                                        <span class="ml-1 status-badge status-pending"
                                                            v-if="!route.hasReport">ยังไม่เคยรายงาน</span>
                                                        <span class="ml-1 status-badge status-confirmed"
                                                            v-else>{{ getReportStatusText(route.reportData?.status || 'PENDING') }}</span>
                                                    </div>
                                                    <div v-if="route.hasReport && route.reportData" class="mt-2 text-xs text-gray-600">
                                                        <span class="font-medium">ประเภท:</span>
                                                        <span class="ml-1">{{ getCategoryText(route.reportData.category) }}</span>
                                                    </div>
                                                </div>
                                                <div class="shrink-0">
                                                    <button v-if="route.status === 'completed' && !route.hasReport"
                                                        @click.stop="openDriverReportModal(route)"
                                                        class="px-4 py-2 text-xs font-semibold text-white bg-red-600 rounded-md hover:bg-red-700">
                                                        รายงานปัญหา
                                                    </button>
                                                    <button v-else-if="route.hasReport"
                                                        @click.stop="openDriverReportStatusModal(route)"
                                                        class="px-4 py-2 text-xs font-semibold text-blue-600 border border-blue-200 rounded-md hover:bg-blue-50">
                                                        ดูสถานะรายงาน
                                                    </button>
                                                    <div v-else class="text-[11px] text-gray-500">
                                                        รายงานได้หลังจบทริป
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- ปุ่มขวาล่าง -->
                                <div class="flex justify-end" :class="{ 'mt-4': selectedTripId !== route.id }">
                                    <NuxtLink
                                        v-if="route.status !== 'completed'"
                                        :to="`/myRoute/${route.id}/edit`"
                                        class="px-4 py-2 text-sm text-white transition duration-200 bg-blue-600 rounded-md hover:bg-blue-700"
                                        @click.stop>
                                        แก้ไขเส้นทาง
                                    </NuxtLink>

                                    <button
                                        v-if="route.status === 'available'"
                                        @click.stop="startTrip(route)"
                                        class="px-4 py-2 ml-2 text-sm text-white bg-orange-500 rounded-md hover:bg-orange-600">
                                        เริ่มทริป
                                    </button>
                                    <button
                                        v-if="route.status === 'in_transit'"
                                        @click.stop="openCompleteModal(route)"
                                        class="px-4 py-2 ml-2 text-sm text-white bg-green-600 rounded-md hover:bg-green-700">
                                        จบทริป
                                    </button>

                                </div>
                            </div>
                        </div>

                        <!-- ===== แท็บ: คำขอจอง (เดิม) ===== -->
                        <div v-else class="divide-y divide-gray-200">
                            <div v-if="filteredTrips.length === 0" class="p-12 text-center text-gray-500">
                                <p>ไม่พบรายการในหมวดหมู่นี้</p>
                            </div>

                            <div v-for="trip in filteredTrips" :key="trip.id"
                                class="p-6 transition-colors duration-200 cursor-pointer trip-card hover:bg-gray-50"
                                @click="toggleTripDetails(trip.id)">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-lg font-semibold text-gray-900">
                                                {{ trip.origin }} → {{ trip.destination }}
                                            </h4>
                                            <span v-if="trip.status === 'pending'"
                                                class="status-badge status-pending">รอดำเนินการ</span>
                                            <span v-else-if="trip.status === 'confirmed'"
                                                class="status-badge status-confirmed">ยืนยันแล้ว</span>
                                            <span v-else-if="trip.status === 'rejected'"
                                                class="status-badge status-rejected">ปฏิเสธ</span>
                                            <span v-else-if="trip.status === 'cancelled'"
                                                class="status-badge status-cancelled">ยกเลิก</span>
                                                <span v-else-if="trip.status === 'completed'"
      class="status-badge status-completed">
      จบทริปแล้ว 
</span>

                                        </div>
                                        <p class="mt-1 text-sm text-gray-600">จุดนัดพบ: {{ trip.pickupPoint }}</p>
                                        <p class="text-sm text-gray-600">
                                            วันที่: {{ trip.date }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เวลา: {{ trip.time }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            ระยะเวลา: {{ trip.durationText }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            ระยะทาง: {{ trip.distanceText }}
                                        </p>
                                        <div v-if="activeTab === 'cancelled' && trip.status === 'cancelled' && trip.cancelReason"
                                            class="p-2 mt-2 border border-gray-200 rounded-md bg-gray-50">
                                            <span class="text-sm text-gray-700">
                                                เหตุผลการยกเลิกของผู้โดยสาร:
                                                <span class="font-medium">{{ reasonLabel(trip.cancelReason) }}</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex items-center mb-4 space-x-4">
                                    <img :src="trip.passenger.image" :alt="trip.passenger.name"
                                        class="object-cover rounded-full w-15 h-15" />
                                    <div class="flex-1">
                                        <div class="flex items-center">
                                            <h5 class="font-medium text-gray-900">{{ trip.passenger.name }}</h5>

                                            <div v-if="trip.passenger.isVerified"
                                                class="relative group ml-1.5 flex items-center">
                                                <svg class="w-5 h-5 text-blue-600" viewBox="0 0 24 24"
                                                    fill="currentColor">
                                                    <path fill-rule="evenodd"
                                                        d="M8.603 3.799A4.49 4.49 0 0112 2.25c1.357 0 2.573.6 3.397 1.549a4.49 4.49 0 013.498 1.307 4.491 4.491 0 011.307 3.497A4.49 4.49 0 0121.75 12c0 1.357-.6 2.573-1.549 3.397a4.49 4.49 0 01-1.307 3.498 4.491 4.491 0 01-3.497 1.307A4.49 4.49 0 0112 21.75a4.49 4.49 0 01-3.397-1.549 4.49 4.49 0 01-3.498-1.306 4.491 4.491 0 01-1.307-3.498A4.49 4.49 0 012.25 12c0-1.357.6-2.573 1.549-3.397a4.49 4.49 0 011.307-3.497 4.49 4.49 0 013.497-1.307zm7.007 6.387a.75.75 0 10-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 00-1.06 1.06l2.25 2.25a.75.75 0 001.07-.01l3.5-4.875z"
                                                        clip-rule="evenodd" />
                                                </svg>
                                                <span
                                                    class="absolute px-2 py-1 mb-2 text-xs text-white transition-opacity -translate-x-1/2 bg-gray-800 rounded-md opacity-0 pointer-events-none bottom-full left-1/2 w-max group-hover:opacity-100">
                                                    ผู้โดยสารยืนยันตัวตนแล้ว
                                                </span>
                                            </div>
                                        </div>

                                        <div class="flex">
                                            <p v-if="trip.passenger.email" class="text-xs text-gray-500 mt-0.5">
                                                อีเมล:
                                                <a :href="`mailto:${trip.passenger.email}`"
                                                    class="text-blue-600 hover:underline" @click.stop>
                                                    {{ trip.passenger.email }}
                                                </a>
                                            </p>
                                            <button v-if="trip.passenger.email"
                                                class="inline-flex items-center ml-1 text-gray-500 rounded hover:text-gray-700 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                                title="คัดลอกอีเมล" aria-label="คัดลอกอีเมล"
                                                @click.stop="copyEmail(trip.passenger.email)">
                                                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M8 7h8a2 2 0 012 2v8a2 2 0 01-2 2H8a2 2 0 01-2-2V9a2 2 0 012-2z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M16 7V5a2 2 0 00-2-2H8a2 2 0 00-2 2v2" />
                                                </svg>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-lg font-bold text-blue-600">{{ trip.price }} บาท</div>
                                        <div class="text-sm text-gray-600">จำนวน {{ trip.seats }} ที่นั่ง</div>
                                    </div>
                                </div>

                                <!-- รายละเอียดเส้นทาง + จุดแวะ -->
                                <div v-if="selectedTripId === trip.id"
                                    class="pt-4 mt-4 mb-5 duration-300 border-t border-gray-300 animate-in slide-in-from-top">
                                    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">รายละเอียดเส้นทาง</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li>
                                                    • จุดเริ่มต้น:
                                                    <span class="font-medium text-gray-900">{{ trip.origin }}</span>
                                                    <span v-if="trip.originAddress"> — {{ trip.originAddress }}</span>
                                                </li>

                                                <template v-if="trip.stops && trip.stops.length">
                                                    <li class="mt-2 text-gray-700">• จุดแวะระหว่างทาง ({{
                                                        trip.stops.length }} จุด):</li>
                                                    <li v-for="(stop, idx) in trip.stops" :key="idx">  - จุดแวะ {{ idx +
                                                        1 }}: {{ stop }}</li>
                                                </template>

                                                <li class="mt-1">
                                                    • จุดปลายทาง:
                                                    <span class="font-medium text-gray-900">{{ trip.destination
                                                    }}</span>
                                                    <span v-if="trip.destinationAddress"> — {{ trip.destinationAddress
                                                    }}</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">รายละเอียดรถ</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li v-for="detail in trip.carDetails" :key="detail">• {{ detail }}</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="mt-4 space-y-4">
                                        <div v-if="trip.conditions">
                                            <h5 class="mb-2 font-medium text-gray-900">เงื่อนไขการเดินทาง</h5>
                                            <p
                                                class="p-3 text-sm text-gray-700 border border-gray-300 rounded-md bg-gray-50">
                                                {{ trip.conditions }}
                                            </p>
                                        </div>
                                        <div v-if="trip.photos && trip.photos.length > 0">
                                            <h5 class="mb-2 font-medium text-gray-900">รูปภาพรถยนต์</h5>
                                            <div class="grid grid-cols-3 gap-2 mt-2">
                                                <div v-for="(photo, index) in trip.photos.slice(0, 3)" :key="index">
                                                    <img :src="photo" alt="Vehicle photo"
                                                        class="object-cover w-full transition-opacity rounded-lg shadow-sm cursor-pointer aspect-video hover:opacity-90" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                    <div class="flex justify-end space-x-3" :class="{ 'mt-4': selectedTripId !== trip.id }">
                                        <template v-if="trip.status === 'pending'">
                                            <button @click.stop="openConfirmModal(trip, 'confirm')"
                                                class="px-4 py-2 text-sm text-white transition duration-200 bg-blue-600 rounded-md hover:bg-blue-700">
                                                ยืนยันคำขอ
                                            </button>
                                        <button @click.stop="openConfirmModal(trip, 'reject')"
                                            class="px-4 py-2 text-sm text-red-600 transition duration-200 border border-red-300 rounded-md hover:bg-red-50">
                                            ปฏิเสธ
                                        </button>
                                    </template>

                                    <button v-else-if="trip.status === 'confirmed'"
                                        class="px-4 py-2 text-sm text-white transition duration-200 bg-blue-600 rounded-md hover:bg-blue-700">
                                        แชทกับผู้โดยสาร
                                    </button>

                                    <button v-else-if="['rejected', 'cancelled'].includes(trip.status)"
                                        @click.stop="openConfirmModal(trip, 'delete')"
                                        class="px-4 py-2 text-sm text-gray-600 transition duration-200 border border-gray-300 rounded-md hover:bg-gray-50">
                                        ลบรายการ
                                    </button>

                                    <template v-else-if="trip.status === 'completed'">
                                        <button v-if="!getRouteForTrip(trip)?.hasReport"
                                            @click.stop="openDriverReportModal(getRouteForTrip(trip) || { id: trip.routeId, origin: trip.origin, destination: trip.destination, status: 'completed' })"
                                            class="px-4 py-2 text-sm font-semibold text-white bg-red-600 rounded-md hover:bg-red-700">
                                            รายงานปัญหา
                                        </button>
                                        <button v-else
                                            @click.stop="openDriverReportStatusModal(getRouteForTrip(trip))"
                                            class="px-4 py-2 text-sm font-semibold text-blue-600 border border-blue-200 rounded-md hover:bg-blue-50">
                                            ดูสถานะรายงาน
                                        </button>
                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- แผนที่ -->
                <div class="lg:col-span-1">
                    <div class="sticky overflow-hidden bg-white border border-gray-300 rounded-lg shadow-md top-8">
                        <div class="p-3 border-gray-300">
                            <h3 class="text-lg font-semibold text-gray-900">แผนที่เส้นทาง </h3>
                            <p class="mt-1 text-sm text-gray-600">
                                {{ selectedLabel ? selectedLabel : 'คลิกที่รายการเพื่อดูเส้นทาง' }}
                            </p>
                        </div>
                        <div ref="mapContainer" id="map"></div>
                    </div>
                </div>
            </div>
        </div>

        <ConfirmModal :show="isModalVisible" :title="modalContent.title" :message="modalContent.message"
            :confirmText="modalContent.confirmText" :variant="modalContent.variant" @confirm="handleConfirmAction"
            @cancel="closeConfirmModal" />

            <!-- Driver Report Modal -->
        <div v-if="showDriverReportModal" class="fixed inset-0 z-50 flex items-start justify-center p-4 overflow-y-auto bg-black/50 backdrop-blur-sm sm:items-center"
            @click.self="closeDriverReportModal">
            <div class="w-full max-w-lg p-6 bg-white rounded-xl shadow-2xl animate-in slide-in-from-top duration-300 max-h-[calc(100vh-2rem)] overflow-y-auto">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-xl font-bold text-red-600 leading-tight flex items-center">
                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                        รายงานปัญหาเส้นทาง
                    </h3>
                    <button @click="closeDriverReportModal" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                <!-- Category Selection -->
                <div class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">เลือกหัวข้อปัญหาที่พบ <span class="text-red-500">*</span></label>
                    <div class="flex flex-wrap gap-2">
                        <button
                            v-for="opt in driverReportCategoryOptions"
                            :key="opt.value"
                            type="button"
                            @click="toggleDriverReportCategory(opt.value)"
                            class="px-3 py-2 text-sm font-medium transition border rounded-lg"
                            :class="driverReportCategories.includes(opt.value)
                                ? 'bg-white text-red-600 border-red-600'
                                : 'bg-white text-gray-700 border-gray-200 hover:border-red-300 hover:text-red-600'"
                        >
                            {{ opt.label }}
                        </button>
                    </div>
                    <p class="mt-2 text-xs text-gray-500">
                        เลือกได้มากกว่า 1 หัวข้อ (เลือกแล้ว {{ driverReportCategories.length }} หัวข้อ)
                    </p>
                </div>

                <!-- Passenger Selection (when PASSENGER_ISSUE) -->
                <div v-if="driverReportCategories.includes('PASSENGER_ISSUE')" class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">ระบุผู้โดยสารที่เกี่ยวข้อง</label>
                    <select v-model="driverReportPassengerId"
                        class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                        <option value="">-- เลือกผู้โดยสาร --</option>
                        <option v-if="!reportedRoute?.passengers?.length" value="" disabled>ไม่พบผู้โดยสารในทริปนี้</option>
                        <option v-for="p in (reportedRoute?.passengers || [])" :key="p.id" :value="p.userId" :disabled="!p.userId">
                            {{ p.name }} ({{ p.seats }} ที่นั่ง)
                        </option>
                    </select>
                    <p v-if="!reportedRoute?.passengers?.length" class="mt-2 text-xs text-red-500">
                        ไม่พบข้อมูลผู้โดยสารของทริปนี้
                    </p>
                </div>

                <!-- Report Text -->
                <div class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">รายละเอียดปัญหาที่พบ <span class="text-red-500">*</span></label>
                    <textarea v-model="driverReportText" rows="5" maxlength="501"
                        placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."
                        class="w-full px-4 py-3 leading-relaxed border border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent resize-none transition-all placeholder-gray-400"></textarea>
                    <p class="mt-2 text-xs text-right text-gray-500">
                        {{ driverReportText.length }}/501
                    </p>
                </div>

                

                <!-- Media Upload -->
                <div class="mb-6">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">
                        หลักฐานรูป วิดีโอ หรือเสียง (ถ้ามี)
                        <span class="font-normal text-gray-400">(สูงสุดอย่างละ 3 ไฟล์, ไฟล์ละไม่เกิน 50MB)</span>
                    </label>
                    <div class="flex flex-wrap gap-3">
                        <div v-for="(img, idx) in driverReportImages" :key="`img-${idx}`" class="relative w-24 h-24 group">
                            <img :src="img.url" class="object-cover w-full h-full rounded-lg border border-gray-100 shadow-sm" />
                            <button @click="removeDriverReportImage(idx)"
                                class="absolute -top-2 -right-2 p-1 bg-red-500 text-white rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>

                        <div v-for="(vid, idx) in driverReportVideos" :key="`vid-${idx}`" class="relative w-24 h-24 group">
                            <video :src="vid.url" controls class="object-cover w-full h-full rounded-lg border border-gray-100 shadow-sm"></video>
                            <button @click="removeDriverReportVideo(idx)"
                                class="absolute -top-2 -right-2 p-1 bg-red-500 text-white rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>

                        <div v-for="(audio, idx) in driverReportAudios" :key="`aud-${idx}`" class="relative p-2 bg-white border border-gray-200 shadow-sm rounded-lg w-56 group">
                            <div class="mb-1 text-xs font-medium text-gray-600 truncate">{{ audio.file.name }}</div>
                            <audio :src="audio.url" controls class="w-full"></audio>
                            <button @click="removeDriverReportAudio(idx)"
                                class="absolute -top-2 -right-2 p-1 bg-red-500 text-white rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>

                        <label v-if="driverReportImages.length < DRIVER_REPORT_MAX_IMAGES || driverReportVideos.length < DRIVER_REPORT_MAX_VIDEOS || driverReportAudios.length < DRIVER_REPORT_MAX_AUDIOS"
                            class="flex flex-col items-center justify-center w-24 h-24 border-2 border-dashed border-gray-200 rounded-lg cursor-pointer hover:border-red-400 hover:bg-red-50 transition-all text-gray-400 hover:text-red-500">
                            <svg class="w-8 h-8 mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                            </svg>
                            <span class="text-[10px] font-medium">เพิ่มไฟล์</span>
                            <input type="file" class="hidden" @change="handleDriverReportFiles" accept="image/*,video/*,audio/*" multiple />
                        </label>
                    </div>
                    <p class="mt-2 text-xs text-gray-500 italic">ลำดับความสำคัญ: การแจ้งข้อมูลเท็จอาจส่งผลต่อการถูกระงับบัญชีผู้ใช้งาน</p>
                </div>
            <div class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">ลิงก์ (ถ้ามี)</label>
                    <div class="flex flex-col gap-2 sm:flex-row">
                        <button
                            type="button"
                            class="px-4 py-2 text-sm font-medium text-blue-700 transition border border-blue-200 rounded-lg bg-blue-50 hover:bg-blue-100"
                            @click="toggleDriverReportLinkInput"
                        >
                            {{ showDriverReportLinkInput ? 'ซ่อนช่องแนบลิงก์' : 'แนบลิงก์' }}
                        </button>
                        <input
                            v-if="showDriverReportLinkInput"
                            v-model.trim="driverReportAttachedLink"
                            type="url"
                            placeholder="https://example.com"
                            class="flex-1 px-3 py-2 text-sm border border-gray-300 rounded-lg focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
                        />
                    </div>
                    <p v-if="driverReportLinkError" class="mt-1 text-xs text-red-600">{{ driverReportLinkError }}</p>
                </div>
                <div class="flex gap-3">
                    <button @click="closeDriverReportModal"
                        class="flex-1 px-4 py-3 text-sm font-bold text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 transition-colors">
                        ยกเลิก
                    </button>
                    <button @click="submitDriverReport"
                        :disabled="!driverReportCategories.length || !driverReportText.trim()"
                        :class="(!driverReportCategories.length || !driverReportText.trim()) ? 'bg-gray-300 text-gray-400 cursor-not-allowed' : 'bg-red-600 text-white hover:bg-red-700 shadow-lg shadow-red-200 active:scale-[0.98]'"
                        class="flex-[2] px-4 py-3 text-sm font-bold rounded-lg transition-all">
                        ส่งรายงาน
                    </button>
                </div>
            </div>
        </div>

        <!-- Driver Report Status Modal -->
        <div v-if="showDriverReportStatusModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40"
            @click.self="closeDriverReportStatusModal">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-in">
                <div class="border-b border-gray-200 bg-white p-6 text-black">
                    <div class="flex items-center justify-between mb-3">
                        <h2 class="text-xl font-bold">ติดตามสถานะรายงาน</h2>
                        <button @click="closeDriverReportStatusModal" class="text-gray-500 hover:text-black transition">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>

                <div class="p-0 overflow-y-auto max-h-[70vh]">
                    <div v-if="reportedRouteData" class="p-6 space-y-6">
                        <ReportStatusCard :status="reportedRouteData.status || 'PENDING'" />

                        <div class="bg-blue-50 border border-blue-200 rounded-xl p-5 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
                                <h4 class="font-bold text-blue-900">สรุปการรายงาน</h4>
                                <span
                                    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold shadow-sm"
                                    :class="{
                                        'bg-yellow-100 text-yellow-800 border border-yellow-200': (reportedRouteData.status || 'PENDING') === 'PENDING',
                                        'bg-green-100 text-green-800 border border-green-200': ['APPROVED', 'RESOLVED'].includes(reportedRouteData.status),
                                        'bg-red-100 text-red-800 border border-red-200': reportedRouteData.status === 'REJECTED'
                                    }"
                                >
                                    {{ getReportStatusText(reportedRouteData.status || 'PENDING') }}
                                </span>
                            </div>

                            <div class="space-y-3 text-sm text-blue-800">
                                <div class="flex justify-between border-b border-blue-100 pb-2 gap-2">
                                    <span class="opacity-75">เส้นทาง:</span>
                                    <span class="font-semibold text-right">{{ reportedRoute?.origin || '-' }} → {{ reportedRoute?.destination || '-' }}</span>
                                </div>
                                <div class="flex justify-between border-b border-blue-100 pb-2 gap-2">
                                    <span class="opacity-75">หัวข้อข้อปัญหา:</span>
                                    <span class="font-semibold text-right">{{ getCategoryText(reportedRouteData.category) }}</span>
                                </div>
                                <div class="flex justify-between border-b border-blue-100 pb-2 gap-2">
                                    <span class="opacity-75">วันที่แจ้ง:</span>
                                    <span class="font-semibold text-right">{{ reportedRouteData.createdAt ? dayjs(reportedRouteData.createdAt).format('D MMM BBBB HH:mm น.') : '-' }}</span>
                                </div>
                                <div class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">รายละเอียดที่แจ้ง:</span>
                                    <p class="text-gray-700 bg-white/60 p-3 rounded-lg border border-blue-100 italic leading-relaxed">
                                        "{{ getDriverReportDetailText(reportedRouteData.description) }}"
                                    </p>
                                </div>
                                <div v-if="getDriverReportLink(reportedRouteData.description)" class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">ลิงก์ที่แนบ:</span>
                                    <a
                                        :href="getDriverReportLink(reportedRouteData.description)"
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        class="block break-all text-blue-700 hover:text-blue-800 underline bg-white/60 p-3 rounded-lg border border-blue-100"
                                    >
                                        {{ getDriverReportLink(reportedRouteData.description) }}
                                    </a>
                                </div>
                                <div v-if="(reportedRouteData.images?.length || reportedRouteData.videos?.length)" class="pt-2">
                                    <span class="opacity-75 block mb-2 font-medium">ไฟล์ประกอบ:</span>
                                    <div class="flex flex-wrap gap-2">
                                        <img v-if="reportedRouteData.images"
                                            v-for="(img, idx) in reportedRouteData.images" :key="`img-${idx}`" :src="img"
                                            class="w-20 h-20 object-cover rounded-lg border-2 border-white shadow-sm hover:scale-105 transition-transform cursor-pointer"
                                            @click="window.open(img, '_blank')"
                                        />
                                        <video v-if="reportedRouteData.videos"
                                            v-for="(vid, idx) in reportedRouteData.videos" :key="`vid-${idx}`" :src="vid"
                                            class="w-20 h-20 object-cover rounded-lg border-2 border-white shadow-sm hover:scale-105 transition-transform cursor-pointer" controls
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white border border-gray-200 rounded-xl p-5 shadow-sm">
                            <h4 class="font-bold text-gray-900 mb-3 flex items-center gap-2">
                                <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 013 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                                </svg>
                                การตอบรับจากทีมงาน
                            </h4>
                            <div v-if="(reportedRouteData.status || 'PENDING') !== 'PENDING'" class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                                <p class="text-sm text-gray-700 leading-relaxed italic">
                                    "{{ reportedRouteData.adminNotes || 'ได้รับการตรวจสอบเรียบร้อยแล้ว' }}"
                                </p>
                                <div v-if="reportedRouteData.resolvedAt" class="mt-3 pt-3 border-t border-gray-200 flex justify-between items-center text-[10px] text-gray-400">
                                    <span>ตรวจสอบเมื่อ: {{ dayjs(reportedRouteData.resolvedAt).format('D MMM BBBB HH:mm') }}</span>
                                    <span class="text-green-600 font-bold tracking-wider">VERIFIED BY TEAM</span>
                                </div>
                            </div>
                            <div v-else class="flex flex-col items-center py-6 text-center">
                                <div class="w-12 h-12 bg-yellow-50 rounded-full flex items-center justify-center mb-3">
                                    <svg class="w-6 h-6 text-yellow-500 animate-pulse" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <p class="text-sm text-gray-500">รายงานของคุณกำลังรอการตรวจสอบ<br>เราจะเร่งดำเนินการให้เร็วที่สุด</p>
                            </div>
                            <div class="mt-4 p-3 bg-blue-50 border border-blue-100 rounded-lg text-xs text-blue-800 text-center">
                                หากปัญหานี้ได้รับการแก้ไขแล้ว หรือต้องการให้ข้อมูลเพิ่มเติม<br>สามารถติดต่อแอดมินได้ที่ <strong>admin@example.com</strong>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                    <button @click="closeDriverReportStatusModal"
                        class="w-full px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-all shadow-md active:scale-95">
                        ปิด
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import dayjs from 'dayjs'
import 'dayjs/locale/th'
import buddhistEra from 'dayjs/plugin/buddhistEra'
import ConfirmModal from '~/components/ConfirmModal.vue'
import { useToast } from '~/composables/useToast'

dayjs.locale('th')
dayjs.extend(buddhistEra)

const { $api } = useNuxtApp()
const { toast } = useToast()

// --- State Management ---
const activeTab = ref('pending')
const selectedTripId = ref(null)
const isLoading = ref(false)
const mapContainer = ref(null)
const allTrips = ref([])
const myRoutes = ref([])

// --- Driver Report Modal State ---
const showDriverReportModal = ref(false)
const showDriverReportStatusModal = ref(false)
const reportedRoute = ref(null)
const reportedRouteData = ref(null)
const driverReportCategories = ref([])
const driverReportText = ref('')
const driverReportImages = ref([])
const driverReportVideos = ref([])
const driverReportAudios = ref([])
const driverReportPassengerId = ref('')
const driverReportAttachedLink = ref('')
const showDriverReportLinkInput = ref(false)
const driverReportLinkError = ref('')

const DRIVER_REPORT_MAX_IMAGES = 3
const DRIVER_REPORT_MAX_VIDEOS = 3
const DRIVER_REPORT_MAX_AUDIOS = 3
const DRIVER_REPORT_MAX_FILE_SIZE = 50 * 1024 * 1024
const DRIVER_REPORT_MAX_COMMENT_LENGTH = 501

const driverReportCategoryOptions = [
    { value: 'VEHICLE_ISSUE', label: 'ปัญหาเกี่ยวกับรถ' },
    { value: 'PASSENGER_ISSUE', label: 'พฤติกรรมผู้โดยสาร' },
    { value: 'ROAD_ISSUE', label: 'การเดินทาง' },
    { value: 'SAFETY_ISSUE', label: 'ความปลอดภัย' },
    { value: 'PAYMENT_ISSUE', label: 'การชำระเงิน' },
    { value: 'OTHER', label: 'อื่นๆ' }
]

// ---------- Google Maps states ----------
let gmap = null
let activePolyline = null
let startMarker = null
let endMarker = null
let geocoder = null
let placesService = null
const mapReady = ref(false)
const GMAPS_CB = '__gmapsReady__'
// NEW: เก็บหมุดจุดแวะ
let stopMarkers = []

const tabs = [
    { status: 'pending', label: 'รอดำเนินการ' },
    { status: 'confirmed', label: 'ยืนยันแล้ว' },
    { status: 'rejected', label: 'ปฏิเสธ' },
    { status: 'cancelled', label: 'ยกเลิก' },
    { status: 'all', label: 'ทั้งหมด' },
    { status: 'myRoutes', label: 'เส้นทางของฉัน' },
    { status: 'completed', label: 'จบทริปแล้ว' },

]

definePageMeta({ middleware: 'auth' })

// --- Helpers ---
function cleanAddr(a) {
    return (a || '')
        .replace(/,?\s*(Thailand|ไทย|ประเทศ)\s*$/i, '')
        .replace(/\s{2,}/g, ' ')
        .trim()
}

const reasonLabelMap = {
    CHANGE_OF_PLAN: 'เปลี่ยนแผน/มีธุระกะทันหัน',
    FOUND_ALTERNATIVE: 'พบวิธีเดินทางอื่นแล้ว',
    DRIVER_DELAY: 'คนขับล่าช้าหรือเลื่อนเวลา',
    PRICE_ISSUE: 'ราคาหรือค่าใช้จ่ายไม่เหมาะสม',
    WRONG_LOCATION: 'เลือกจุดรับ–ส่งผิด',
    DUPLICATE_OR_WRONG_DATE: 'จองซ้ำหรือจองผิดวัน',
    SAFETY_CONCERN: 'กังวลด้านความปลอดภัย',
    WEATHER_OR_FORCE_MAJEURE: 'สภาพอากาศ/เหตุสุดวิสัย',
    COMMUNICATION_ISSUE: 'สื่อสารไม่สะดวก/ติดต่อไม่ได้',
}
function reasonLabel(v) { return reasonLabelMap[v] || v }

// --- Computed ---
const filteredTrips = computed(() => {
    if (activeTab.value === 'all') return allTrips.value
    return allTrips.value.filter(trip => trip.status === activeTab.value)
})

// สำหรับหัวข้อบนแผนที่
const selectedLabel = computed(() => {
    if (activeTab.value === 'myRoutes') {
        const r = myRoutes.value.find(x => x.id === selectedTripId.value)
        return r ? `${r.origin} → ${r.destination}` : null
    }
    const t = allTrips.value.find(x => x.id === selectedTripId.value)
    return t ? `${t.origin} → ${t.destination}` : null
})

// --- Methods ---
async function fetchMyRoutes() {
    isLoading.value = true
    try {
        const routes = await $api('/routes/me')

        const allowedRouteStatuses = new Set(['AVAILABLE', 'FULL', 'IN_TRANSIT','COMPLETED' ])

        const formatted = []
        const ownRoutes = []

        for (const r of routes) {
            const carDetailsList = []
            const routeStatus = String(r.status || '').toUpperCase()
            if (!allowedRouteStatuses.has(routeStatus)) continue

            if (r.vehicle) {
                carDetailsList.push(`${r.vehicle.vehicleModel} (${r.vehicle.vehicleType})`)
                if (Array.isArray(r.vehicle.amenities) && r.vehicle.amenities.length > 0) {
                    carDetailsList.push(...r.vehicle.amenities)
                }
            } else {
                carDetailsList.push('ไม่มีข้อมูลรถ')
            }

            const start = r.startLocation
            const end = r.endLocation
            const coords = [[start.lat, start.lng], [end.lat, end.lng]]

            // stops / stopsCoords จาก waypoints
            const wp = r.waypoints || {}
            const baseList = (Array.isArray(wp.used) && wp.used.length
                ? wp.used
                : Array.isArray(wp.requested) ? wp.requested : [])
            const orderedList = (Array.isArray(wp.optimizedOrder) && wp.optimizedOrder.length === baseList.length)
                ? wp.optimizedOrder.map(i => baseList[i])
                : baseList

            const stops = orderedList.map(p => {
                const name = p?.name || ''
                const address = cleanAddr(p?.address || '')
                const fallback = (p?.lat != null && p?.lng != null) ? `(${p.lat.toFixed(6)}, ${p.lng.toFixed(6)})` : ''
                const title = name || fallback
                return address ? `${title} — ${address}` : title
            }).filter(Boolean)

            const stopsCoords = orderedList
                .map(p => (p && typeof p.lat === 'number' && typeof p.lng === 'number')
                    ? { lat: p.lat, lng: p.lng, name: p.name || '', address: p.address || '' }
                    : null
                )
                .filter(Boolean)

            // แปลงเป็น "คำขอจอง" ต่อ booking
            for (const b of (r.bookings || [])) {
                const bookingStatus = (b.status || '').toLowerCase()
                const routeStatusLower = (r.status || '').toLowerCase()
                formatted.push({
                    id: b.id,
                    routeId: r.id,
                    status: routeStatusLower === 'completed'
            ? 'completed'
            : bookingStatus,
                    
                    origin: start?.name || `(${Number(start.lat).toFixed(2)}, ${Number(start.lng).toFixed(2)})`,
                    destination: end?.name || `(${Number(end.lat).toFixed(2)}, ${Number(end.lng).toFixed(2)})`,
                    originHasName: !!start?.name,
                    destinationHasName: !!end?.name,
                    pickupPoint: b.pickupLocation?.name || '-',
                    date: dayjs(r.departureTime).format('D MMMM BBBB'),
                    time: dayjs(r.departureTime).format('HH:mm น.'),
                    price: (r.pricePerSeat || 0) * (b.numberOfSeats || 0),
                    seats: b.numberOfSeats || 0,
                    passenger: {
                        name: `${b.passenger?.firstName || ''} ${b.passenger?.lastName || ''}`.trim() || 'ผู้โดยสาร',
                        image: b.passenger?.profilePicture || `https://ui-avatars.com/api/?name=${encodeURIComponent(b.passenger?.firstName || 'P')}&background=random&size=64`,
                        email: b.passenger?.email || '',
                        isVerified: !!b.passenger?.isVerified,
                        rating: 4.5,
                        reviews: Math.floor(Math.random() * 50) + 5,
                    },
                    coords,
                    polyline: r.routePolyline || null,
                    stops,
                    stopsCoords,
                    cancelReason: b.cancelReason || null,
                    carDetails: carDetailsList,
                    conditions: r.conditions,
                    photos: r.vehicle?.photos || [],
                    originAddress: start?.address ? cleanAddr(start.address) : null,
                    destinationAddress: end?.address ? cleanAddr(end.address) : null,
                    durationText: (typeof r.duration === 'string' ? formatDuration(r.duration) : r.duration) || (r.durationSeconds ? `${Math.round(r.durationSeconds / 60)} นาที` : '-'),
                    distanceText: (typeof r.distance === 'string' ? formatDistance(r.distance) : r.distance) || (r.distanceMeters ? `${(r.distanceMeters / 1000).toFixed(1)} กม.` : '-'),
                })
            }

            // เก็บ “เส้นทางของฉัน”
            const confirmedBookings = (r.bookings || []).filter(
                b => (b.status || '').toUpperCase() === 'CONFIRMED'
            )
            ownRoutes.push({
                id: r.id,
                status: (r.status || '').toLowerCase(),
                hasReport: false,
                reportData: null,
                origin: start?.name || `(${Number(start.lat).toFixed(2)}, ${Number(start.lng).toFixed(2)})`,
                destination: end?.name || `(${Number(end.lat).toFixed(2)}, ${Number(end.lng).toFixed(2)})`,
                originAddress: start?.address ? cleanAddr(start.address) : null,
                destinationAddress: end?.address ? cleanAddr(end.address) : null,
                date: dayjs(r.departureTime).format('D MMMM BBBB'),
                time: dayjs(r.departureTime).format('HH:mm น.'),
                pricePerSeat: r.pricePerSeat || 0,
                availableSeats: r.availableSeats ?? 0,
                coords: [[start.lat, start.lng], [end.lat, end.lng]],
                polyline: r.routePolyline || null,
                stops,
                stopsCoords,
                carDetails: (r.vehicle
                    ? [`${r.vehicle.vehicleModel} (${r.vehicle.vehicleType})`, ...(r.vehicle.amenities || [])]
                    : ['ไม่มีข้อมูลรถ']),
                photos: r.vehicle?.photos || [],
                conditions: r.conditions || '',
                passengers: confirmedBookings.map(b => ({
                    id: b.id,
                    userId: b.passenger?.id || null,
                    seats: b.numberOfSeats || 0,
                    status: 'confirmed',
                    name: `${b.passenger?.firstName || ''} ${b.passenger?.lastName || ''}`.trim() || 'ผู้โดยสาร',
                    image: b.passenger?.profilePicture || `https://ui-avatars.com/api/?name=${encodeURIComponent(b.passenger?.firstName || 'P')}&background=random&size=64`,
                    email: b.passenger?.email || '',
                    isVerified: !!b.passenger?.isVerified,
                    rating: 4.5,
                    reviews: Math.floor(Math.random() * 50) + 5,
                })),
                durationText: (typeof r.duration === 'string' ? formatDuration(r.duration) : r.duration) || (r.durationSeconds ? `${Math.round(r.durationSeconds / 60)} นาที` : '-'),
                distanceText: (typeof r.distance === 'string' ? formatDistance(r.distance) : r.distance) || (r.distanceMeters ? `${(r.distanceMeters / 1000).toFixed(1)} กม.` : '-'),
            })
        }

        allTrips.value = formatted
        myRoutes.value = ownRoutes
        await checkReportsForRoutes()

        // รอแผนที่พร้อม แล้ว reverse เฉพาะกรณีที่ backend ไม่มี name (เฉพาะ list คำขอจอง)
        await waitMapReady()
        const jobs = allTrips.value.map(async (t, idx) => {
            const [o, d] = await Promise.all([
                reverseGeocode(t.coords[0][0], t.coords[0][1]),
                reverseGeocode(t.coords[1][0], t.coords[1][1])
            ])
            const oParts = await extractNameParts(o)
            const dParts = await extractNameParts(d)
            if (!allTrips.value[idx].originHasName && oParts.name) {
                allTrips.value[idx].origin = oParts.name
            }
            if (!allTrips.value[idx].destinationHasName && dParts.name) {
                allTrips.value[idx].destination = dParts.name
            }
        })
        await Promise.allSettled(jobs)

    } catch (error) {
        console.error('Failed to fetch routes:', error)
        allTrips.value = []
        myRoutes.value = []
        toast.error('เกิดข้อผิดพลาด', error?.data?.message || 'ไม่สามารถโหลดข้อมูลได้')
    } finally {
        isLoading.value = false
    }
}

function getRouteForTrip(trip) {
    if (!trip?.routeId) return null
    return myRoutes.value.find(r => r.id === trip.routeId) || null
}

const getTripCount = (status) => {
    if (status === 'all') return allTrips.value.length
    if (status === 'myRoutes') return myRoutes.value.length
    return allTrips.value.filter(trip => trip.status === status).length
}

const toggleTripDetails = (id) => {
    // หา item ตามแท็บที่เปิดอยู่ เพื่ออัปเดตแผนที่
    const item = activeTab.value === 'myRoutes'
        ? myRoutes.value.find(r => r.id === id)
        : allTrips.value.find(t => t.id === id)
    if (item) updateMap(item)

    selectedTripId.value = (selectedTripId.value === id) ? null : id
}

// --- Driver Report Modal Functions ---
function openDriverReportModal(route) {
    reportedRoute.value = route
    driverReportCategories.value = []
    driverReportText.value = ''
    driverReportPassengerId.value = ''
    driverReportAttachedLink.value = ''
    showDriverReportLinkInput.value = false
    driverReportLinkError.value = ''
    driverReportImages.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportVideos.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportAudios.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportImages.value = []
    driverReportVideos.value = []
    driverReportAudios.value = []
    showDriverReportModal.value = true
}

function toggleDriverReportCategory(value) {
    if (!value) return
    if (driverReportCategories.value.includes(value)) {
        driverReportCategories.value = driverReportCategories.value.filter(v => v !== value)
    } else {
        driverReportCategories.value = [...driverReportCategories.value, value]
    }

    if (!driverReportCategories.value.includes('PASSENGER_ISSUE')) {
        driverReportPassengerId.value = ''
    }
}

function openDriverReportStatusModal(route) {
    reportedRoute.value = route
    reportedRouteData.value = route.reportData
    showDriverReportStatusModal.value = true
}

function closeDriverReportStatusModal() {
    showDriverReportStatusModal.value = false
}

function closeDriverReportModal() {
    showDriverReportModal.value = false
    driverReportImages.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportVideos.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportAudios.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportImages.value = []
    driverReportVideos.value = []
    driverReportAudios.value = []
    setTimeout(() => { reportedRoute.value = null }, 200)
}

function handleDriverReportFiles(e) {
    const files = Array.from(e.target.files || [])
    files.forEach((f) => {
        if (f.size > DRIVER_REPORT_MAX_FILE_SIZE) {
            toast.error('ขนาดไฟล์ต้องไม่เกิน 50MB')
            return
        }

        if (f.type.startsWith('image/')) {
            if (driverReportImages.value.length >= DRIVER_REPORT_MAX_IMAGES) {
                toast.error(`เพิ่มรูปได้สูงสุด ${DRIVER_REPORT_MAX_IMAGES} รูป`)
                return
            }
            driverReportImages.value.push({ file: f, url: URL.createObjectURL(f) })
            return
        }

        if (f.type.startsWith('video/')) {
            if (driverReportVideos.value.length >= DRIVER_REPORT_MAX_VIDEOS) {
                toast.error(`เพิ่มวิดีโอได้สูงสุด ${DRIVER_REPORT_MAX_VIDEOS} วิดีโอ`)
                return
            }
            driverReportVideos.value.push({ file: f, url: URL.createObjectURL(f) })
            return
        }

        if (f.type.startsWith('audio/')) {
            if (driverReportAudios.value.length >= DRIVER_REPORT_MAX_AUDIOS) {
                toast.error(`เพิ่มเสียงได้สูงสุด ${DRIVER_REPORT_MAX_AUDIOS} ไฟล์`)
                return
            }
            driverReportAudios.value.push({ file: f, url: URL.createObjectURL(f) })
            return
        }

        toast.error('กรุณาเลือกไฟล์รูป วิดีโอ หรือเสียงเท่านั้น')
    })
    e.target.value = ''
}

function removeDriverReportImage(idx) {
    const it = driverReportImages.value[idx]
    if (it?.url) URL.revokeObjectURL(it.url)
    driverReportImages.value.splice(idx, 1)
}

function removeDriverReportVideo(idx) {
    const it = driverReportVideos.value[idx]
    if (it?.url) URL.revokeObjectURL(it.url)
    driverReportVideos.value.splice(idx, 1)
}

function removeDriverReportAudio(idx) {
    const it = driverReportAudios.value[idx]
    if (it?.url) URL.revokeObjectURL(it.url)
    driverReportAudios.value.splice(idx, 1)
}

function toggleDriverReportLinkInput() {
    showDriverReportLinkInput.value = !showDriverReportLinkInput.value
    if (!showDriverReportLinkInput.value) {
        driverReportAttachedLink.value = ''
        driverReportLinkError.value = ''
    }
}

function isValidUrl(url) {
    try {
        const parsed = new URL(url)
        return parsed.protocol === 'http:' || parsed.protocol === 'https:'
    } catch {
        return false
    }
}

async function submitDriverReport() {
    if (!reportedRoute.value) return
    if (!driverReportCategories.value.length) {
        toast.error('กรุณาเลือกหัวข้อปัญหา', 'กรุณาเลือกหัวข้อปัญหาที่พบ')
        return
    }
    const allowedCats = new Set(driverReportCategoryOptions.map(opt => opt.value))
    if (driverReportCategories.value.some(cat => !allowedCats.has(cat))) {
        toast.error('หัวข้อปัญหาไม่ถูกต้อง', 'กรุณาเลือกหัวข้อที่ระบบรองรับ')
        return
    }
    if (driverReportCategories.value.includes('PASSENGER_ISSUE') && !driverReportPassengerId.value) {
        toast.error('กรุณาระบุผู้โดยสาร', 'เลือกผู้โดยสารที่เกี่ยวข้องก่อนส่งรายงาน')
        return
    }
    if (!driverReportText.value.trim()) {
        toast.error('กรุณากรอกรายละเอียด', 'กรุณาระบุรายละเอียดปัญหาที่พบก่อนส่งรายงาน')
        return
    }
    if (driverReportText.value.length > DRIVER_REPORT_MAX_COMMENT_LENGTH) {
        toast.error('รายละเอียดยาวเกินไป', `รายละเอียดต้องไม่เกิน ${DRIVER_REPORT_MAX_COMMENT_LENGTH} ตัวอักษร`)
        return
    }

    if (driverReportAttachedLink.value && !isValidUrl(driverReportAttachedLink.value)) {
        driverReportLinkError.value = 'กรุณากรอกลิงก์ให้ถูกต้อง (ต้องขึ้นต้นด้วย http:// หรือ https://)'
        return
    }
    driverReportLinkError.value = ''

    try {
        const fd = new FormData()
        fd.append('type', 'DRIVER')
        const primaryCategory = driverReportCategories.value[0]
        const selectedCategoryLabels = driverReportCategoryOptions
            .filter(opt => driverReportCategories.value.includes(opt.value))
            .map(opt => opt.label)
        fd.append('category', primaryCategory)

        const detailText = driverReportText.value.trim()
        const categorySummary = `หัวข้อที่เลือก: ${selectedCategoryLabels.join(', ')}`
        const finalDescription = driverReportAttachedLink.value
            ? `${categorySummary}\n${detailText}\n\nลิงก์: ${driverReportAttachedLink.value}`
            : `${categorySummary}\n${detailText}`
        fd.append('description', finalDescription)
        fd.append('routeId', reportedRoute.value.id)
        if (driverReportPassengerId.value) {
            fd.append('targetUserId', driverReportPassengerId.value)
        }
        driverReportImages.value.forEach((it) => {
            if (it.file) fd.append('images', it.file)
        })
        driverReportVideos.value.forEach((it) => {
            if (it.file) fd.append('videos', it.file)
        })
        driverReportAudios.value.forEach((it) => {
            if (it.file) fd.append('audios', it.file)
        })

        await $api('/reports', { method: 'POST', body: fd })
        toast.success('ขอบคุณที่แจ้งรายงาน', 'ทีมงานจะตรวจสอบในเร็วๆ นี้')

        // update route in place
        const routeInList = myRoutes.value.find(r => r.id === reportedRoute.value.id)
        if (routeInList) {
            routeInList.hasReport = true
            routeInList.reportData = { 
                status: 'PENDING', 
                category: primaryCategory,
                description: finalDescription,
                createdAt: new Date(),
                adminNotes: null 
            }
        }

        closeDriverReportModal()
        checkReportsForRoutes() // background sync
    } catch (err) {
        console.error('Failed to submit driver report', err)
        toast.error('ไม่สามารถส่งรายงานได้', err?.data?.message || 'โปรดลองอีกครั้ง')
    }
}

async function checkReportsForRoutes() {
    // Get all reports made by current user
    try {
        const res = await $api('/reports/me')
        const reports = res.data || res || []
        
        // Match reports with routes
        myRoutes.value.forEach(route => {
            const report = reports.find(r => r.routeId === route.id && r.type === 'DRIVER')
            if (report) {
                route.hasReport = true
                route.reportData = report
            } else {
                route.hasReport = false
                route.reportData = null
            }
        })
    } catch (e) {
        console.error('Failed to check reports for routes', e)
    }
}

function getReportStatusText(status) {
    const reportStatus = {
        PENDING: 'รอการตรวจสอบ',
        APPROVED: 'รับเรื่องแล้ว',
        REJECTED: 'ไม่พบปัญหา',
        RESOLVED: 'ดำเนินการแก้ไขแล้ว'
    }
    return reportStatus[status] || 'ไม่ทราบสถานะ'
}

function getCategoryText(cat) {
    const cats = {
        VEHICLE_ISSUE: 'ปัญหาสภาพรถ/ข้อมูลรถไม่ตรง',
        PASSENGER_ISSUE: 'พฤติกรรมไม่เหมาะสม',
        ROAD_ISSUE: 'ปัญหาระหว่างเส้นทาง',
        SAFETY_ISSUE: 'ความปลอดภัย/พฤติกรรม',
        PAYMENT_ISSUE: 'ปัญหาการชำระเงิน',
        LATE_ISSUE: 'ความล่าช้า',
        WRONG_INFO: 'ข้อมูลไม่ตรงตามที่ระบุ',
        APP_ISSUE: 'ปัญหาการใช้งานแอปพลิเคชัน',
        NO_SHOW: 'ผู้โดยสารไม่มาพบตามจุดนัดหมาย',
        OTHER: 'อื่น ๆ'
    }
    return cats[cat] || cat || 'ทั่วไป'
}

function getDriverReportLink(description) {
    if (!description) return ''
    const linkLine = String(description)
        .split('\n')
        .map(line => line.trim())
        .find(line => line.startsWith('ลิงก์:'))
    if (!linkLine) return ''
    return linkLine.replace('ลิงก์:', '').trim()
}

function getDriverReportDetailText(description) {
    if (!description) return '-'
    return String(description)
        .split('\n')
        .filter(line => !line.trim().startsWith('ลิงก์:'))
        .join('\n')
        .trim() || '-'
}

// ---------- Google Maps helpers ----------
function waitMapReady() {
    return new Promise((resolve) => {
        if (mapReady.value) return resolve(true)
        const t = setInterval(() => {
            if (mapReady.value) { clearInterval(t); resolve(true) }
        }, 50)
    })
}

function reverseGeocode(lat, lng) {
    return new Promise((resolve) => {
        if (!geocoder) return resolve(null)
        geocoder.geocode({ location: { lat, lng } }, (results, status) => {
            if (status !== 'OK' || !results?.length) return resolve(null)
            resolve(results[0])
        })
    })
}

async function extractNameParts(geocodeResult) {
    if (!geocodeResult) return { name: null, area: null }
    const comps = geocodeResult.address_components || []
    const types = geocodeResult.types || []
    const isPoi = types.includes('point_of_interest') || types.includes('establishment') || types.includes('premise')

    let name = null
    if (isPoi && geocodeResult.place_id) {
        const poiName = await getPlaceName(geocodeResult.place_id)
        if (poiName) name = poiName
    }
    if (!name) {
        const streetNumber = comps.find(c => c.types.includes('street_number'))?.long_name
        const route = comps.find(c => c.types.includes('route'))?.long_name
        name = (streetNumber && route) ? `${streetNumber} ${route}` : (route || geocodeResult.formatted_address || null)
    }
    if (name) name = name.replace(/,?\s*(Thailand|ไทย)\s*$/i, '')
    return { name }
}

function getPlaceName(placeId) {
    return new Promise((resolve) => {
        if (!placesService || !placeId) return resolve(null)
        placesService.getDetails({ placeId, fields: ['name'] }, (place, status) => {
            if (status === google.maps.places.PlacesServiceStatus.OK && place?.name) resolve(place.name)
            else resolve(null)
        })
    })
}

async function updateMap(trip) {
    if (!trip) return
    await waitMapReady()
    if (!gmap) return

    // cleanup เดิม
    if (activePolyline) { activePolyline.setMap(null); activePolyline = null }
    if (startMarker) { startMarker.setMap(null); startMarker = null }
    if (endMarker) { endMarker.setMap(null); endMarker = null }
    if (stopMarkers.length) {
        stopMarkers.forEach(m => m.setMap(null))
        stopMarkers = []
    }

    const start = { lat: Number(trip.coords[0][0]), lng: Number(trip.coords[0][1]) }
    const end = { lat: Number(trip.coords[1][0]), lng: Number(trip.coords[1][1]) }

    startMarker = new google.maps.Marker({ position: start, map: gmap, label: 'A' })
    endMarker = new google.maps.Marker({ position: end, map: gmap, label: 'B' })

    // หมุดจุดแวะ
    if (Array.isArray(trip.stopsCoords) && trip.stopsCoords.length) {
        stopMarkers = trip.stopsCoords.map((s, idx) => new google.maps.Marker({
            position: { lat: s.lat, lng: s.lng },
            map: gmap,
            icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
            title: s.name || s.address || `จุดแวะ ${idx + 1}`
        }))
    }

    // polyline
    if (trip.polyline && google.maps.geometry?.encoding) {
        const path = google.maps.geometry.encoding.decodePath(trip.polyline)
        activePolyline = new google.maps.Polyline({
            path,
            map: gmap,
            strokeColor: '#2563eb',
            strokeOpacity: 0.9,
            strokeWeight: 5,
        })
        const bounds = new google.maps.LatLngBounds()
        path.forEach(p => bounds.extend(p))
        if (trip.stopsCoords?.length) {
            trip.stopsCoords.forEach(s => bounds.extend(new google.maps.LatLng(s.lat, s.lng)))
        }
        gmap.fitBounds(bounds)
    } else {
        const bounds = new google.maps.LatLngBounds()
        bounds.extend(start)
        bounds.extend(end)
        if (trip.stopsCoords?.length) {
            trip.stopsCoords.forEach(s => bounds.extend(new google.maps.LatLng(s.lat, s.lng)))
        }
        gmap.fitBounds(bounds)
    }
}

// --- Modal ---
const isModalVisible = ref(false)
const tripToAction = ref(null)
const modalContent = ref({ title: '', message: '', confirmText: '', action: null, variant: 'danger' })

const openConfirmModal = (trip, action) => {
    tripToAction.value = trip
    if (action === 'confirm') {
        modalContent.value = {
            title: 'ยืนยันคำขอจอง',
            message: `ยืนยันคำขอของผู้โดยสาร "${trip.passenger.name}" ใช่หรือไม่?`,
            confirmText: 'ยืนยันคำขอ',
            action: 'confirm',
            variant: 'primary',
        }
    } else if (action === 'reject') {
        modalContent.value = {
            title: 'ปฏิเสธคำขอจอง',
            message: `ต้องการปฏิเสธคำขอของ "${trip.passenger.name}" ใช่หรือไม่?`,
            confirmText: 'ปฏิเสธ',
            action: 'reject',
            variant: 'danger',
        }
    } else if (action === 'delete') {
        modalContent.value = {
            title: 'ยืนยันการลบรายการ',
            message: `ต้องการลบคำขอนี้ออกจากรายการใช่หรือไม่?`,
            confirmText: 'ลบรายการ',
            action: 'delete',
            variant: 'danger',
        }
    }
    isModalVisible.value = true
}

const closeConfirmModal = () => {
    isModalVisible.value = false
    tripToAction.value = null
}

const handleConfirmAction = async () => {
    if (!tripToAction.value) return
    const action = modalContent.value.action
    const bookingId = tripToAction.value.id
    try {
        if (action === 'confirm') {
            await $api(`/bookings/${bookingId}/status`, { method: 'PATCH', body: { status: 'CONFIRMED' } })
            toast.success('สำเร็จ', 'ยืนยันคำขอแล้ว')
        } else if (action === 'reject') {
            await $api(`/bookings/${bookingId}/status`, { method: 'PATCH', body: { status: 'REJECTED' } })
            toast.success('สำเร็จ', 'ปฏิเสธคำขอแล้ว')
        } else if (action === 'delete') {
            await $api(`/bookings/${bookingId}`, { method: 'DELETE' })
            toast.success('ลบรายการสำเร็จ', 'ลบคำขอออกจากรายการแล้ว')
        }
        else if (action === 'complete') {

    await $api(`/routes/${tripToAction.value.id}/complete`, {
        method: 'PATCH',
        body: { status: 'COMPLETED' }
    })
    toast.success('สำเร็จ', 'จบทริปเรียบร้อยแล้ว')
}

        closeConfirmModal()
        await fetchMyRoutes()
    } catch (error) {
        console.error(`Failed to ${action} booking:`, error)
        toast.error('เกิดข้อผิดพลาด', error?.data?.message || 'ไม่สามารถดำเนินการได้')
        closeConfirmModal()
    }
}

const copyEmail = async (email) => {
    try {
        await navigator.clipboard.writeText(email)
        toast.success('คัดลอกแล้ว', email)
    } catch (e) {
        toast.error('คัดลอกไม่สำเร็จ', 'ลองใหม่อีกครั้ง')
    }
}

const openCompleteModal = (route) => {
    tripToAction.value = route
    modalContent.value = {
        title: 'จบทริป',
        message: `ต้องการจบเส้นทาง "${route.origin} → ${route.destination}" ใช่หรือไม่?`,
        confirmText: 'จบทริป',
        action: 'complete',
        variant: 'primary',
    }
    isModalVisible.value = true
}


function formatDistance(input) {
    if (typeof input !== 'string') return input
    const parts = input.split('+')
    if (parts.length <= 1) return input

    let meters = 0
    for (const seg of parts) {
        const n = parseFloat(seg.replace(/[^\d.]/g, ''))
        if (Number.isNaN(n)) continue
        if (/กม/.test(seg)) meters += n * 1000
        else if (/เมตร|ม\./.test(seg)) meters += n
        else meters += n
    }

    if (meters >= 1000) {
        const km = Math.round((meters / 1000) * 10) / 10
        return `${(km % 1 === 0 ? km.toFixed(0) : km)} กม.`
    }
    return `${Math.round(meters)} ม.`
}

function formatDuration(input) {
    if (typeof input !== 'string') return input
    const parts = input.split('+')
    if (parts.length <= 1) return input

    let minutes = 0
    for (const seg of parts) {
        const n = parseFloat(seg.replace(/[^\d.]/g, ''))
        if (Number.isNaN(n)) continue
        if (/ชม/.test(seg)) minutes += n * 60
        else minutes += n
    }

    const h = Math.floor(minutes / 60)
    const m = Math.round(minutes % 60)
    return h ? (m ? `${h} ชม. ${m} นาที` : `${h} ชม.`) : `${m} นาที`
}

// --- Lifecycle ---
useHead({
    title: 'คำขอจองเส้นทางของฉัน - ไปนำแหน่',
    script: process.client && !window.google?.maps ? [{
        key: 'gmaps',
        src: `https://maps.googleapis.com/maps/api/js?key=${useRuntimeConfig().public.googleMapsApiKey}&libraries=places,geometry&callback=${GMAPS_CB}`,
        async: true,
        defer: true
    }] : []
})

onMounted(() => {
    if (window.google?.maps) {
        initializeMap()
        fetchMyRoutes().then(() => {
            if (activeTab.value === 'myRoutes') {
                if (myRoutes.value.length) updateMap(myRoutes.value[0])
            } else {
                if (filteredTrips.value.length) updateMap(filteredTrips.value[0])
            }
        })
        return
    }

    window[GMAPS_CB] = () => {
        try { delete window[GMAPS_CB] } catch { }
        initializeMap()
        fetchMyRoutes().then(() => {
            if (activeTab.value === 'myRoutes') {
                if (myRoutes.value.length) updateMap(myRoutes.value[0])
            } else {
                if (filteredTrips.value.length) updateMap(filteredTrips.value[0])
            }
        })
    }
})

function initializeMap() {
    if (!mapContainer.value || gmap) return
    gmap = new google.maps.Map(mapContainer.value, {
        center: { lat: 13.7563, lng: 100.5018 },
        zoom: 6,
        mapTypeControl: false,
        streetViewControl: false,
        fullscreenControl: true,
    })
    geocoder = new google.maps.Geocoder()
    placesService = new google.maps.places.PlacesService(gmap)
    mapReady.value = true
}

watch(activeTab, () => {
    selectedTripId.value = null
    if (activeTab.value === 'myRoutes') {
        if (myRoutes.value.length > 0) updateMap(myRoutes.value[0])
    } else {
        if (filteredTrips.value.length > 0) updateMap(filteredTrips.value[0])
    }
})

const startTrip = async (route) => {
  try {
    await $api(`/routes/${route.id}/start`, {
      method: 'PATCH'
    })

    toast.success("เริ่มทริปแล้ว")

    await fetchMyRoutes()
  } catch (err) {
    toast.error(err?.data?.message || "เริ่มทริปไม่สำเร็จ")
  }
}

</script>

<style scoped>
/* (สไตล์ทั้งหมดคงเดิม) */
.trip-card {
    transition: all 0.3s ease;
    cursor: pointer;
}

.trip-card:hover {
    /* transform: translateY(-2px); */
    box-shadow: 0 10px 25px rgba(59, 130, 246, 0.1);
}

.tab-button {
    transition: all 0.3s ease;
}

.tab-button.active {
    background-color: #3b82f6;
    color: white;
    box-shadow: 0 4px 14px rgba(59, 130, 246, 0.3);
}

.tab-button:not(.active) {
    background-color: white;
    color: #6b7280;
    border: 1px solid #d1d5db;
}

.tab-button:not(.active):hover {
    background-color: #f9fafb;
    color: #374151;
}

#map {
    height: 100%;
    min-height: 600px;
    border-radius: 0 0 0.5rem 0.5rem;
}

.status-badge {
    display: inline-flex;
    align-items: center;
    padding: 0.25rem 0.75rem;
    border-radius: 9999px;
    font-size: 0.875rem;
    font-weight: 500;
}

.status-pending {
    background-color: #fef3c7;
    color: #d97706;
}

.status-confirmed {
    background-color: #d1fae5;
    color: #065f46;
}

.status-rejected {
    background-color: #fee2e2;
    color: #dc2626;
}

.status-cancelled {
    background-color: #f3f4f6;
    color: #6b7280;
}

@keyframes slide-in-from-top {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-in {
    animation-fill-mode: both;
}

.slide-in-from-top {
    animation-name: slide-in-from-top;
}

.duration-300 {
    animation-duration: 300ms;
}

.status-completed {
    background-color: #e0e7ff;
    color: #3730a3;
}

</style>
