<template>
    <div>
        <div class="px-4 py-8 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900">เธเธณเธเธญเธเธญเธเน€เธชเนเธเธ—เธฒเธเธเธญเธเธเธฑเธ</h2>
                <p class="mt-2 text-gray-600">เธ”เธนเนเธฅเธฐเธเธฑเธ”เธเธฒเธฃเธเธณเธเธญเธเธญเธเธเธฒเธเธเธนเนเนเธ”เธขเธชเธฒเธฃเนเธเน€เธชเนเธเธ—เธฒเธเธ—เธตเนเธเธธเธ“เธชเธฃเนเธฒเธ</p>
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
                                {{ activeTab === 'myRoutes' ? 'เน€เธชเนเธเธ—เธฒเธเธเธญเธเธเธฑเธ' : 'เธฃเธฒเธขเธเธฒเธฃเธเธณเธเธญเธเธญเธ' }}
                            </h3>
                        </div>

                        <div v-if="isLoading" class="p-12 text-center text-gray-500">
                            <p>เธเธณเธฅเธฑเธเนเธซเธฅเธ”เธเนเธญเธกเธนเธฅ...</p>
                        </div>

                        <!-- ===== เนเธ—เนเธ: เน€เธชเนเธเธ—เธฒเธเธเธญเธเธเธฑเธ ===== -->
                        <div v-else-if="activeTab === 'myRoutes'" class="divide-y divide-gray-200">
                            <div v-if="myRoutes.length === 0" class="p-12 text-center text-gray-500">
                                <p>เธขเธฑเธเนเธกเนเธกเธตเน€เธชเนเธเธ—เธฒเธเธ—เธตเนเธเธธเธ“เธชเธฃเนเธฒเธ</p>
                            </div>

                            <div v-for="route in myRoutes" :key="route.id"
                                class="p-6 transition-colors duration-200 cursor-pointer trip-card hover:bg-gray-50"
                                @click="toggleTripDetails(route.id)">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-lg font-semibold text-gray-900">
                                                {{ route.origin }} โ’ {{ route.destination }}
                                            </h4>
                                            <span class="status-badge" :class="{
                                                'status-confirmed': route.status === 'available',
                                                'status-pending': route.status === 'full',
                                            }">
<<<<<<< Updated upstream
                                                {{ route.status === 'available' ? 'เปิดรับผู้โดยสาร' : 'เต็ม' }}
=======
                                                {{
                                                    route.status === 'available'
                                                        ? 'เน€เธเธดเธ”เธฃเธฑเธเธเธนเนเนเธ”เธขเธชเธฒเธฃ'
                                                        : route.status === 'completed'
                                                            ? 'เธเธเธ—เธฃเธดเธเนเธฅเนเธง'
                                                            : route.status === 'in_transit'
                                                                ? 'เธเธณเธฅเธฑเธเน€เธ”เธดเธเธ—เธฒเธ'
                                                                : 'เน€เธ•เนเธก'
                                                }}
>>>>>>> Stashed changes
                                            </span>
                                        </div>
                                        <p class="mt-1 text-sm text-gray-600">
                                            เธงเธฑเธเธ—เธตเน: {{ route.date }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เน€เธงเธฅเธฒ: {{ route.time }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เธฃเธฐเธขเธฐเน€เธงเธฅเธฒ: {{ route.durationText }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เธฃเธฐเธขเธฐเธ—เธฒเธ: {{ route.distanceText }}
                                        </p>
                                        <div class="mt-1 text-sm text-gray-600">
                                            <span class="font-medium">เธ—เธตเนเธเธฑเนเธเธงเนเธฒเธ:</span>
                                            <span class="ml-1">{{ route.availableSeats }}</span>
                                            <span class="mx-2 text-gray-300">|</span>
                                            <span class="font-medium">เธฃเธฒเธเธฒเธ•เนเธญเธ—เธตเนเธเธฑเนเธ:</span>
                                            <span class="ml-1">{{ route.pricePerSeat }} เธเธฒเธ—</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เน€เธกเธทเนเธญเน€เธเธดเธ” -->
                                <div v-if="selectedTripId === route.id"
                                    class="pt-4 mt-4 mb-5 duration-300 border-t border-gray-300 animate-in slide-in-from-top">
                                    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เน€เธชเนเธเธ—เธฒเธ</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li>
                                                    โ€ข เธเธธเธ”เน€เธฃเธดเนเธกเธ•เนเธ:
                                                    <span class="font-medium text-gray-900">{{ route.origin }}</span>
                                                    <span v-if="route.originAddress"> โ€” {{ route.originAddress }}</span>
                                                </li>

                                                <template v-if="route.stops && route.stops.length">
                                                    <li class="mt-2 text-gray-700">โ€ข เธเธธเธ”เนเธงเธฐเธฃเธฐเธซเธงเนเธฒเธเธ—เธฒเธ ({{
                                                        route.stops.length }} เธเธธเธ”):</li>
                                                    <li v-for="(stop, idx) in route.stops" :key="idx">โ€โ€- เธเธธเธ”เนเธงเธฐ {{ idx
                                                        + 1 }}: {{ stop }}</li>
                                                </template>

                                                <li class="mt-1">
                                                    โ€ข เธเธธเธ”เธเธฅเธฒเธขเธ—เธฒเธ:
                                                    <span class="font-medium text-gray-900">{{ route.destination
                                                    }}</span>
                                                    <span v-if="route.destinationAddress"> โ€” {{ route.destinationAddress
                                                    }}</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธฃเธ–</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li v-for="detail in route.carDetails" :key="detail">โ€ข {{ detail }}</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="mt-4 space-y-4">
                                        <div v-if="route.conditions">
                                            <h5 class="mb-2 font-medium text-gray-900">เน€เธเธทเนเธญเธเนเธเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ</h5>
                                            <p
                                                class="p-3 text-sm text-gray-700 border border-gray-300 rounded-md bg-gray-50">
                                                {{ route.conditions }}
                                            </p>
                                        </div>

                                        <div v-if="route.photos && route.photos.length > 0">
                                            <h5 class="mb-2 font-medium text-gray-900">เธฃเธนเธเธ เธฒเธเธฃเธ–เธขเธเธ•เน</h5>
                                            <div class="grid grid-cols-3 gap-2 mt-2">
                                                <div v-for="(photo, index) in route.photos.slice(0, 3)" :key="index">
                                                    <img :src="photo" alt="Vehicle photo"
                                                        class="object-cover w-full transition-opacity rounded-lg shadow-sm cursor-pointer aspect-video hover:opacity-90" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- เธเธนเนเนเธ”เธขเธชเธฒเธฃเธเธญเธเน€เธชเนเธเธ—เธฒเธเธเธตเน -->
                                        <div v-if="route.passengers && route.passengers.length">
                                            <h5 class="mb-2 font-medium text-gray-900">เธเธนเนเนเธ”เธขเธชเธฒเธฃ ({{
                                                route.passengers.length }} เธเธ)</h5>
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
                                                            เธ—เธตเนเธเธฑเนเธ: {{ p.seats }}
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

                                        <!-- เธฃเธฒเธขเธเธฒเธเธเธฑเธเธซเธฒเน€เธชเนเธเธ—เธฒเธ (เธเธเธเธฑเธ) -->
                                        <div class="p-4 border border-gray-200 rounded-lg bg-gray-50">
                                            <div class="flex items-start justify-between gap-4">
                                                <div class="flex-1">
                                                    <h5 class="text-sm font-semibold text-gray-900">เธฃเธฒเธขเธเธฒเธเธเธฑเธเธซเธฒเน€เธชเนเธเธ—เธฒเธ</h5>
                                                    <p class="mt-1 text-xs text-gray-600">
                                                        เนเธเนเธชเธณเธซเธฃเธฑเธเนเธเนเธเน€เธซเธ•เธธเนเธซเนเนเธญเธ”เธกเธดเธเนเธฅเธฐเธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธ
                                                    </p>
                                                    <div class="mt-2 text-xs text-gray-700">
                                                        <span class="font-medium">เธชเธ–เธฒเธเธฐ:</span>
                                                        <span class="ml-1 status-badge status-pending"
                                                            v-if="!route.hasReport">เธขเธฑเธเนเธกเนเน€เธเธขเธฃเธฒเธขเธเธฒเธ</span>
                                                        <span class="ml-1 status-badge status-confirmed"
                                                            v-else>{{ getReportStatusText(route.reportData?.status || 'PENDING') }}</span>
                                                    </div>
                                                    <div v-if="route.hasReport && route.reportData" class="mt-2 text-xs text-gray-600">
                                                        <span class="font-medium">เธเธฃเธฐเน€เธ เธ—:</span>
                                                        <span class="ml-1">{{ getCategoryText(route.reportData) }}</span>
                                                    </div>
                                                </div>
<<<<<<< Updated upstream
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
=======
                                                <div class="shrink-0 text-[11px] text-gray-500">
                                                    <span v-if="route.status !== 'completed'">เธฃเธฒเธขเธเธฒเธเนเธ”เนเธซเธฅเธฑเธเธเธเธ—เธฃเธดเธ</span>
                                                    <span v-else>เนเธเนเธเธธเนเธกเธ”เนเธฒเธเธฅเนเธฒเธเน€เธเธทเนเธญเธฃเธฒเธขเธเธฒเธเธซเธฃเธทเธญเธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐ</span>
>>>>>>> Stashed changes
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- เธเธธเนเธกเธเธงเธฒเธฅเนเธฒเธ -->
                                <div class="flex justify-end" :class="{ 'mt-4': selectedTripId !== route.id }">
                                    <NuxtLink
                                        v-if="route.status !== 'completed'"
                                        :to="`/myRoute/${route.id}/edit`"
                                        class="px-4 py-2 text-sm text-white transition duration-200 bg-blue-600 rounded-md hover:bg-blue-700"
                                        @click.stop>
                                        เนเธเนเนเธเน€เธชเนเธเธ—เธฒเธ
                                    </NuxtLink>

                                    <button
                                        v-if="route.status === 'available'"
                                        @click.stop="startTrip(route)"
                                        class="px-4 py-2 ml-2 text-sm text-white bg-orange-500 rounded-md hover:bg-orange-600">
                                        เน€เธฃเธดเนเธกเธ—เธฃเธดเธ
                                    </button>
                                    <button
                                        v-if="route.status === 'in_transit'"
                                        @click.stop="openCompleteModal(route)"
                                        class="px-4 py-2 ml-2 text-sm text-white bg-green-600 rounded-md hover:bg-green-700">
                                        เธเธเธ—เธฃเธดเธ
                                    </button>

<<<<<<< Updated upstream
=======
                                    <button
                                        v-if="route.status === 'completed' && !route.hasReport"
                                        @click.stop="openDriverReportModal(route)"
                                        class="px-4 py-2 ml-2 text-sm font-semibold text-white bg-red-600 rounded-md hover:bg-red-700">
                                        เธฃเธฒเธขเธเธฒเธเธเธฑเธเธซเธฒ
                                    </button>
                                    <button
                                        v-else-if="route.status === 'completed' && route.hasReport"
                                        @click.stop="openDriverReportStatusModal(route)"
                                        class="px-4 py-2 ml-2 text-sm font-semibold text-blue-600 border border-blue-200 rounded-md hover:bg-blue-50">
                                        เธ”เธนเธชเธ–เธฒเธเธฐเธฃเธฒเธขเธเธฒเธ
                                    </button>

>>>>>>> Stashed changes
                                </div>
                            </div>
                        </div>

                        <!-- ===== เนเธ—เนเธ: เธเธณเธเธญเธเธญเธ (เน€เธ”เธดเธก) ===== -->
                        <div v-else class="divide-y divide-gray-200">
                            <div v-if="filteredTrips.length === 0" class="p-12 text-center text-gray-500">
                                <p>เนเธกเนเธเธเธฃเธฒเธขเธเธฒเธฃเนเธเธซเธกเธงเธ”เธซเธกเธนเนเธเธตเน</p>
                            </div>

                            <div v-for="trip in filteredTrips" :key="trip.id"
                                class="p-6 transition-colors duration-200 cursor-pointer trip-card hover:bg-gray-50"
                                @click="toggleTripDetails(trip.id)">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-lg font-semibold text-gray-900">
                                                {{ trip.origin }} โ’ {{ trip.destination }}
                                            </h4>
                                            <span v-if="trip.status === 'pending'"
                                                class="status-badge status-pending">เธฃเธญเธ”เธณเน€เธเธดเธเธเธฒเธฃ</span>
                                            <span v-else-if="trip.status === 'confirmed'"
                                                class="status-badge status-confirmed">เธขเธทเธเธขเธฑเธเนเธฅเนเธง</span>
                                            <span v-else-if="trip.status === 'rejected'"
                                                class="status-badge status-rejected">เธเธเธดเน€เธชเธ</span>
                                            <span v-else-if="trip.status === 'cancelled'"
                                                class="status-badge status-cancelled">เธขเธเน€เธฅเธดเธ</span>
                                                <span v-else-if="trip.status === 'completed'"
      class="status-badge status-completed">
      เธเธเธ—เธฃเธดเธเนเธฅเนเธง 
</span>

                                        </div>
                                        <p class="mt-1 text-sm text-gray-600">เธเธธเธ”เธเธฑเธ”เธเธ: {{ trip.pickupPoint }}</p>
                                        <p class="text-sm text-gray-600">
                                            เธงเธฑเธเธ—เธตเน: {{ trip.date }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เน€เธงเธฅเธฒ: {{ trip.time }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เธฃเธฐเธขเธฐเน€เธงเธฅเธฒ: {{ trip.durationText }}
                                            <span class="mx-2 text-gray-300">|</span>
                                            เธฃเธฐเธขเธฐเธ—เธฒเธ: {{ trip.distanceText }}
                                        </p>
                                        <div v-if="activeTab === 'cancelled' && trip.status === 'cancelled' && trip.cancelReason"
                                            class="p-2 mt-2 border border-gray-200 rounded-md bg-gray-50">
                                            <span class="text-sm text-gray-700">
                                                เน€เธซเธ•เธธเธเธฅเธเธฒเธฃเธขเธเน€เธฅเธดเธเธเธญเธเธเธนเนเนเธ”เธขเธชเธฒเธฃ:
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
                                                    เธเธนเนเนเธ”เธขเธชเธฒเธฃเธขเธทเธเธขเธฑเธเธ•เธฑเธงเธ•เธเนเธฅเนเธง
                                                </span>
                                            </div>
                                        </div>

                                        <div class="flex">
                                            <p v-if="trip.passenger.email" class="text-xs text-gray-500 mt-0.5">
                                                เธญเธตเน€เธกเธฅ:
                                                <a :href="`mailto:${trip.passenger.email}`"
                                                    class="text-blue-600 hover:underline" @click.stop>
                                                    {{ trip.passenger.email }}
                                                </a>
                                            </p>
                                            <button v-if="trip.passenger.email"
                                                class="inline-flex items-center ml-1 text-gray-500 rounded hover:text-gray-700 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                                title="เธเธฑเธ”เธฅเธญเธเธญเธตเน€เธกเธฅ" aria-label="เธเธฑเธ”เธฅเธญเธเธญเธตเน€เธกเธฅ"
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
                                        <div class="text-lg font-bold text-blue-600">{{ trip.price }} เธเธฒเธ—</div>
                                        <div class="text-sm text-gray-600">เธเธณเธเธงเธ {{ trip.seats }} เธ—เธตเนเธเธฑเนเธ</div>
                                    </div>
                                </div>

                                <!-- เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เน€เธชเนเธเธ—เธฒเธ + เธเธธเธ”เนเธงเธฐ -->
                                <div v-if="selectedTripId === trip.id"
                                    class="pt-4 mt-4 mb-5 duration-300 border-t border-gray-300 animate-in slide-in-from-top">
                                    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เน€เธชเนเธเธ—เธฒเธ</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li>
                                                    โ€ข เธเธธเธ”เน€เธฃเธดเนเธกเธ•เนเธ:
                                                    <span class="font-medium text-gray-900">{{ trip.origin }}</span>
                                                    <span v-if="trip.originAddress"> โ€” {{ trip.originAddress }}</span>
                                                </li>

                                                <template v-if="trip.stops && trip.stops.length">
                                                    <li class="mt-2 text-gray-700">โ€ข เธเธธเธ”เนเธงเธฐเธฃเธฐเธซเธงเนเธฒเธเธ—เธฒเธ ({{
                                                        trip.stops.length }} เธเธธเธ”):</li>
                                                    <li v-for="(stop, idx) in trip.stops" :key="idx">โ€โ€- เธเธธเธ”เนเธงเธฐ {{ idx +
                                                        1 }}: {{ stop }}</li>
                                                </template>

                                                <li class="mt-1">
                                                    โ€ข เธเธธเธ”เธเธฅเธฒเธขเธ—เธฒเธ:
                                                    <span class="font-medium text-gray-900">{{ trip.destination
                                                    }}</span>
                                                    <span v-if="trip.destinationAddress"> โ€” {{ trip.destinationAddress
                                                    }}</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <div>
                                            <h5 class="mb-2 font-medium text-gray-900">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธฃเธ–</h5>
                                            <ul class="space-y-1 text-sm text-gray-600">
                                                <li v-for="detail in trip.carDetails" :key="detail">โ€ข {{ detail }}</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="mt-4 space-y-4">
                                        <div v-if="trip.conditions">
                                            <h5 class="mb-2 font-medium text-gray-900">เน€เธเธทเนเธญเธเนเธเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ</h5>
                                            <p
                                                class="p-3 text-sm text-gray-700 border border-gray-300 rounded-md bg-gray-50">
                                                {{ trip.conditions }}
                                            </p>
                                        </div>
                                        <div v-if="trip.photos && trip.photos.length > 0">
                                            <h5 class="mb-2 font-medium text-gray-900">เธฃเธนเธเธ เธฒเธเธฃเธ–เธขเธเธ•เน</h5>
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
                                                เธขเธทเธเธขเธฑเธเธเธณเธเธญ
                                            </button>
                                        <button @click.stop="openConfirmModal(trip, 'reject')"
                                            class="px-4 py-2 text-sm text-red-600 transition duration-200 border border-red-300 rounded-md hover:bg-red-50">
                                            เธเธเธดเน€เธชเธ
                                        </button>
                                    </template>

                                    <button v-else-if="trip.status === 'confirmed'"
                                        class="px-4 py-2 text-sm text-white transition duration-200 bg-blue-600 rounded-md hover:bg-blue-700">
                                        เนเธเธ—เธเธฑเธเธเธนเนเนเธ”เธขเธชเธฒเธฃ
                                    </button>

                                    <button v-else-if="['rejected', 'cancelled'].includes(trip.status)"
                                        @click.stop="openConfirmModal(trip, 'delete')"
                                        class="px-4 py-2 text-sm text-gray-600 transition duration-200 border border-gray-300 rounded-md hover:bg-gray-50">
                                        เธฅเธเธฃเธฒเธขเธเธฒเธฃ
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

                <!-- เนเธเธเธ—เธตเน -->
                <div class="lg:col-span-1">
                    <div class="sticky overflow-hidden bg-white border border-gray-300 rounded-lg shadow-md top-8">
                        <div class="p-3 border-gray-300">
                            <h3 class="text-lg font-semibold text-gray-900">เนเธเธเธ—เธตเนเน€เธชเนเธเธ—เธฒเธ </h3>
                            <p class="mt-1 text-sm text-gray-600">
                                {{ selectedLabel ? selectedLabel : 'เธเธฅเธดเธเธ—เธตเนเธฃเธฒเธขเธเธฒเธฃเน€เธเธทเนเธญเธ”เธนเน€เธชเนเธเธ—เธฒเธ' }}
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
        <div v-if="showDriverReportModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm"
            @click.self="closeDriverReportModal">
            <div class="w-full max-w-lg p-6 bg-white rounded-xl shadow-2xl animate-in slide-in-from-top duration-300">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-xl font-bold text-red-600 leading-tight flex items-center">
                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                        เธฃเธฒเธขเธเธฒเธเธเธฑเธเธซเธฒเน€เธชเนเธเธ—เธฒเธ
                    </h3>
                    <button @click="closeDriverReportModal" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                <!-- Category Selection -->
                <div class="mb-4">
<<<<<<< Updated upstream
                    <label class="block mb-2 text-sm font-semibold text-gray-700">เลือกหัวข้อปัญหาที่พบ</label>
                    <select v-model="driverReportCategory"
                        class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                        <option value="">-- เลือกหัวข้อ --</option>
                        <option value="VEHICLE_ISSUE">ปัญหาสภาพรถ/ข้อมูลรถไม่ตรง</option>
                        <option value="PASSENGER_ISSUE">พฤติกรรมผู้โดยสารที่ไม่เหมาะสม</option>
                        <option value="ROAD_ISSUE">ปัญหาระหว่างเส้นทาง</option>
                        <option value="SAFETY_ISSUE">ความปลอดภัย/พฤติกรรม</option>
                        <option value="PAYMENT_ISSUE">ปัญหาการชำระเงิน/ผู้โดยสารไม่จ่ายเงิน</option>
                        <option value="OTHER">อื่นๆ</option>
                    </select>
                </div>

                <!-- Passenger Selection (when PASSENGER_ISSUE) -->
                <div v-if="driverReportCategory === 'PASSENGER_ISSUE'" class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">ระบุผู้โดยสารที่เกี่ยวข้อง</label>
                    <select v-model="driverReportPassengerId"
                        class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                        <option value="">-- เลือกผู้โดยสาร --</option>
                        <option v-if="!reportedRoute?.passengers?.length" value="" disabled>ไม่พบผู้โดยสารในทริปนี้</option>
                        <option v-for="p in (reportedRoute?.passengers || [])" :key="p.id" :value="p.userId" :disabled="!p.userId">
                            {{ p.name }} ({{ p.seats }} ที่นั่ง)
                        </option>
                    </select>
=======
                    <label class="block mb-2 text-sm font-semibold text-gray-700">เน€เธฅเธทเธญเธเธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒเธ—เธตเนเธเธ <span class="text-red-500">*</span></label>
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
                        เน€เธฅเธทเธญเธเนเธ”เนเธกเธฒเธเธเธงเนเธฒ 1 เธซเธฑเธงเธเนเธญ (เน€เธฅเธทเธญเธเนเธฅเนเธง {{ driverReportCategories.length }} เธซเธฑเธงเธเนเธญ)
                    </p>
                </div>

                <!-- Passenger Selection (when PASSENGER_ISSUE) -->
                <div v-if="driverReportCategories.includes('PASSENGER_ISSUE')" class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">เธฃเธฐเธเธธเธเธนเนเนเธ”เธขเธชเธฒเธฃเธ—เธตเนเน€เธเธตเนเธขเธงเธเนเธญเธ</label>
                    <div v-if="reportedRoute?.passengers?.length" class="max-h-44 overflow-y-auto border border-gray-200 rounded-lg p-2 space-y-2">
                        <label v-for="p in (reportedRoute?.passengers || [])" :key="p.id"
                            class="flex items-center gap-2 px-2 py-1 rounded-md"
                            :class="p.userId ? 'hover:bg-gray-50 cursor-pointer' : 'opacity-60 cursor-not-allowed'">
                            <input
                                type="checkbox"
                                :value="p.userId"
                                v-model="driverReportPassengerIds"
                                :disabled="!p.userId"
                                class="w-4 h-4 text-red-600 border-gray-300 rounded focus:ring-red-500"
                            />
                            <span class="text-sm text-gray-700">
                                {{ p.name }} ({{ p.seats }} เธ—เธตเนเธเธฑเนเธ)
                            </span>
                        </label>
                    </div>
>>>>>>> Stashed changes
                    <p v-if="!reportedRoute?.passengers?.length" class="mt-2 text-xs text-red-500">
                        เนเธกเนเธเธเธเนเธญเธกเธนเธฅเธเธนเนเนเธ”เธขเธชเธฒเธฃเธเธญเธเธ—เธฃเธดเธเธเธตเน
                    </p>
<<<<<<< Updated upstream
=======
                    <p v-else class="mt-2 text-xs text-gray-500">
                        เน€เธฅเธทเธญเธเนเธ”เนเธกเธฒเธเธเธงเนเธฒ 1 เธเธ (เน€เธฅเธทเธญเธเนเธฅเนเธง {{ driverReportPassengerIds.length }} เธเธ)
                    </p>
>>>>>>> Stashed changes
                </div>

                <!-- Report Text -->
                <div class="mb-4">
<<<<<<< Updated upstream
                    <label class="block mb-2 text-sm font-semibold text-gray-700">รายละเอียดปัญหาที่พบ</label>
                    <textarea v-model="driverReportText" rows="5"
                        placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."
=======
                    <label class="block mb-2 text-sm font-semibold text-gray-700">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธเธฑเธเธซเธฒเธ—เธตเนเธเธ <span class="text-red-500">*</span></label>
                    <textarea v-model="driverReportText" rows="5" maxlength="501"
                        placeholder="เนเธเธฃเธ”เธฃเธฐเธเธธเธเธฑเธเธซเธฒเธ—เธตเนเธเธธเธ“เธเธเน€เธเธทเนเธญเนเธซเนเธ—เธตเธกเธเธฒเธเธชเธฒเธกเธฒเธฃเธ–เธ•เธฃเธงเธเธชเธญเธเนเธ”เน..."
>>>>>>> Stashed changes
                        class="w-full px-4 py-3 leading-relaxed border border-gray-200 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent resize-none transition-all placeholder-gray-400"></textarea>
                </div>

                <!-- Image Upload -->
                <div class="mb-6">
<<<<<<< Updated upstream
                    <label class="block mb-2 text-sm font-semibold text-gray-700">หลักฐานรูปภาพประกอบ (สูงสุด 2 รูป)</label>
=======
                    <label class="block mb-2 text-sm font-semibold text-gray-700">
                        เธซเธฅเธฑเธเธเธฒเธเธฃเธนเธ เธงเธดเธ”เธตเนเธญ เธซเธฃเธทเธญเน€เธชเธตเธขเธ (เธ–เนเธฒเธกเธต)
                        <span class="font-normal text-gray-400">(เธชเธนเธเธชเธธเธ”เธญเธขเนเธฒเธเธฅเธฐ 3 เนเธเธฅเน, เนเธเธฅเนเธฅเธฐเนเธกเนเน€เธเธดเธ 50MB)</span>
                    </label>
>>>>>>> Stashed changes
                    <div class="flex flex-wrap gap-3">
                        <div v-for="(img, idx) in driverReportImages" :key="idx" class="relative w-24 h-24 group">
                            <img :src="img.url" class="object-cover w-full h-full rounded-lg border border-gray-100 shadow-sm" />
                            <button @click="removeDriverReportImage(idx)"
                                class="absolute -top-2 -right-2 p-1 bg-red-500 text-white rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>
                        <label v-if="driverReportImages.length < 2"
                            class="flex flex-col items-center justify-center w-24 h-24 border-2 border-dashed border-gray-200 rounded-lg cursor-pointer hover:border-red-400 hover:bg-red-50 transition-all text-gray-400 hover:text-red-500">
                            <svg class="w-8 h-8 mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                            </svg>
<<<<<<< Updated upstream
                            <span class="text-[10px] font-medium">เพิ่มรูป</span>
                            <input type="file" class="hidden" @change="handleDriverReportFiles" accept="image/*" multiple />
=======
                            <span class="text-[10px] font-medium">เน€เธเธดเนเธกเนเธเธฅเน</span>
                            <input type="file" class="hidden" @change="handleDriverReportFiles" accept="image/*,video/*,audio/*" multiple />
>>>>>>> Stashed changes
                        </label>
                    </div>
                    <p class="mt-2 text-xs text-gray-500 italic">เธฅเธณเธ”เธฑเธเธเธงเธฒเธกเธชเธณเธเธฑเธ: เธเธฒเธฃเนเธเนเธเธเนเธญเธกเธนเธฅเน€เธ—เนเธเธญเธฒเธเธชเนเธเธเธฅเธ•เนเธญเธเธฒเธฃเธ–เธนเธเธฃเธฐเธเธฑเธเธเธฑเธเธเธตเธเธนเนเนเธเนเธเธฒเธ</p>
                </div>
<<<<<<< Updated upstream

=======
            <div class="mb-4">
                    <label class="block mb-2 text-sm font-semibold text-gray-700">เธฅเธดเธเธเน (เธ–เนเธฒเธกเธต)</label>
                    <div class="flex flex-col gap-2 sm:flex-row">
                        <button
                            type="button"
                            class="px-4 py-2 text-sm font-medium text-blue-700 transition border border-blue-200 rounded-lg bg-blue-50 hover:bg-blue-100"
                            @click="toggleDriverReportLinkInput"
                        >
                            {{ showDriverReportLinkInput ? 'เธเนเธญเธเธเนเธญเธเนเธเธเธฅเธดเธเธเน' : 'เนเธเธเธฅเธดเธเธเน' }}
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
>>>>>>> Stashed changes
                <div class="flex gap-3">
                    <button @click="closeDriverReportModal"
                        class="flex-1 px-4 py-3 text-sm font-bold text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 transition-colors">
                        เธขเธเน€เธฅเธดเธ
                    </button>
                    <button @click="submitDriverReport"
<<<<<<< Updated upstream
                        class="flex-[2] px-4 py-3 text-sm font-bold text-white bg-red-600 rounded-lg hover:bg-red-700 shadow-lg shadow-red-200 transition-all active:scale-[0.98]">
                        ส่งรายงาน
=======
                        :disabled="!driverReportCategories.length || !driverReportText.trim()"
                        :class="(!driverReportCategories.length || !driverReportText.trim()) ? 'bg-gray-300 text-gray-400 cursor-not-allowed' : 'bg-red-600 text-white hover:bg-red-700 shadow-lg shadow-red-200 active:scale-[0.98]'"
                        class="flex-[2] px-4 py-3 text-sm font-bold rounded-lg transition-all">
                        เธชเนเธเธฃเธฒเธขเธเธฒเธ
>>>>>>> Stashed changes
                    </button>
                </div>
            </div>
        </div>

        <!-- Driver Report Status Modal -->
<<<<<<< Updated upstream
        <div v-if="showDriverReportStatusModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm"
            @click.self="showDriverReportStatusModal = false">
            <div class="w-full max-w-lg p-6 bg-white rounded-xl shadow-2xl animate-in slide-in-from-top duration-300">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-xl font-bold text-blue-600 leading-tight">สถานะรายงาน</h3>
                    <button @click="showDriverReportStatusModal = false" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                <div v-if="reportedRouteData" class="space-y-3">
                    <div class="text-sm text-gray-700">
                        <span class="font-medium">เส้นทาง:</span>
                        <span class="ml-1">{{ reportedRoute?.origin }} → {{ reportedRoute?.destination }}</span>
                    </div>
                    <div class="text-sm text-gray-700">
                        <span class="font-medium">ประเภท:</span>
                        <span class="ml-1">{{ getCategoryText(reportedRouteData.category) }}</span>
                    </div>
                    <div class="text-sm text-gray-700">
                        <span class="font-medium">รายละเอียด:</span>
                        <p class="mt-1 p-3 bg-gray-50 border border-gray-200 rounded-md">
                            {{ reportedRouteData.description || 'ไม่ได้ระบุรายละเอียด' }}
                        </p>
                    </div>
                    <div class="text-sm text-gray-700">
                        <span class="font-medium">สถานะ:</span>
                        <span class="ml-2 status-badge status-confirmed">
                            {{ getReportStatusText(reportedRouteData.status || 'PENDING') }}
                        </span>
                    </div>
                </div>

                <div class="mt-6">
                    <button @click="showDriverReportStatusModal = false"
                        class="w-full px-4 py-3 text-sm font-bold text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 transition-colors">
                        ปิด
=======
        <div v-if="showDriverReportStatusModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40"
            @click.self="closeDriverReportStatusModal">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-in">
                <div class="border-b border-gray-200 bg-white p-6 text-black">
                    <div class="flex items-center justify-between mb-3">
                        <h2 class="text-xl font-bold">เธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐเธฃเธฒเธขเธเธฒเธ</h2>
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
                                <h4 class="font-bold text-blue-900">เธชเธฃเธธเธเธเธฒเธฃเธฃเธฒเธขเธเธฒเธ</h4>
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
                                    <span class="opacity-75">เน€เธชเนเธเธ—เธฒเธ:</span>
                                    <span class="font-semibold text-right">{{ reportedRoute?.origin || '-' }} โ’ {{ reportedRoute?.destination || '-' }}</span>
                                </div>
                                <div class="flex justify-between border-b border-blue-100 pb-2 gap-2">
                                    <span class="opacity-75">เธซเธฑเธงเธเนเธญเธเนเธญเธเธฑเธเธซเธฒ:</span>
                                    <span class="font-semibold text-right">{{ getCategoryText(reportedRouteData) }}</span>
                                </div>
                                <div class="flex justify-between border-b border-blue-100 pb-2 gap-2">
                                    <span class="opacity-75">เธงเธฑเธเธ—เธตเนเนเธเนเธ:</span>
                                    <span class="font-semibold text-right">{{ reportedRouteData.createdAt ? dayjs(reportedRouteData.createdAt).format('D MMM BBBB HH:mm เธ.') : '-' }}</span>
                                </div>
                                <div class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธ—เธตเนเนเธเนเธ:</span>
                                    <p class="text-gray-700 bg-white/60 p-3 rounded-lg border border-blue-100 italic leading-relaxed">
                                        "{{ getDriverReportDetailText(reportedRouteData.description) }}"
                                    </p>
                                </div>
                                <div v-if="getDriverReportLink(reportedRouteData.description)" class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">เธฅเธดเธเธเนเธ—เธตเนเนเธเธ:</span>
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
                                    <span class="opacity-75 block mb-2 font-medium">เนเธเธฅเนเธเธฃเธฐเธเธญเธ:</span>
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
                                เธเธฒเธฃเธ•เธญเธเธฃเธฑเธเธเธฒเธเธ—เธตเธกเธเธฒเธ
                            </h4>
                            <div v-if="(reportedRouteData.status || 'PENDING') !== 'PENDING'" class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                                <p class="text-sm text-gray-700 leading-relaxed italic">
                                    "{{ reportedRouteData.adminNotes || 'เนเธ”เนเธฃเธฑเธเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธเน€เธฃเธตเธขเธเธฃเนเธญเธขเนเธฅเนเธง' }}"
                                </p>
                                <div v-if="reportedRouteData.resolvedAt" class="mt-3 pt-3 border-t border-gray-200 flex justify-between items-center text-[10px] text-gray-400">
                                    <span>เธ•เธฃเธงเธเธชเธญเธเน€เธกเธทเนเธญ: {{ dayjs(reportedRouteData.resolvedAt).format('D MMM BBBB HH:mm') }}</span>
                                    <span class="text-green-600 font-bold tracking-wider">VERIFIED BY TEAM</span>
                                </div>
                            </div>
                            <div v-else class="flex flex-col items-center py-6 text-center">
                                <div class="w-12 h-12 bg-yellow-50 rounded-full flex items-center justify-center mb-3">
                                    <svg class="w-6 h-6 text-yellow-500 animate-pulse" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </div>
                                <p class="text-sm text-gray-500">เธฃเธฒเธขเธเธฒเธเธเธญเธเธเธธเธ“เธเธณเธฅเธฑเธเธฃเธญเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธ<br>เน€เธฃเธฒเธเธฐเน€เธฃเนเธเธ”เธณเน€เธเธดเธเธเธฒเธฃเนเธซเนเน€เธฃเนเธงเธ—เธตเนเธชเธธเธ”</p>
                            </div>
                            <div class="mt-4 p-3 bg-blue-50 border border-blue-100 rounded-lg text-xs text-blue-800 text-center">
                                เธซเธฒเธเธเธฑเธเธซเธฒเธเธตเนเนเธ”เนเธฃเธฑเธเธเธฒเธฃเนเธเนเนเธเนเธฅเนเธง เธซเธฃเธทเธญเธ•เนเธญเธเธเธฒเธฃเนเธซเนเธเนเธญเธกเธนเธฅเน€เธเธดเนเธกเน€เธ•เธดเธก<br>เธชเธฒเธกเธฒเธฃเธ–เธ•เธดเธ”เธ•เนเธญเนเธญเธ”เธกเธดเธเนเธ”เนเธ—เธตเน <strong>admin@example.com</strong>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                    <button @click="closeDriverReportStatusModal"
                        class="w-full px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-all shadow-md active:scale-95">
                        เธเธดเธ”
>>>>>>> Stashed changes
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
const driverReportCategory = ref('')
const driverReportText = ref('')
const driverReportImages = ref([])
<<<<<<< Updated upstream
const driverReportPassengerId = ref('')
=======
const driverReportVideos = ref([])
const driverReportAudios = ref([])
const driverReportPassengerIds = ref([])
const driverReportAttachedLink = ref('')
const showDriverReportLinkInput = ref(false)
const driverReportLinkError = ref('')

const DRIVER_REPORT_MAX_IMAGES = 3
const DRIVER_REPORT_MAX_VIDEOS = 3
const DRIVER_REPORT_MAX_AUDIOS = 3
const DRIVER_REPORT_MAX_FILE_SIZE = 50 * 1024 * 1024
const DRIVER_REPORT_MAX_COMMENT_LENGTH = 501

const driverReportCategoryOptions = [
    { value: 'VEHICLE_ISSUE', label: 'เธเธฑเธเธซเธฒเน€เธเธตเนเธขเธงเธเธฑเธเธฃเธ–' },
    { value: 'PASSENGER_ISSUE', label: 'เธเธคเธ•เธดเธเธฃเธฃเธกเธเธนเนเนเธ”เธขเธชเธฒเธฃ' },
    { value: 'ROAD_ISSUE', label: 'เธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ' },
    { value: 'SAFETY_ISSUE', label: 'เธเธงเธฒเธกเธเธฅเธญเธ”เธ เธฑเธข' },
    { value: 'PAYMENT_ISSUE', label: 'เธเธฒเธฃเธเธณเธฃเธฐเน€เธเธดเธ' },
    { value: 'OTHER', label: 'เธญเธทเนเธเน' }
]
>>>>>>> Stashed changes

// ---------- Google Maps states ----------
let gmap = null
let activePolyline = null
let startMarker = null
let endMarker = null
let geocoder = null
let placesService = null
const mapReady = ref(false)
const GMAPS_CB = '__gmapsReady__'
// NEW: เน€เธเนเธเธซเธกเธธเธ”เธเธธเธ”เนเธงเธฐ
let stopMarkers = []

const tabs = [
    { status: 'pending', label: 'เธฃเธญเธ”เธณเน€เธเธดเธเธเธฒเธฃ' },
    { status: 'confirmed', label: 'เธขเธทเธเธขเธฑเธเนเธฅเนเธง' },
    { status: 'rejected', label: 'เธเธเธดเน€เธชเธ' },
    { status: 'cancelled', label: 'เธขเธเน€เธฅเธดเธ' },
    { status: 'all', label: 'เธ—เธฑเนเธเธซเธกเธ”' },
    { status: 'myRoutes', label: 'เน€เธชเนเธเธ—เธฒเธเธเธญเธเธเธฑเธ' },
    { status: 'completed', label: 'เธเธเธ—เธฃเธดเธเนเธฅเนเธง' },

]

definePageMeta({ middleware: 'auth' })

// --- Helpers ---
function cleanAddr(a) {
    return (a || '')
        .replace(/,?\s*(Thailand|เนเธ—เธข|เธเธฃเธฐเน€เธ—เธจ)\s*$/i, '')
        .replace(/\s{2,}/g, ' ')
        .trim()
}

const reasonLabelMap = {
    CHANGE_OF_PLAN: 'เน€เธเธฅเธตเนเธขเธเนเธเธ/เธกเธตเธเธธเธฃเธฐเธเธฐเธ—เธฑเธเธซเธฑเธ',
    FOUND_ALTERNATIVE: 'เธเธเธงเธดเธเธตเน€เธ”เธดเธเธ—เธฒเธเธญเธทเนเธเนเธฅเนเธง',
    DRIVER_DELAY: 'เธเธเธเธฑเธเธฅเนเธฒเธเนเธฒเธซเธฃเธทเธญเน€เธฅเธทเนเธญเธเน€เธงเธฅเธฒ',
    PRICE_ISSUE: 'เธฃเธฒเธเธฒเธซเธฃเธทเธญเธเนเธฒเนเธเนเธเนเธฒเธขเนเธกเนเน€เธซเธกเธฒเธฐเธชเธก',
    WRONG_LOCATION: 'เน€เธฅเธทเธญเธเธเธธเธ”เธฃเธฑเธโ€“เธชเนเธเธเธดเธ”',
    DUPLICATE_OR_WRONG_DATE: 'เธเธญเธเธเนเธณเธซเธฃเธทเธญเธเธญเธเธเธดเธ”เธงเธฑเธ',
    SAFETY_CONCERN: 'เธเธฑเธเธงเธฅเธ”เนเธฒเธเธเธงเธฒเธกเธเธฅเธญเธ”เธ เธฑเธข',
    WEATHER_OR_FORCE_MAJEURE: 'เธชเธ เธฒเธเธญเธฒเธเธฒเธจ/เน€เธซเธ•เธธเธชเธธเธ”เธงเธดเธชเธฑเธข',
    COMMUNICATION_ISSUE: 'เธชเธทเนเธญเธชเธฒเธฃเนเธกเนเธชเธฐเธ”เธงเธ/เธ•เธดเธ”เธ•เนเธญเนเธกเนเนเธ”เน',
}
function reasonLabel(v) { return reasonLabelMap[v] || v }

// --- Computed ---
const filteredTrips = computed(() => {
    if (activeTab.value === 'all') return allTrips.value
    return allTrips.value.filter(trip => trip.status === activeTab.value)
})

// เธชเธณเธซเธฃเธฑเธเธซเธฑเธงเธเนเธญเธเธเนเธเธเธ—เธตเน
const selectedLabel = computed(() => {
    if (activeTab.value === 'myRoutes') {
        const r = myRoutes.value.find(x => x.id === selectedTripId.value)
        return r ? `${r.origin} โ’ ${r.destination}` : null
    }
    const t = allTrips.value.find(x => x.id === selectedTripId.value)
    return t ? `${t.origin} โ’ ${t.destination}` : null
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
                carDetailsList.push('เนเธกเนเธกเธตเธเนเธญเธกเธนเธฅเธฃเธ–')
            }

            const start = r.startLocation
            const end = r.endLocation
            const coords = [[start.lat, start.lng], [end.lat, end.lng]]

            // stops / stopsCoords เธเธฒเธ waypoints
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
                return address ? `${title} โ€” ${address}` : title
            }).filter(Boolean)

            const stopsCoords = orderedList
                .map(p => (p && typeof p.lat === 'number' && typeof p.lng === 'number')
                    ? { lat: p.lat, lng: p.lng, name: p.name || '', address: p.address || '' }
                    : null
                )
                .filter(Boolean)

            // เนเธเธฅเธเน€เธเนเธ "เธเธณเธเธญเธเธญเธ" เธ•เนเธญ booking
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
                    time: dayjs(r.departureTime).format('HH:mm เธ.'),
                    price: (r.pricePerSeat || 0) * (b.numberOfSeats || 0),
                    seats: b.numberOfSeats || 0,
                    passenger: {
                        name: `${b.passenger?.firstName || ''} ${b.passenger?.lastName || ''}`.trim() || 'เธเธนเนเนเธ”เธขเธชเธฒเธฃ',
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
                    durationText: (typeof r.duration === 'string' ? formatDuration(r.duration) : r.duration) || (r.durationSeconds ? `${Math.round(r.durationSeconds / 60)} เธเธฒเธ—เธต` : '-'),
                    distanceText: (typeof r.distance === 'string' ? formatDistance(r.distance) : r.distance) || (r.distanceMeters ? `${(r.distanceMeters / 1000).toFixed(1)} เธเธก.` : '-'),
                })
            }

            // เน€เธเนเธ โ€เน€เธชเนเธเธ—เธฒเธเธเธญเธเธเธฑเธโ€
            const confirmedBookings = (r.bookings || []).filter(
                b => (b.status || '').toUpperCase() === 'CONFIRMED'
            )
            ownRoutes.push({
                id: r.id,
                status: (r.status || '').toLowerCase(),
                origin: start?.name || `(${Number(start.lat).toFixed(2)}, ${Number(start.lng).toFixed(2)})`,
                destination: end?.name || `(${Number(end.lat).toFixed(2)}, ${Number(end.lng).toFixed(2)})`,
                originAddress: start?.address ? cleanAddr(start.address) : null,
                destinationAddress: end?.address ? cleanAddr(end.address) : null,
                date: dayjs(r.departureTime).format('D MMMM BBBB'),
                time: dayjs(r.departureTime).format('HH:mm เธ.'),
                pricePerSeat: r.pricePerSeat || 0,
                availableSeats: r.availableSeats ?? 0,
                coords: [[start.lat, start.lng], [end.lat, end.lng]],
                polyline: r.routePolyline || null,
                stops,
                stopsCoords,
                carDetails: (r.vehicle
                    ? [`${r.vehicle.vehicleModel} (${r.vehicle.vehicleType})`, ...(r.vehicle.amenities || [])]
                    : ['เนเธกเนเธกเธตเธเนเธญเธกเธนเธฅเธฃเธ–']),
                photos: r.vehicle?.photos || [],
                conditions: r.conditions || '',
                passengers: confirmedBookings.map(b => ({
                    id: b.id,
                    userId: b.passenger?.id || null,
                    seats: b.numberOfSeats || 0,
                    status: 'confirmed',
                    name: `${b.passenger?.firstName || ''} ${b.passenger?.lastName || ''}`.trim() || 'เธเธนเนเนเธ”เธขเธชเธฒเธฃ',
                    image: b.passenger?.profilePicture || `https://ui-avatars.com/api/?name=${encodeURIComponent(b.passenger?.firstName || 'P')}&background=random&size=64`,
                    email: b.passenger?.email || '',
                    isVerified: !!b.passenger?.isVerified,
                    rating: 4.5,
                    reviews: Math.floor(Math.random() * 50) + 5,
                })),
                durationText: (typeof r.duration === 'string' ? formatDuration(r.duration) : r.duration) || (r.durationSeconds ? `${Math.round(r.durationSeconds / 60)} เธเธฒเธ—เธต` : '-'),
                distanceText: (typeof r.distance === 'string' ? formatDistance(r.distance) : r.distance) || (r.distanceMeters ? `${(r.distanceMeters / 1000).toFixed(1)} เธเธก.` : '-'),
            })
        }

        allTrips.value = formatted
        myRoutes.value = ownRoutes

        // เธฃเธญเนเธเธเธ—เธตเนเธเธฃเนเธญเธก เนเธฅเนเธง reverse เน€เธเธเธฒเธฐเธเธฃเธ“เธตเธ—เธตเน backend เนเธกเนเธกเธต name (เน€เธเธเธฒเธฐ list เธเธณเธเธญเธเธญเธ)
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
        toast.error('เน€เธเธดเธ”เธเนเธญเธเธดเธ”เธเธฅเธฒเธ”', error?.data?.message || 'เนเธกเนเธชเธฒเธกเธฒเธฃเธ–เนเธซเธฅเธ”เธเนเธญเธกเธนเธฅเนเธ”เน')
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
    // เธซเธฒ item เธ•เธฒเธกเนเธ—เนเธเธ—เธตเนเน€เธเธดเธ”เธญเธขเธนเน เน€เธเธทเนเธญเธญเธฑเธเน€เธ”เธ•เนเธเธเธ—เธตเน
    const item = activeTab.value === 'myRoutes'
        ? myRoutes.value.find(r => r.id === id)
        : allTrips.value.find(t => t.id === id)
    if (item) updateMap(item)

    selectedTripId.value = (selectedTripId.value === id) ? null : id
}

// --- Driver Report Modal Functions ---
function openDriverReportModal(route) {
    reportedRoute.value = route
    driverReportCategory.value = ''
    driverReportText.value = ''
    driverReportPassengerId.value = ''
    driverReportImages.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    driverReportImages.value = []
    showDriverReportModal.value = true
}

function openDriverReportStatusModal(route) {
    reportedRoute.value = route
    reportedRouteData.value = route.reportData
    showDriverReportStatusModal.value = true
}

function closeDriverReportModal() {
    showDriverReportModal.value = false
    setTimeout(() => { reportedRoute.value = null }, 200)
}

function handleDriverReportFiles(e) {
    const files = Array.from(e.target.files || [])
<<<<<<< Updated upstream
    const remaining = 2 - driverReportImages.value.length
    files.slice(0, remaining).forEach(f => {
        driverReportImages.value.push({ file: f, url: URL.createObjectURL(f) })
=======
    files.forEach((f) => {
        if (f.size > DRIVER_REPORT_MAX_FILE_SIZE) {
            toast.error('เธเธเธฒเธ”เนเธเธฅเนเธ•เนเธญเธเนเธกเนเน€เธเธดเธ 50MB')
            return
        }

        if (f.type.startsWith('image/')) {
            if (driverReportImages.value.length >= DRIVER_REPORT_MAX_IMAGES) {
                toast.error(`เน€เธเธดเนเธกเธฃเธนเธเนเธ”เนเธชเธนเธเธชเธธเธ” ${DRIVER_REPORT_MAX_IMAGES} เธฃเธนเธ`)
                return
            }
            driverReportImages.value.push({ file: f, url: URL.createObjectURL(f) })
            return
        }

        if (f.type.startsWith('video/')) {
            if (driverReportVideos.value.length >= DRIVER_REPORT_MAX_VIDEOS) {
                toast.error(`เน€เธเธดเนเธกเธงเธดเธ”เธตเนเธญเนเธ”เนเธชเธนเธเธชเธธเธ” ${DRIVER_REPORT_MAX_VIDEOS} เธงเธดเธ”เธตเนเธญ`)
                return
            }
            driverReportVideos.value.push({ file: f, url: URL.createObjectURL(f) })
            return
        }

        if (f.type.startsWith('audio/')) {
            if (driverReportAudios.value.length >= DRIVER_REPORT_MAX_AUDIOS) {
                toast.error(`เน€เธเธดเนเธกเน€เธชเธตเธขเธเนเธ”เนเธชเธนเธเธชเธธเธ” ${DRIVER_REPORT_MAX_AUDIOS} เนเธเธฅเน`)
                return
            }
            driverReportAudios.value.push({ file: f, url: URL.createObjectURL(f) })
            return
        }

        toast.error('เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเนเธเธฅเนเธฃเธนเธ เธงเธดเธ”เธตเนเธญ เธซเธฃเธทเธญเน€เธชเธตเธขเธเน€เธ—เนเธฒเธเธฑเนเธ')
>>>>>>> Stashed changes
    })
    e.target.value = ''
}

function removeDriverReportImage(idx) {
    const it = driverReportImages.value[idx]
    if (it?.url) URL.revokeObjectURL(it.url)
    driverReportImages.value.splice(idx, 1)
}

async function submitDriverReport() {
    if (!reportedRoute.value) return
<<<<<<< Updated upstream
    if (!driverReportCategory.value) {
        toast.error('กรุณาเลือกหัวข้อปัญหา', 'กรุณาเลือกหัวข้อปัญหาที่พบ')
        return
    }
    const allowedCats = new Set(['VEHICLE_ISSUE', 'PASSENGER_ISSUE', 'ROAD_ISSUE', 'SAFETY_ISSUE', 'PAYMENT_ISSUE', 'OTHER'])
    if (!allowedCats.has(driverReportCategory.value)) {
        toast.error('หัวข้อปัญหาไม่ถูกต้อง', 'กรุณาเลือกหัวข้อที่ระบบรองรับ')
        return
    }
    if (driverReportCategory.value === 'PASSENGER_ISSUE' && !driverReportPassengerId.value) {
        toast.error('กรุณาระบุผู้โดยสาร', 'เลือกผู้โดยสารที่เกี่ยวข้องก่อนส่งรายงาน')
        return
    }
=======
    if (!driverReportCategories.value.length) {
        toast.error('เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒ', 'เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒเธ—เธตเนเธเธ')
        return
    }
    const allowedCats = new Set(driverReportCategoryOptions.map(opt => opt.value))
    if (driverReportCategories.value.some(cat => !allowedCats.has(cat))) {
        toast.error('เธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒเนเธกเนเธ–เธนเธเธ•เนเธญเธ', 'เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเธซเธฑเธงเธเนเธญเธ—เธตเนเธฃเธฐเธเธเธฃเธญเธเธฃเธฑเธ')
        return
    }
    const selectedPassengerIds = Array.from(new Set((driverReportPassengerIds.value || []).filter(Boolean)))
    if (driverReportCategories.value.includes('PASSENGER_ISSUE') && !selectedPassengerIds.length) {
        toast.error('เธเธฃเธธเธ“เธฒเธฃเธฐเธเธธเธเธนเนเนเธ”เธขเธชเธฒเธฃ', 'เน€เธฅเธทเธญเธเธเธนเนเนเธ”เธขเธชเธฒเธฃเธ—เธตเนเน€เธเธตเนเธขเธงเธเนเธญเธเธเนเธญเธเธชเนเธเธฃเธฒเธขเธเธฒเธ')
        return
    }
    if (!driverReportText.value.trim()) {
        toast.error('เธเธฃเธธเธ“เธฒเธเธฃเธญเธเธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”', 'เธเธฃเธธเธ“เธฒเธฃเธฐเธเธธเธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธเธฑเธเธซเธฒเธ—เธตเนเธเธเธเนเธญเธเธชเนเธเธฃเธฒเธขเธเธฒเธ')
        return
    }
    if (driverReportText.value.length > DRIVER_REPORT_MAX_COMMENT_LENGTH) {
        toast.error('เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธขเธฒเธงเน€เธเธดเธเนเธ', `เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธ•เนเธญเธเนเธกเนเน€เธเธดเธ ${DRIVER_REPORT_MAX_COMMENT_LENGTH} เธ•เธฑเธงเธญเธฑเธเธฉเธฃ`)
        return
    }

    if (driverReportAttachedLink.value && !isValidUrl(driverReportAttachedLink.value)) {
        driverReportLinkError.value = 'เธเธฃเธธเธ“เธฒเธเธฃเธญเธเธฅเธดเธเธเนเนเธซเนเธ–เธนเธเธ•เนเธญเธ (เธ•เนเธญเธเธเธถเนเธเธ•เนเธเธ”เนเธงเธข http:// เธซเธฃเธทเธญ https://)'
        return
    }
    driverReportLinkError.value = ''

>>>>>>> Stashed changes
    try {
        const fd = new FormData()
        fd.append('type', 'DRIVER')
        fd.append('category', driverReportCategory.value)
        fd.append('description', driverReportText.value || 'ไม่ได้ระบุรายละเอียด')
        fd.append('routeId', reportedRoute.value.id)
        if (driverReportPassengerId.value) {
            fd.append('targetUserId', driverReportPassengerId.value)
        }
        driverReportImages.value.forEach((it) => {
            if (it.file) fd.append('images', it.file)
        })

<<<<<<< Updated upstream
        await $api('/reports', { method: 'POST', body: fd })
        toast.success('ขอบคุณที่แจ้งรายงาน', 'ทีมงานจะตรวจสอบในเร็วๆ นี้')
=======
        const detailText = driverReportText.value.trim()
        const categorySummary = `เธซเธฑเธงเธเนเธญเธ—เธตเนเน€เธฅเธทเธญเธ: ${selectedCategoryLabels.join(', ')}`
        const passengerSummary = selectedPassengerNames.length
            ? `เธเธนเนเนเธ”เธขเธชเธฒเธฃเธ—เธตเนเน€เธเธตเนเธขเธงเธเนเธญเธ: ${selectedPassengerNames.join(', ')}`
            : ''
        const finalDescription = driverReportAttachedLink.value
            ? `${categorySummary}${passengerSummary ? `\n${passengerSummary}` : ''}\n${detailText}\n\nเธฅเธดเธเธเน: ${driverReportAttachedLink.value}`
            : `${categorySummary}${passengerSummary ? `\n${passengerSummary}` : ''}\n${detailText}`

        const targets = driverReportCategories.value.includes('PASSENGER_ISSUE')
            ? selectedPassengerIds
            : [null]

        await Promise.all(targets.map(async (targetUserId) => {
            const fd = new FormData()
            fd.append('type', 'DRIVER')
            fd.append('category', primaryCategory)
            fd.append('description', finalDescription)
            fd.append('routeId', reportedRoute.value.id)
            if (targetUserId) {
                fd.append('targetUserId', targetUserId)
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
        }))
        toast.success('เธเธญเธเธเธธเธ“เธ—เธตเนเนเธเนเธเธฃเธฒเธขเธเธฒเธ', 'เธ—เธตเธกเธเธฒเธเธเธฐเธ•เธฃเธงเธเธชเธญเธเนเธเน€เธฃเนเธงเน เธเธตเน')
>>>>>>> Stashed changes

        // update route in place
        const routeInList = myRoutes.value.find(r => r.id === reportedRoute.value.id)
        if (routeInList) {
            routeInList.hasReport = true
            routeInList.reportData = { 
                status: 'PENDING', 
                category: driverReportCategory.value, 
                description: driverReportText.value || 'ไม่ได้ระบุรายละเอียด',
                createdAt: new Date(),
                adminNotes: null 
            }
        }

        closeDriverReportModal()
        checkReportsForRoutes() // background sync
    } catch (err) {
        console.error('Failed to submit driver report', err)
        toast.error('เนเธกเนเธชเธฒเธกเธฒเธฃเธ–เธชเนเธเธฃเธฒเธขเธเธฒเธเนเธ”เน', err?.data?.message || 'เนเธเธฃเธ”เธฅเธญเธเธญเธตเธเธเธฃเธฑเนเธ')
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
            }
        })
    } catch (e) {
        console.error('Failed to check reports for routes', e)
    }
}

function getReportStatusText(status) {
    const reportStatus = {
        PENDING: 'เธฃเธญเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธ',
        APPROVED: 'เธฃเธฑเธเน€เธฃเธทเนเธญเธเนเธฅเนเธง',
        REJECTED: 'เนเธกเนเธเธเธเธฑเธเธซเธฒ',
        RESOLVED: 'เธ”เธณเน€เธเธดเธเธเธฒเธฃเนเธเนเนเธเนเธฅเนเธง'
    }
    return reportStatus[status] || 'เนเธกเนเธ—เธฃเธฒเธเธชเธ–เธฒเธเธฐ'
}

function extractSelectedCategories(description) {
    if (!description) return [];
    const selectedLine = String(description)
        .split("\n")
        .map((line) => line.trim())
        .find((line) => line.startsWith("หมวดหมู่ที่เลือก:") || line.startsWith("หัวข้อที่เลือก:"));

    if (!selectedLine) return [];
    return selectedLine
        .split(":")
        .slice(1)
        .join(":")
        .split(",")
        .map((label) => label.trim())
        .filter(Boolean);
}

function getCategoryText(reportOrCategory) {
    const report = reportOrCategory && typeof reportOrCategory === "object" ? reportOrCategory : null;
    const category = report ? report.category : reportOrCategory;
    const fromDesc = report ? extractSelectedCategories(report.description) : [];

    if (fromDesc.length) {
        return fromDesc.join(", ");
    }

    const cats = {
        VEHICLE_ISSUE: "เธเธฑเธเธซเธฒเธชเธ เธฒเธเธฃเธ–/เธเนเธญเธกเธนเธฅเธฃเธ–เนเธกเนเธ•เธฃเธ",
        PASSENGER_ISSUE: "เธเธคเธ•เธดเธเธฃเธฃเธกเนเธกเนเน€เธซเธกเธฒเธฐเธชเธก",
        ROAD_ISSUE: "เธเธฑเธเธซเธฒเธฃเธฐเธซเธงเนเธฒเธเน€เธชเนเธเธ—เธฒเธ",
        SAFETY_ISSUE: "เธเธงเธฒเธกเธเธฅเธญเธ”เธ เธฑเธข/เธเธคเธ•เธดเธเธฃเธฃเธก",
        PAYMENT_ISSUE: "เธเธฑเธเธซเธฒเธเธฒเธฃเธเธณเธฃเธฐเน€เธเธดเธ",
        LATE_ISSUE: "เธเธงเธฒเธกเธฅเนเธฒเธเนเธฒ",
        WRONG_INFO: "เธเนเธญเธกเธนเธฅเนเธกเนเธ•เธฃเธเธ•เธฒเธกเธ—เธตเนเธฃเธฐเธเธธ",
        APP_ISSUE: "เธเธฑเธเธซเธฒเธเธฒเธฃเนเธเนเธเธฒเธเนเธญเธเธเธฅเธดเน€เธเธเธฑเธ",
        NO_SHOW: "เธเธนเนเนเธ”เธขเธชเธฒเธฃเนเธกเนเธกเธฒเธเธเธ•เธฒเธกเธเธธเธ”เธเธฑเธ”เธซเธกเธฒเธข",
        OTHER: "เธญเธทเนเธ เน"
    };
    return cats[category] || category || "เธ—เธฑเนเธงเนเธ";
}

<<<<<<< Updated upstream
=======
function getDriverReportLink(description) {
    if (!description) return ''
    const linkLine = String(description)
        .split('\n')
        .map(line => line.trim())
        .find(line => line.startsWith('เธฅเธดเธเธเน:'))
    if (!linkLine) return ''
    return linkLine.replace('เธฅเธดเธเธเน:', '').trim()
}

function getDriverReportDetailText(description) {
    if (!description) return '-'
    return String(description)
        .split('\n')
        .filter(line => !line.trim().startsWith('เธฅเธดเธเธเน:'))
        .join('\n')
        .trim() || '-'
}

>>>>>>> Stashed changes
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
    if (name) name = name.replace(/,?\s*(Thailand|เนเธ—เธข)\s*$/i, '')
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

    // cleanup เน€เธ”เธดเธก
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

    // เธซเธกเธธเธ”เธเธธเธ”เนเธงเธฐ
    if (Array.isArray(trip.stopsCoords) && trip.stopsCoords.length) {
        stopMarkers = trip.stopsCoords.map((s, idx) => new google.maps.Marker({
            position: { lat: s.lat, lng: s.lng },
            map: gmap,
            icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
            title: s.name || s.address || `เธเธธเธ”เนเธงเธฐ ${idx + 1}`
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
            title: 'เธขเธทเธเธขเธฑเธเธเธณเธเธญเธเธญเธ',
            message: `เธขเธทเธเธขเธฑเธเธเธณเธเธญเธเธญเธเธเธนเนเนเธ”เธขเธชเธฒเธฃ "${trip.passenger.name}" เนเธเนเธซเธฃเธทเธญเนเธกเน?`,
            confirmText: 'เธขเธทเธเธขเธฑเธเธเธณเธเธญ',
            action: 'confirm',
            variant: 'primary',
        }
    } else if (action === 'reject') {
        modalContent.value = {
            title: 'เธเธเธดเน€เธชเธเธเธณเธเธญเธเธญเธ',
            message: `เธ•เนเธญเธเธเธฒเธฃเธเธเธดเน€เธชเธเธเธณเธเธญเธเธญเธ "${trip.passenger.name}" เนเธเนเธซเธฃเธทเธญเนเธกเน?`,
            confirmText: 'เธเธเธดเน€เธชเธ',
            action: 'reject',
            variant: 'danger',
        }
    } else if (action === 'delete') {
        modalContent.value = {
            title: 'เธขเธทเธเธขเธฑเธเธเธฒเธฃเธฅเธเธฃเธฒเธขเธเธฒเธฃ',
            message: `เธ•เนเธญเธเธเธฒเธฃเธฅเธเธเธณเธเธญเธเธตเนเธญเธญเธเธเธฒเธเธฃเธฒเธขเธเธฒเธฃเนเธเนเธซเธฃเธทเธญเนเธกเน?`,
            confirmText: 'เธฅเธเธฃเธฒเธขเธเธฒเธฃ',
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
            toast.success('เธชเธณเน€เธฃเนเธ', 'เธขเธทเธเธขเธฑเธเธเธณเธเธญเนเธฅเนเธง')
        } else if (action === 'reject') {
            await $api(`/bookings/${bookingId}/status`, { method: 'PATCH', body: { status: 'REJECTED' } })
            toast.success('เธชเธณเน€เธฃเนเธ', 'เธเธเธดเน€เธชเธเธเธณเธเธญเนเธฅเนเธง')
        } else if (action === 'delete') {
            await $api(`/bookings/${bookingId}`, { method: 'DELETE' })
            toast.success('เธฅเธเธฃเธฒเธขเธเธฒเธฃเธชเธณเน€เธฃเนเธ', 'เธฅเธเธเธณเธเธญเธญเธญเธเธเธฒเธเธฃเธฒเธขเธเธฒเธฃเนเธฅเนเธง')
        }
        else if (action === 'complete') {

    await $api(`/routes/${tripToAction.value.id}/complete`, {
        method: 'PATCH',
        body: { status: 'COMPLETED' }
    })
    toast.success('เธชเธณเน€เธฃเนเธ', 'เธเธเธ—เธฃเธดเธเน€เธฃเธตเธขเธเธฃเนเธญเธขเนเธฅเนเธง')
}

        closeConfirmModal()
        await fetchMyRoutes()
    } catch (error) {
        console.error(`Failed to ${action} booking:`, error)
        toast.error('เน€เธเธดเธ”เธเนเธญเธเธดเธ”เธเธฅเธฒเธ”', error?.data?.message || 'เนเธกเนเธชเธฒเธกเธฒเธฃเธ–เธ”เธณเน€เธเธดเธเธเธฒเธฃเนเธ”เน')
        closeConfirmModal()
    }
}

const copyEmail = async (email) => {
    try {
        await navigator.clipboard.writeText(email)
        toast.success('เธเธฑเธ”เธฅเธญเธเนเธฅเนเธง', email)
    } catch (e) {
        toast.error('เธเธฑเธ”เธฅเธญเธเนเธกเนเธชเธณเน€เธฃเนเธ', 'เธฅเธญเธเนเธซเธกเนเธญเธตเธเธเธฃเธฑเนเธ')
    }
}

const openCompleteModal = (route) => {
    tripToAction.value = route
    modalContent.value = {
        title: 'เธเธเธ—เธฃเธดเธ',
        message: `เธ•เนเธญเธเธเธฒเธฃเธเธเน€เธชเนเธเธ—เธฒเธ "${route.origin} โ’ ${route.destination}" เนเธเนเธซเธฃเธทเธญเนเธกเน?`,
        confirmText: 'เธเธเธ—เธฃเธดเธ',
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
        if (/เธเธก/.test(seg)) meters += n * 1000
        else if (/เน€เธกเธ•เธฃ|เธก\./.test(seg)) meters += n
        else meters += n
    }

    if (meters >= 1000) {
        const km = Math.round((meters / 1000) * 10) / 10
        return `${(km % 1 === 0 ? km.toFixed(0) : km)} เธเธก.`
    }
    return `${Math.round(meters)} เธก.`
}

function formatDuration(input) {
    if (typeof input !== 'string') return input
    const parts = input.split('+')
    if (parts.length <= 1) return input

    let minutes = 0
    for (const seg of parts) {
        const n = parseFloat(seg.replace(/[^\d.]/g, ''))
        if (Number.isNaN(n)) continue
        if (/เธเธก/.test(seg)) minutes += n * 60
        else minutes += n
    }

    const h = Math.floor(minutes / 60)
    const m = Math.round(minutes % 60)
    return h ? (m ? `${h} เธเธก. ${m} เธเธฒเธ—เธต` : `${h} เธเธก.`) : `${m} เธเธฒเธ—เธต`
}

// --- Lifecycle ---
useHead({
    title: 'เธเธณเธเธญเธเธญเธเน€เธชเนเธเธ—เธฒเธเธเธญเธเธเธฑเธ - เนเธเธเธณเนเธซเธเน',
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

    toast.success("เน€เธฃเธดเนเธกเธ—เธฃเธดเธเนเธฅเนเธง")

    await fetchMyRoutes()
  } catch (err) {
    toast.error(err?.data?.message || "เน€เธฃเธดเนเธกเธ—เธฃเธดเธเนเธกเนเธชเธณเน€เธฃเนเธ")
  }
}

</script>

<style scoped>
/* (เธชเนเธ•เธฅเนเธ—เธฑเนเธเธซเธกเธ”เธเธเน€เธ”เธดเธก) */
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



