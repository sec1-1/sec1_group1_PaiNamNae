<template>
    <div>
        <div class="px-4 py-8 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900">เธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเธเธญเธเธเธฑเธ</h2>
                <p class="mt-2 text-gray-600">เธเธฑเธ”เธเธฒเธฃเนเธฅเธฐเธ•เธดเธ”เธ•เธฒเธกเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเธ—เธฑเนเธเธซเธกเธ”เธเธญเธเธเธธเธ“</p>
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
                            <h3 class="text-lg font-semibold text-gray-900">เธฃเธฒเธขเธเธฒเธฃเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ</h3>
                        </div>

                        <div v-if="isLoading" class="p-12 text-center text-gray-500">
                            <p>เธเธณเธฅเธฑเธเนเธซเธฅเธ”เธเนเธญเธกเธนเธฅเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ...</p>
                        </div>

                        <div v-else class="divide-y divide-gray-200">
                            <div v-if="filteredTrips.length === 0" class="p-12 text-center text-gray-500">
                                <p>เนเธกเนเธเธเธฃเธฒเธขเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเนเธเธซเธกเธงเธ”เธซเธกเธนเนเธเธตเน</p>
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
                                            <span v-if="trip.routeStatus === 'completed'"
    class="status-badge status-completed">
    เธเธเธ—เธฃเธดเธเนเธฅเนเธง
</span>

<span v-else-if="trip.status === 'pending'"
    class="status-badge status-pending">
    เธฃเธญเธ”เธณเน€เธเธดเธเธเธฒเธฃ
</span>

<span v-else-if="trip.status === 'confirmed'"
    class="status-badge status-confirmed">
    เธขเธทเธเธขเธฑเธเนเธฅเนเธง
</span>

<span v-else-if="trip.status === 'rejected'"
    class="status-badge status-rejected">
    เธเธเธดเน€เธชเธ
</span>

<span v-else-if="trip.status === 'cancelled'"
    class="status-badge status-cancelled">
    เธขเธเน€เธฅเธดเธ
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
                                    </div>
                                </div>

                                <div class="flex items-center mb-4 space-x-4">
                                    <img :src="trip.driver.image" :alt="trip.driver.name"
                                        class="object-cover w-12 h-12 rounded-full" />
                                    <div class="flex-1">
                                        <div
                                            class="font-medium cursor-pointer hover:text-blue-600"
                                            @click.stop="openDriverReviews(trip.driver)"
                                            >
                                            {{ trip.driver.name }}
                                        </div>              

                                        <div class="flex items-center">
                                            <div class="flex text-sm text-yellow-400">
                                                <span>
                                                    {{ 'โ…'.repeat(Math.round(trip.driver.rating)) }}{{ 'โ'.repeat(5 -
                                                        Math.round(trip.driver.rating)) }}
                                                </span>
                                            </div>
                                            <span class="ml-2 text-sm text-gray-600">{{ trip.driver.rating }} ({{
                                                trip.driver.reviews }} เธฃเธตเธงเธดเธง)</span>
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-lg font-bold text-blue-600">{{ trip.price }} เธเธฒเธ—</div>
                                        <div class="text-sm text-gray-600">เธเธณเธเธงเธ {{ trip.seats }} เธ—เธตเนเธเธฑเนเธ</div>
                                    </div>
                                </div>

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
                                    <!-- PENDING: เธขเธเน€เธฅเธดเธเนเธ”เน -->
                                    <button 
                                        v-if="trip.status === 'pending' && trip.routeStatus !== 'completed'" 
                                        @click.stop="openCancelModal(trip)"
                                        class="px-4 py-2 text-sm text-red-600 border border-red-300 rounded-md hover:bg-red-50">
                                        เธขเธเน€เธฅเธดเธเธเธฒเธฃเธเธญเธ
                                    </button>


                                    <!-- CONFIRMED: เน€เธเธดเนเธกเธเธธเนเธกเธขเธเน€เธฅเธดเธ + เธเธเธเธธเนเธกเนเธเธ— -->
                                    <template v-else-if="trip.status === 'confirmed' && trip.routeStatus !== 'completed'">

                                        <button @click.stop="openCancelModal(trip)"
                                            class="px-4 py-2 text-sm text-red-600 transition duration-200 border border-red-300 rounded-md hover:bg-red-50">
                                            เธขเธเน€เธฅเธดเธเธเธฒเธฃเธเธญเธ
                                        </button>
                                        <button
                                            class="px-4 py-2 text-sm text-white transition duration-200 bg-blue-600 rounded-md hover:bg-blue-700">
                                            เนเธเธ—เธเธฑเธเธเธนเนเธเธฑเธ
                                        </button>
                                        <button @click.stop="trip.hasReport ? openProgressForTrip(trip) : openReportModal(trip)"
<<<<<<< Updated upstream
                                                class="px-4 py-2 ml-2 text-sm text-white transition duration-200 rounded-md"
                                                :class="trip.hasReport ? 'bg-orange-500 hover:bg-orange-600' : 'bg-red-600 hover:bg-red-700'">
                                                {{ trip.hasReport ? 'ติดตามสถานะ' : 'รายงาน' }}
=======
                                          class="px-4 py-2 ml-2 text-sm transition duration-200 rounded-md"
                                          :class="trip.hasReport ? 'bg-white text-blue-600 border border-blue-600 hover:bg-blue-50' : 'text-white bg-red-600 hover:bg-red-700'">
                                                {{ trip.hasReport ? 'เธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐ' : 'เธฃเธฒเธขเธเธฒเธ' }}
>>>>>>> Stashed changes
                                        </button>
                                    </template>

<template v-if="trip.routeStatus === 'completed'">
  <button
    @click.stop="openReviewModal(trip)"
    class="px-4 py-2 text-sm text-white bg-blue-600 rounded-md hover:bg-blue-700">
    เธฃเธตเธงเธดเธงเธเธนเนเธเธฑเธ
  </button>
  <button @click.stop="trip.hasReport ? openProgressForTrip(trip) : openReportModal(trip)"
<<<<<<< Updated upstream
    class="px-4 py-2 ml-2 text-sm text-white transition duration-200 rounded-md"
    :class="trip.hasReport ? 'bg-orange-500 hover:bg-orange-600' : 'bg-red-600 hover:bg-red-700'">
    {{ trip.hasReport ? 'ติดตามสถานะ' : 'รายงาน' }}
=======
    class="px-4 py-2 ml-2 text-sm transition duration-200 rounded-md"
    :class="trip.hasReport ? 'bg-white text-blue-600 border border-blue-600 hover:bg-blue-50' : 'text-white bg-red-600 hover:bg-red-700'">
    {{ trip.hasReport ? 'เธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐ' : 'เธฃเธฒเธขเธเธฒเธ' }}
>>>>>>> Stashed changes
  </button>
</template>


                                    

                                    
                                    

                                    <!-- REJECTED / CANCELLED: เธฅเธเนเธ”เน -->
                                    <button 
  v-else-if="['rejected', 'cancelled'].includes(trip.status) && trip.routeStatus !== 'completed'"

                                        @click.stop="openConfirmModal(trip, 'delete')"
                                        class="px-4 py-2 text-sm text-gray-600 transition duration-200 border border-gray-300 rounded-md hover:bg-gray-50">
                                        เธฅเธเธฃเธฒเธขเธเธฒเธฃ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-1">
                    <div class="sticky overflow-hidden bg-white border border-gray-300 rounded-lg shadow-md top-8">
                        <div class="p-6 border-b border-gray-300">
                            <h3 class="text-lg font-semibold text-gray-900">เนเธเธเธ—เธตเนเน€เธชเนเธเธ—เธฒเธ</h3>
                        </div>
                        <div ref="mapContainer" id="map" class="h-96"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal: เน€เธฅเธทเธญเธเน€เธซเธ•เธธเธเธฅเธเธฒเธฃเธขเธเน€เธฅเธดเธ -->
        <div v-if="isCancelModalVisible" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40"
            @click.self="closeCancelModal">
            <div class="w-full max-w-md p-6 bg-white rounded-lg shadow-xl">
                <h3 class="text-lg font-semibold text-gray-900">เน€เธฅเธทเธญเธเน€เธซเธ•เธธเธเธฅเธเธฒเธฃเธขเธเน€เธฅเธดเธ</h3>
                <p class="mt-1 text-sm text-gray-600">เนเธเธฃเธ”เน€เธฅเธทเธญเธเน€เธซเธ•เธธเธเธฅเธ•เธฒเธกเธ•เธฑเธงเน€เธฅเธทเธญเธเธ—เธตเนเธเธณเธซเธเธ”</p>

                <div class="mt-4">
                    <label class="block mb-1 text-sm text-gray-700">เน€เธซเธ•เธธเธเธฅ</label>
                    <select v-model="selectedCancelReason" class="w-full px-3 py-2 border border-gray-300 rounded-md">
                        <option value="" disabled>-- เน€เธฅเธทเธญเธเน€เธซเธ•เธธเธเธฅ --</option>
                        <option v-for="r in cancelReasonOptions" :key="r.value" :value="r.value">
                            {{ r.label }}
                        </option>
                    </select>
                    <p v-if="cancelReasonError" class="mt-2 text-sm text-red-600">
                        {{ cancelReasonError }}
                    </p>
                </div>

                <div class="flex justify-end gap-2 mt-6">
                    <button @click="closeCancelModal"
                        class="px-4 py-2 text-sm text-gray-700 bg-gray-100 rounded-md hover:bg-gray-200">
                        เธเธดเธ”
                    </button>
                    <button @click="submitCancel" :disabled="!selectedCancelReason || isSubmittingCancel"
                        class="px-4 py-2 text-sm text-white bg-red-600 rounded-md hover:bg-red-700 disabled:opacity-50">
                        {{ isSubmittingCancel ? 'เธเธณเธฅเธฑเธเธชเนเธ...' : 'เธขเธทเธเธขเธฑเธเธเธฒเธฃเธขเธเน€เธฅเธดเธ' }}
                    </button>
                </div>
            </div>
        </div>

        <!-- Review Modal -->
<div
  v-if="showReviewModal"
  class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm"
  @click.self="closeModal"
>
  <div class="w-full max-w-xl bg-white rounded-lg shadow-xl overflow-hidden">

  <div class="p-6 max-h-[80vh] overflow-y-auto">

    <!-- HEADER -->
    <h2 class="mb-6 text-2xl font-semibold text-gray-800">
      เธฃเธตเธงเธดเธงเธเธนเนเธเธฑเธ
    </h2>

    <!-- โญ Rating -->
    <div class="mb-6">
      <label class="block mb-2 text-sm font-medium text-gray-700">
        เนเธซเนเธเธฐเนเธเธ
      </label>

      <div class="flex gap-2">
        <button
          v-for="star in 5"
          :key="star"
          @click="rating = star"
          type="button"
          class="text-3xl transition hover:scale-110"
        >
          <span :class="star <= rating ? 'text-yellow-400' : 'text-gray-300'">
            โ…
          </span>
        </button>
      </div>
    </div>

    <!-- โ… Review Categories -->
    <div v-if="rating > 0" class="mb-6">

      <label
        class="block mb-3 text-sm font-medium"
        :class="rating <= 2 ? 'text-red-500' : 'text-green-600'"
      >
        {{ rating <= 2
            ? 'เธญเธฐเนเธฃเธ—เธตเนเธเธงเธฃเธเธฃเธฑเธเธเธฃเธธเธ?'
            : 'เธญเธฐเนเธฃเธ—เธตเนเธเธฃเธฐเธ—เธฑเธเนเธ?' }}
      </label>

      <div class="grid grid-cols-2 gap-3 p-4 border rounded-lg bg-gray-50">
        <label
          v-for="category in reviewCategories"
          :key="category.value"
          class="flex items-center gap-2 cursor-pointer"
        >
          <input
            type="checkbox"
            :value="category.value"
            v-model="selectedCategories"
            class="w-4 h-4 text-blue-600 border-gray-300 rounded"
          />
          <span class="text-sm text-gray-700">{{ category.label }}</span>
        </label>
      </div>

      <p v-if="selectedCategories.length === 0"
         class="mt-2 text-xs text-gray-400">
        เนเธกเนเธฃเธฐเธเธธเธซเธกเธงเธ”เธซเธกเธนเน
      </p>
    </div>

    <!-- ๐“ Comment -->
    <div class="mb-6">
      <label class="block mb-2 text-sm font-medium text-gray-700">
        เธเธงเธฒเธกเธเธดเธ”เน€เธซเนเธ
      </label>

      <textarea
        v-model="comment"
        rows="4"
        maxlength="501"
        placeholder="เน€เธเธตเธขเธเธฃเธตเธงเธดเธงเธเธญเธเธเธธเธ“... (เธชเธนเธเธชเธธเธ” 501 เธ•เธฑเธงเธญเธฑเธเธฉเธฃ)"
        class="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-200 focus:border-blue-400"
      ></textarea>
      <div class="text-right text-xs text-gray-500 mt-1">
        {{ comment.length }} / 501
      </div>
    </div>

    <!-- ๏ฟฝ Upload media (images/videos) -->
    <div class="mb-6">
      <label class="block mb-2 text-sm font-medium text-gray-700">
        เน€เธเธดเนเธกเธฃเธนเธเธซเธฃเธทเธญเธงเธดเธ”เธตเนเธญ (เนเธกเนเธเธฑเธเธเธฑเธ)
        <span class="text-xs text-gray-400">
          (เธชเธนเธเธชเธธเธ” 3 เธฃเธนเธเนเธฅเธฐ 3 เธงเธดเธ”เธตเนเธญ, เธเธเธฒเธ”เนเธ•เนเธฅเธฐเนเธเธฅเนเนเธกเนเน€เธเธดเธ 50MB)
        </span>
      </label>

      <input
        type="file"
        multiple
        accept="image/*,video/*"
        @change="handleMedia"
        class="w-full text-sm"
      />

      <!-- Previews -->
      <div v-if="imagePreviews.length || videoPreviews.length"
           class="flex flex-wrap gap-3 mt-4">

        <div
          v-for="(img, index) in imagePreviews"
          :key="`img-${index}`"
          class="relative"
        >
          <img
            :src="img"
            class="object-cover w-24 h-24 rounded-lg shadow"
          />

          <button
            @click="removeImage(index)"
            type="button"
            class="absolute -top-2 -right-2 px-2 text-xs text-white bg-red-500 rounded-full shadow"
          >
            โ•
          </button>
        </div>

        <div
          v-for="(vid, index) in videoPreviews"
          :key="`vid-${index}`"
          class="relative"
        >
          <video
            :src="vid"
            class="object-cover w-24 h-24 rounded-lg shadow"
            controls
          ></video>

          <button
            @click="removeVideo(index)"
            type="button"
            class="absolute -top-2 -right-2 px-2 text-xs text-white bg-red-500 rounded-full shadow"
          >
            โ•
          </button>
        </div>
      </div>
    </div>

    <!-- BUTTONS -->
    <div class="flex justify-end gap-3 pt-5 border-t">
      <button
        @click="closeModal"
        type="button"
        class="px-5 py-2 text-sm bg-gray-200 rounded-lg hover:bg-gray-300"
      >
        เธขเธเน€เธฅเธดเธ
      </button>

      <button
        @click="submitReview"
        type="button"
        class="px-5 py-2 text-sm text-white bg-blue-600 rounded-lg hover:bg-blue-700"
      >
        เธชเนเธเธฃเธตเธงเธดเธง
      </button>
    </div>
     </div>

  </div>
</div>




        <ConfirmModal :show="isModalVisible" :title="modalContent.title" :message="modalContent.message"
            :confirmText="modalContent.confirmText" :variant="modalContent.variant" @confirm="handleConfirmAction"
            @cancel="closeConfirmModal" />
    </div>

    <!-- DRIVER REVIEW MODAL -->
<transition name="modal-fade">
  <div
    v-if="showDriverReviewModal"
    class="fixed inset-0 z-[9999] flex items-center justify-center"
  >
    <!-- overlay -->
    <div
      class="absolute inset-0 bg-black/40 backdrop-blur-[2px]"
      @click.self="closeDriverReviewModal"
    ></div>

    <!-- modal box -->
    <div
      class="relative bg-white w-full max-w-2xl mx-4 rounded-2xl shadow-xl
             p-6 overflow-y-auto max-h-[90vh]"
      @click.stop
    >

      <!-- HEADER -->
      <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold">
          เธฃเธตเธงเธดเธงเธเธญเธ {{ selectedDriver?.name }}
        </h3>

        <button
          class="px-3 py-1 text-sm text-white bg-red-500 rounded-lg hover:bg-red-600"
          @click="closeDriverReviewModal"
        >
          เธเธดเธ”
        </button>
      </div>

      <!-- LOADING -->
      <!-- Summary is calculated from fetched reviews, no additional loading needed -->

      <!-- HAS REVIEWS -->
      <div
        v-if="driverReviewSummaryComputed && driverReviewSummaryComputed.totalReviews > 0"
      >

        <!-- SUMMARY -->
        <div class="mb-6 text-center">
          <div class="text-3xl font-bold text-gray-800">
            {{ driverReviewSummaryComputed.average }}
          </div>

          <div class="text-yellow-400 text-lg">
            <span v-for="i in 5" :key="i">
              {{ i <= Math.round(Number(driverReviewSummaryComputed.average)) ? 'โ…' : 'โ' }}
            </span>
          </div>

          <div class="text-sm text-gray-500">
            {{ driverReviewSummaryComputed.totalReviews }} เธฃเธตเธงเธดเธง
          </div>
        </div>

        <!-- TAG FILTER -->
        <div class="flex flex-wrap gap-2 mb-4 justify-center">
          <button
            @click="selectedTag = null"
            :class="[
              'px-4 py-2 rounded-full text-sm border transition',
              !selectedTag
                ? 'bg-green-600 text-white border-green-600'
                : 'bg-white hover:bg-gray-50'
            ]"
          >
            เธ—เธฑเนเธเธซเธกเธ”
          </button>

          <button
            v-for="tag in REVIEW_TAGS"
            :key="tag"
            @click="selectedTag = tag"
            :class="[
              'px-4 py-2 rounded-full text-sm border transition',
              selectedTag === tag
                ? 'bg-green-600 text-white border-green-600'
                : 'bg-white hover:bg-gray-50'
            ]"
          >
            {{ TAG_LABELS[tag] }}
          </button>
        </div>

        <!-- REVIEW LIST -->
        <div v-if="filteredReviews.length" class="space-y-4">

          <div
            v-for="review in filteredReviews"
            :key="review.id"
            class="p-4 border rounded-2xl shadow-sm space-y-3"
          >
            <!-- HEADER -->
            <div class="flex items-center justify-between">
              <div class="flex items-center space-x-2">
                <img
                  :src="review.reviewer?.profilePicture
                  || 'https://ui-avatars.com/api/?name=' + (review.reviewer?.firstName || 'U')"
                  class="w-9 h-9 rounded-full object-cover"
                />
                <div>
                  <div class="text-sm font-semibold">
                    {{ review.reviewer?.firstName || 'เธเธนเนเนเธเน' }}
                  </div>
                  <div class="text-xs text-gray-400">
                    {{ new Date(review.createdAt).toLocaleDateString() }}
                  </div>
                </div>
              </div>

              <div class="text-yellow-500 font-semibold text-sm">
                โญ {{ review.rating }}
              </div>
            </div>

            <!-- COMMENT -->
            <div class="text-sm text-gray-700">
              {{ review.comment || 'เนเธกเนเธกเธตเธเนเธญเธเธงเธฒเธก' }}
            </div>

            <!-- TAGS -->
            <div v-if="review.tags?.length" class="flex flex-wrap gap-1">
              <span
                v-for="tag in review.tags"
                :key="tag"
                class="px-2 py-1 text-xs bg-green-50 text-green-600 rounded-full"
              >
                {{ TAG_LABELS[tag] || tag }}
              </span>
            </div>

            <!-- IMAGES AND VIDEOS -->
            <div
              v-if="parsedImages(review).length || parsedVideos(review).length"
              class="flex flex-wrap gap-2"
            >
              <img
                v-for="(img, index) in parsedImages(review)"
                :key="`img-${index}`"
                :src="img"
                class="object-cover w-24 h-24 rounded-xl"
              />
              <video
                v-for="(vid, index) in parsedVideos(review)"
                :key="`vid-${index}`"
                :src="vid"
                class="object-cover w-24 h-24 rounded-xl"
                controls
              ></video>
            </div>
          </div>
        </div>

        <div v-else class="text-gray-400 text-sm text-center">
          เนเธกเนเธกเธตเธฃเธตเธงเธดเธงเนเธเธซเธกเธงเธ”เธเธตเน
        </div>

      </div>

      <!-- NO REVIEWS -->
      <div v-else class="text-center text-gray-400 py-8">
        เธขเธฑเธเนเธกเนเธกเธตเธฃเธตเธงเธดเธง
      </div>

    </div>
  </div>
</transition>

  <div
    v-if="showReportModal"
    class="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm"
    @click.self="closeReportModal"
  >
    <div 
      class="w-full max-w-lg overflow-hidden transition-all transform bg-white shadow-2xl rounded-3xl animate-in fade-in zoom-in duration-300"
    >
      <div class="relative p-6 pb-0">
        <div class="absolute top-0 left-0 w-full h-1.5 bg-gradient-to-r from-red-500 via-orange-500 to-red-600"></div>
        <div class="flex items-center justify-between mb-2">
          <h3 class="text-2xl font-bold text-gray-800">
            เธฃเธฒเธขเธเธฒเธเธเธฑเธเธซเธฒ
          </h3>
          <button @click="closeReportModal" class="p-2 transition-colors rounded-full hover:bg-gray-100 text-gray-400 hover:text-gray-600">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
          </button>
        </div>
        <p class="text-sm text-gray-500">เธเธงเธฒเธกเธเธฅเธญเธ”เธ เธฑเธขเธเธญเธเธเธธเธ“เธเธทเธญเธชเธดเนเธเธชเธณเธเธฑเธ เนเธเธฃเธ”เนเธเนเธเนเธซเนเน€เธฃเธฒเธ—เธฃเธฒเธ</p>
      </div>

      <div class="p-6 space-y-5">
        <div>
          <label class="block mb-2 text-sm font-semibold text-gray-700">
<<<<<<< Updated upstream
            หัวข้อปัญหา
=======
            เธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒ (เน€เธฅเธทเธญเธเนเธ”เนเธกเธฒเธเธเธงเนเธฒ 1 เธเนเธญ)
>>>>>>> Stashed changes
          </label>
          <div class="relative group">
            <select
              v-model="passengerReportCategory"
              class="w-full px-4 py-3 transition-all border-2 border-gray-100 appearance-none rounded-xl focus:border-red-500 focus:ring-0 bg-gray-50/50"
            >
<<<<<<< Updated upstream
              <option disabled value="">-- เลือกหัวข้อที่เกี่ยวข้อง --</option>
              <option value="SAFETY_ISSUE">🚨 ความปลอดภัย</option>
              <option value="PASSENGER_ISSUE">👤 พฤติกรรมคนขับ</option>
              <option value="PAYMENT_ISSUE">💰 ปัญหาการชำระเงิน</option>
              <option value="OTHER">📁 อื่น ๆ</option>
            </select>
            <div class="absolute inset-y-0 right-0 flex items-center px-4 pointer-events-none text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>
            </div>
=======
              {{ option.label }}
            </button>
          </div>
          <div v-if="!passengerReportCategories.length" class="mt-2 text-xs text-gray-500">
            เนเธเธฃเธ”เน€เธฅเธทเธญเธเธญเธขเนเธฒเธเธเนเธญเธข 1 เธซเธกเธงเธ”เธซเธกเธนเน
          </div>
          <div v-else class="mt-2 text-xs text-gray-500">
            เน€เธฅเธทเธญเธเนเธฅเนเธง {{ passengerReportCategories.length }} เธซเธกเธงเธ”เธซเธกเธนเน
>>>>>>> Stashed changes
          </div>
        </div>

        <div>
          <label class="block mb-2 text-sm font-semibold text-gray-700">
            เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เน€เธซเธ•เธธเธเธฒเธฃเธ“เน
          </label>
          <textarea
            v-model="reportText"
            rows="4"
            maxlength="501"
            class="w-full p-4 transition-all border-2 border-gray-100 rounded-xl focus:border-red-500 focus:ring-0 bg-gray-50/50 placeholder:text-gray-400"
            placeholder="เธฃเธเธเธงเธเธฃเธฐเธเธธเธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เน€เธเธทเนเธญเนเธซเนเน€เธฃเธฒเธ•เธฃเธงเธเธชเธญเธเนเธ”เนเธฃเธงเธ”เน€เธฃเนเธงเธเธถเนเธ..."
          ></textarea>
          <div class="text-right text-xs text-gray-500 mt-1">{{ reportText.length }} / 501</div>
        </div>

        <div>
          <label class="block mb-2 text-sm font-semibold text-gray-700">
            เธซเธฅเธฑเธเธเธฒเธเธฃเธนเธเธซเธฃเธทเธญเธงเธดเธ”เธตเนเธญ <span class="font-normal text-gray-400">(เธชเธนเธเธชเธธเธ” 3 เธฃเธนเธเนเธฅเธฐ 3 เธงเธดเธ”เธตเนเธญ, เนเธเธฅเนเธฅเธฐเนเธกเนเน€เธเธดเธ 50MB)</span>
          </label>
          
          <div class="flex flex-wrap gap-4">
            <label v-if="reportImages.length < REPORT_MAX_IMAGES || reportVideos.length < REPORT_MAX_VIDEOS" class="flex flex-col items-center justify-center w-24 h-24 transition-all border-2 border-dashed border-gray-200 cursor-pointer rounded-2xl hover:border-red-400 hover:bg-red-50 group">
              <div class="flex flex-col items-center justify-center pt-5 pb-6">
                <svg class="w-8 h-8 mb-1 text-gray-400 group-hover:text-red-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                </svg>
                <span class="text-[10px] text-gray-400 group-hover:text-red-500 uppercase font-bold">เน€เธเธดเนเธกเนเธเธฅเน</span>
              </div>
              <input type="file" class="hidden" multiple @change="handleReportFiles" accept="image/*,video/*" />
            </label>

            <div
              v-for="(img, i) in reportImages"
              :key="`img-${i}`"
              class="relative group animate-in zoom-in duration-200"
            >
              <img
                :src="img.url"
                class="object-cover w-24 h-24 shadow-md rounded-2xl ring-2 ring-white"
              />
              <button
                @click="removeReportImage(i)"
                class="absolute flex items-center justify-center w-6 h-6 text-white transition-transform bg-red-500 rounded-full shadow-lg -top-2 -right-2 hover:scale-110 active:scale-95"
              >
                โ•
              </button>
            </div>
            <div
              v-for="(vid, i) in reportVideos"
              :key="`vid-${i}`"
              class="relative group animate-in zoom-in duration-200"
            >
              <video
                :src="vid.url"
                class="object-cover w-24 h-24 shadow-md rounded-2xl ring-2 ring-white"
                controls
              ></video>
              <button
                @click="removeReportVideo(i)"
                class="absolute flex items-center justify-center w-6 h-6 text-white transition-transform bg-red-500 rounded-full shadow-lg -top-2 -right-2 hover:scale-110 active:scale-95"
              >
                โ•
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="flex items-center gap-3 p-6 pt-2">
        <button
          @click="closeReportModal"
          class="flex-1 py-3 font-semibold text-gray-600 transition-all rounded-xl hover:bg-gray-100 active:scale-95"
        >
          เธขเธเน€เธฅเธดเธ
        </button>

        <button
          @click="submitReport"
          :disabled="!passengerReportCategory || !reportText"
          class="flex-[2] py-3 font-semibold text-white transition-all bg-red-600 rounded-xl hover:bg-red-700 shadow-lg shadow-red-200 active:scale-95 disabled:opacity-50 disabled:grayscale disabled:pointer-events-none"
        >
          เธชเนเธเธฃเธฒเธขเธเธฒเธเธเธงเธฒเธกเธเธฅเธญเธ”เธ เธฑเธข
        </button>
      </div>
    </div>
  </div>


        <!-- Progress Modal -->
        <div v-if="isProgressModalVisible" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40"
            @click.self="isProgressModalVisible = false">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-in">
                <!-- Header -->
<<<<<<< Updated upstream
                <div class="bg-gradient-to-r from-red-500 to-red-600 p-6 text-white">
                    <div class="flex items-center justify-between mb-2">
                        <h2 class="text-xl font-bold">ติดตามสถานะรายงาน</h2>
                        <button @click="isProgressModalVisible = false" class="text-white/80 hover:text-white transition">
=======
                <div class="border-b border-gray-200 bg-white p-6 text-black">
                  <div class="flex items-center justify-between mb-3">
                        <h2 class="text-xl font-bold">เธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐเธฃเธฒเธขเธเธฒเธ</h2>
                    <button @click="isProgressModalVisible = false" class="text-gray-500 hover:text-black transition">
>>>>>>> Stashed changes
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                    <p v-if="selectedTrip" class="text-sm text-white/90">{{ selectedTrip.origin }} → {{ selectedTrip.destination }}</p>
                </div>

                <!-- Content -->
                <div class="p-0 overflow-y-auto max-h-[70vh]">
                    <div v-if="selectedTrip" class="p-6 space-y-6">
                        <!-- Report View (Only show if hasReport is true) -->
                        <div v-if="selectedTrip.hasReport" class="space-y-6 animate-in slide-in-from-top duration-300">
                            <!-- Progress Steps -->
                            
                            <!-- โ… Report Status Card -->
                            <ReportStatusCard
                                v-if="selectedTrip?.reportData"
                                :status="selectedTrip.reportData.status"
                            />
                            <!-- Summary Block -->
                            <div class="bg-blue-50 border border-blue-200 rounded-xl p-5 shadow-sm">
                                <div class="flex items-center justify-between mb-4">
                                    <h4 class="font-bold text-blue-900">เธชเธฃเธธเธเธเธฒเธฃเธฃเธฒเธขเธเธฒเธ</h4>
                                    <span 
                                        class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold shadow-sm"
                                        :class="{
                                            'bg-yellow-100 text-yellow-800 border border-yellow-200': selectedTrip.reportData?.status === 'PENDING',
                                            'bg-green-100 text-green-800 border border-green-200': ['APPROVED', 'RESOLVED'].includes(selectedTrip.reportData?.status),
                                            'bg-red-100 text-red-800 border border-red-200': selectedTrip.reportData?.status === 'REJECTED'
                                        }"
                                    >
                                        {{ getReportStatusText(selectedTrip.reportData?.status) }}
                                    </span>
                                </div>

                                <div class="space-y-3 text-sm text-blue-800">
                                    <div class="flex justify-between border-b border-blue-100 pb-2">
                                        <span class="opacity-75">เธซเธฑเธงเธเนเธญเธเนเธญเธเธฑเธเธซเธฒ:</span>
                                        <span class="font-semibold">{{ getCategoryText(selectedTrip.reportData) }}</span>
                                    </div>
                                    <div class="flex justify-between border-b border-blue-100 pb-2">
                                        <span class="opacity-75">เธงเธฑเธเธ—เธตเนเนเธเนเธ:</span>
                                        <span class="font-semibold text-right">{{ selectedTrip.reportData?.createdAt ? dayjs(selectedTrip.reportData.createdAt).format('D MMM BBBB HH:mm เธ.') : '-' }}</span>
                                    </div>
                                    <div class="pt-1">
                                        <span class="opacity-75 block mb-1 font-medium">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธ—เธตเนเนเธเนเธ:</span>
                                        <p class="text-gray-700 bg-white/60 p-3 rounded-lg border border-blue-100 italic leading-relaxed">
                                            "{{ selectedTrip.reportData?.description }}"
                                        </p>
                                    </div>
<<<<<<< Updated upstream
=======
                                    <div v-if="getReportLink(selectedTrip.reportData?.description)" class="pt-1">
                                      <span class="opacity-75 block mb-1 font-medium">เธฅเธดเธเธเนเธ—เธตเนเนเธเธ:</span>
                                      <a
                                        :href="getReportLink(selectedTrip.reportData?.description)"
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        class="block break-all text-blue-700 hover:text-blue-800 underline bg-white/60 p-3 rounded-lg border border-blue-100"
                                      >
                                        {{ getReportLink(selectedTrip.reportData?.description) }}
                                      </a>
                                    </div>
>>>>>>> Stashed changes
                                    <div v-if="(selectedTrip.reportData?.images?.length || selectedTrip.reportData?.videos?.length)" class="pt-2">
                                        <span class="opacity-75 block mb-2 font-medium">เนเธเธฅเนเธเธฃเธฐเธเธญเธ:</span>
                                        <div class="flex flex-wrap gap-2">
                                            <img v-if="selectedTrip.reportData?.images" 
                                                v-for="(img, idx) in selectedTrip.reportData.images" :key="`img-${idx}`" :src="img" 
                                                class="w-20 h-20 object-cover rounded-lg border-2 border-white shadow-sm hover:scale-105 transition-transform cursor-pointer" 
                                                @click="window.open(img, '_blank')"
                                            />
                                            <video v-if="selectedTrip.reportData?.videos" 
                                                v-for="(vid, idx) in selectedTrip.reportData.videos" :key="`vid-${idx}`" :src="vid" 
                                                class="w-20 h-20 object-cover rounded-lg border-2 border-white shadow-sm hover:scale-105 transition-transform cursor-pointer" controls
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Admin Response -->
                            <div class="bg-white border border-gray-200 rounded-xl p-5 shadow-sm">
                                <h4 class="font-bold text-gray-900 mb-3 flex items-center gap-2">
                                    <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 013 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                                    </svg>
                                    เธเธฒเธฃเธ•เธญเธเธฃเธฑเธเธเธฒเธเธ—เธตเธกเธเธฒเธ
                                </h4>
                                <div v-if="selectedTrip.reportData?.status !== 'PENDING'" class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                                    <p class="text-sm text-gray-700 leading-relaxed italic">
                                        "{{ selectedTrip.reportData?.adminNotes || 'เนเธ”เนเธฃเธฑเธเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธเน€เธฃเธตเธขเธเธฃเนเธญเธขเนเธฅเนเธง' }}"
                                    </p>
                                    <div v-if="selectedTrip.reportData?.resolvedAt" class="mt-3 pt-3 border-t border-gray-200 flex justify-between items-center text-[10px] text-gray-400">
                                        <span>เธ•เธฃเธงเธเธชเธญเธเน€เธกเธทเนเธญ: {{ dayjs(selectedTrip.reportData.resolvedAt).format('D MMM BBBB HH:mm') }}</span>
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
                </div>

                <!-- Footer -->
                <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                    <button @click="isProgressModalVisible = false"
                        class="w-full px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-all shadow-md active:scale-95">
                        เธเธดเธ”
                    </button>
                </div>
            </div>
        </div>

</template>

<script setup>
import { ref, computed, onMounted, watch, nextTick } from 'vue'
import dayjs from 'dayjs'
import 'dayjs/locale/th'
import buddhistEra from 'dayjs/plugin/buddhistEra'
import ConfirmModal from '~/components/ConfirmModal.vue'
import { useToast } from '~/composables/useToast'
import ReportStatusCard from '@/components/ReportStatusCard.vue'

// Setup dayjs for Thai locale
dayjs.locale('th')
dayjs.extend(buddhistEra)

// media state for review popup
const selectedImages = ref([])
const selectedVideos = ref([])
const imagePreviews = ref([])
const videoPreviews = ref([])

// limits for review attachments
const MAX_IMAGES = 3
const MAX_VIDEOS = 3
const MAX_FILE_SIZE = 50 * 1024 * 1024 // 50 MB

const { $api } = useNuxtApp()
const { toast } = useToast()
const rating = ref(0)
const comment = ref('')

// --- State Management ---
const activeTab = ref('pending')
const selectedTripId = ref(null)
const isProgressModalVisible = ref(false)
const isLoading = ref(false)
const mapContainer = ref(null)
<<<<<<< Updated upstream
const passengerReportCategory = ref('')
=======
const passengerReportCategories = ref([])
const passengerReportCategoryOptions = [
  { value: 'DRIVER_ISSUE', label: 'เธเธคเธ•เธดเธเธฃเธฃเธกเธเธเธเธฑเธ' },
  { value: 'ROAD_ISSUE', label: 'เธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ' },
  { value: 'VEHICLE_ISSUE', label: 'เธฃเธ–เธขเธเธ•เน' },
  { value: 'PAYMENT_ISSUE', label: 'เธเนเธฒเนเธ”เธขเธชเธฒเธฃ' },
  { value: 'OTHER', label: 'เธญเธทเนเธเน' }
]
>>>>>>> Stashed changes
const modalTab = ref('trip')
let map = null
let currentPolyline = null
let currentMarkers = []
const allTrips = ref([])

//review driver
const driverReviews = ref([])
const driverReviewSummary = ref(null)
const selectedDriver = ref(null)
const showDriverReviewModal = ref(false)
const loadingReviewSummary = ref(false)
const selectedTag = ref(null)

// Review tags and labels
const REVIEW_TAGS = ['CLEAN', 'POLITE_DRIVER', 'ON_TIME', 'SAFE_DRIVING', 'FRIENDLY_SERVICE', 'DIRTY', 'RUDE_DRIVER', 'LATE', 'UNSAFE_DRIVING', 'UNFRIENDLY_SERVICE']
const TAG_LABELS = {
  CLEAN: 'เธชเธฐเธญเธฒเธ”',
  POLITE_DRIVER: 'เธเธเธเธฑเธเธกเธฒเธฃเธขเธฒเธ—เธ”เธต',
  ON_TIME: 'เธ•เธฃเธเน€เธงเธฅเธฒ',
  SAFE_DRIVING: 'เธเธฑเธเธเธฅเธญเธ”เธ เธฑเธข',
  FRIENDLY_SERVICE: 'เธเธฃเธดเธเธฒเธฃเน€เธเนเธเธเธฑเธเน€เธญเธ',
  DIRTY: 'เธฃเธ–เนเธกเนเธชเธฐเธญเธฒเธ”',
  RUDE_DRIVER: 'เธเธเธเธฑเธเธเธนเธ”เธเธฒเนเธกเนเธชเธธเธ เธฒเธ',
  LATE: 'เธกเธฒเธชเธฒเธข',
  UNSAFE_DRIVING: 'เธเธฑเธเธฃเธ–เธญเธฑเธเธ•เธฃเธฒเธข',
  UNFRIENDLY_SERVICE: 'เธเธฃเธดเธเธฒเธฃเนเธกเนเน€เธเนเธเธกเธดเธ•เธฃ'
}

let gmap = null // Google Map instance
let activePolyline = null
let startMarker = null
let endMarker = null
let geocoder = null
let placesService = null
const mapReady = ref(false)
let stopMarkers = []

const GMAPS_CB = '__gmapsReady__'

const tabs = [
    { status: 'pending', label: 'เธฃเธญเธ”เธณเน€เธเธดเธเธเธฒเธฃ' },
    { status: 'confirmed', label: 'เธขเธทเธเธขเธฑเธเนเธฅเนเธง' },
    { status: 'rejected', label: 'เธเธเธดเน€เธชเธ' },
    { status: 'cancelled', label: 'เธขเธเน€เธฅเธดเธ' },
    { status: 'completed', label: 'เธเธเธ—เธฃเธดเธเนเธฅเนเธง' },
    { status: 'all', label: 'เธ—เธฑเนเธเธซเธกเธ”' }
]

definePageMeta({ middleware: 'auth' })

const cancelReasonOptions = [
    { value: 'CHANGE_OF_PLAN', label: 'เน€เธเธฅเธตเนเธขเธเนเธเธ/เธกเธตเธเธธเธฃเธฐเธเธฐเธ—เธฑเธเธซเธฑเธ' },
    { value: 'FOUND_ALTERNATIVE', label: 'เธเธเธงเธดเธเธตเน€เธ”เธดเธเธ—เธฒเธเธญเธทเนเธเนเธฅเนเธง' },
    { value: 'DRIVER_DELAY', label: 'เธเธเธเธฑเธเธฅเนเธฒเธเนเธฒเธซเธฃเธทเธญเน€เธฅเธทเนเธญเธเน€เธงเธฅเธฒ' },
    { value: 'PRICE_ISSUE', label: 'เธฃเธฒเธเธฒเธซเธฃเธทเธญเธเนเธฒเนเธเนเธเนเธฒเธขเนเธกเนเน€เธซเธกเธฒเธฐเธชเธก' },
    { value: 'WRONG_LOCATION', label: 'เน€เธฅเธทเธญเธเธเธธเธ”เธฃเธฑเธโ€“เธชเนเธเธเธดเธ”' },
    { value: 'DUPLICATE_OR_WRONG_DATE', label: 'เธเธญเธเธเนเธณเธซเธฃเธทเธญเธเธญเธเธเธดเธ”เธงเธฑเธ' },
    { value: 'SAFETY_CONCERN', label: 'เธเธฑเธเธงเธฅเธ”เนเธฒเธเธเธงเธฒเธกเธเธฅเธญเธ”เธ เธฑเธข' },
    { value: 'WEATHER_OR_FORCE_MAJEURE', label: 'เธชเธ เธฒเธเธญเธฒเธเธฒเธจ/เน€เธซเธ•เธธเธชเธธเธ”เธงเธดเธชเธฑเธข' },
    { value: 'COMMUNICATION_ISSUE', label: 'เธชเธทเนเธญเธชเธฒเธฃเนเธกเนเธชเธฐเธ”เธงเธ/เธ•เธดเธ”เธ•เนเธญเนเธกเนเนเธ”เน' }
]

const isCancelModalVisible = ref(false)
const isSubmittingCancel = ref(false)
const selectedCancelReason = ref('')
const cancelReasonError = ref('')
const tripToCancel = ref(null)

const showReviewModal = ref(false)
const selectedTripForReview = ref(null)
const selectedCategories = ref([])



// --- Computed Properties ---
const filteredTrips = computed(() => {
    if (activeTab.value === 'all') return allTrips.value

    return allTrips.value.filter((trip) => {
        // เธ–เนเธฒ route completed โ’ เธเธฑเธเธเธฑเธเนเธซเนเธญเธขเธนเนเนเธเนเธ—เนเธ completed เน€เธ—เนเธฒเธเธฑเนเธ
        if (trip.routeStatus === 'completed') {
            return activeTab.value === 'completed'
        }

        return trip.status === activeTab.value
    })
})

const filteredReviews = computed(() => {
  if (!selectedTag.value) {
    return driverReviews.value
  }
  
  return driverReviews.value.filter(review => {
    return review.tags && review.tags.includes(selectedTag.value)
  })
})

const driverReviewSummaryComputed = computed(() => {
  if (!driverReviews.value || driverReviews.value.length === 0) {
    return null
  }
  
  const total = driverReviews.value.length
  const average = (driverReviews.value.reduce((sum, r) => sum + (r.rating || 0), 0) / total).toFixed(1)
  
  return {
    totalReviews: total,
    average: average
  }
})

function openReviewModal(trip) {
  selectedTripForReview.value = trip
  showReviewModal.value = true
}


// generic media handler for review (images/videos)
const handleMedia = (e) => {
  const files = Array.from(e.target.files || [])

  files.forEach(file => {
    if (file.size > MAX_FILE_SIZE) {
      toast.error('เธเธเธฒเธ”เนเธเธฅเนเธ•เนเธญเธเนเธกเนเน€เธเธดเธ 50MB')
      return
    }

    if (file.type.startsWith('image/')) {
      if (selectedImages.value.length >= MAX_IMAGES) {
        toast.error(`เน€เธเธดเนเธกเธฃเธนเธเนเธ”เนเธชเธนเธเธชเธธเธ” ${MAX_IMAGES} เธฃเธนเธ`)
        return
      }
      selectedImages.value.push(file)
      const reader = new FileReader()
      reader.onload = (event) => {
        imagePreviews.value.push(event.target.result)
      }
      reader.readAsDataURL(file)
    } else if (file.type.startsWith('video/')) {
      if (selectedVideos.value.length >= MAX_VIDEOS) {
        toast.error(`เน€เธเธดเนเธกเธงเธดเธ”เธตเนเธญเนเธ”เนเธชเธนเธเธชเธธเธ” ${MAX_VIDEOS} เธงเธดเธ”เธตเนเธญ`)
        return
      }
      selectedVideos.value.push(file)
      const url = URL.createObjectURL(file)
      videoPreviews.value.push(url)
    } else {
      toast.error('เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเนเธเธฅเนเธฃเธนเธเธซเธฃเธทเธญเธงเธดเธ”เธตเนเธญเน€เธ—เนเธฒเธเธฑเนเธ')
    }
  })

  e.target.value = ''
}

const removeImage = (index) => {
  selectedImages.value.splice(index, 1)
  imagePreviews.value.splice(index, 1)
}

const removeVideo = (index) => {
  selectedVideos.value.splice(index, 1)
  const url = videoPreviews.value[index]
  if (url) URL.revokeObjectURL(url)
  videoPreviews.value.splice(index, 1)
}

// upload images/videos and return object
const uploadMedia = async () => {
  const result = { images: [], videos: [] }

  const uploadFile = async (file, resourceType) => {
    const formData = new FormData()
    formData.append("file", file)
    formData.append("upload_preset", "painamnae_G1_sec11")

    const endpoint = `https://api.cloudinary.com/v1_1/dawfywcw9/${resourceType}/upload`
    const { secure_url } = await $fetch(endpoint, {
      method: "POST",
      body: formData
    })
    return secure_url
  }

  for (const file of selectedImages.value) {
    const url = await uploadFile(file, 'image')
    result.images.push(url)
  }
  for (const file of selectedVideos.value) {
    const url = await uploadFile(file, 'video')
    result.videos.push(url)
  }

  return result
}



// โญ เน€เธเธฅเธตเนเธขเธเธซเธกเธงเธ”เธ•เธฒเธก rating
const reviewCategories = computed(() => {
  if (rating.value === 0) return []
  if (rating.value <= 2) return negativeCategories
  return positiveCategories
})


// ๐”ฅ เธฃเธตเน€เธเนเธ• tag เธ—เธธเธเธเธฃเธฑเนเธเธ—เธตเน rating เน€เธเธฅเธตเนเธขเธ
watch(rating, () => {
  selectedCategories.value = []
})

const positiveCategories = [
  { label: 'เธชเธฐเธญเธฒเธ”', value: 'CLEAN' },
  { label: 'เธเธเธเธฑเธเธกเธฒเธฃเธขเธฒเธ—เธ”เธต', value: 'POLITE_DRIVER' },
  { label: 'เธ•เธฃเธเน€เธงเธฅเธฒ', value: 'ON_TIME' },
  { label: 'เธเธฑเธเธเธฅเธญเธ”เธ เธฑเธข', value: 'SAFE_DRIVING' },
  { label: 'เธเธฃเธดเธเธฒเธฃเน€เธเนเธเธเธฑเธเน€เธญเธ', value: 'FRIENDLY_SERVICE' }
]

const negativeCategories = [
  { label: 'เธฃเธ–เนเธกเนเธชเธฐเธญเธฒเธ”', value: 'DIRTY' },
  { label: 'เธเธเธเธฑเธเธเธนเธ”เธเธฒเนเธกเนเธชเธธเธ เธฒเธ', value: 'RUDE_DRIVER' },
  { label: 'เธกเธฒเธชเธฒเธข', value: 'LATE' },
  { label: 'เธเธฑเธเธฃเธ–เธญเธฑเธเธ•เธฃเธฒเธข', value: 'UNSAFE_DRIVING' },
  { label: 'เธเธฃเธดเธเธฒเธฃเนเธกเนเน€เธเนเธเธกเธดเธ•เธฃ', value: 'UNFRIENDLY_SERVICE' }
]

const images = ref([])
const resetForm = () => {
  rating.value = 0
  selectedCategories.value = []
  comment.value = ''
  images.value = []
  imagePreviews.value = []
}

const closeModal = () => {
  showReviewModal.value = false
  resetForm()
}

const submitReview = async () => {
  if (!rating.value) {
    toast.error("เธเธฃเธธเธ“เธฒเนเธซเนเธเธฐเนเธเธเธเนเธญเธ")
    return
  }

  if (!selectedTripForReview.value?.id) {
    toast.error("เนเธกเนเธเธเธเนเธญเธกเธนเธฅเธเธฒเธฃเธเธญเธ")
    return
  }

  try {
    // Upload media เธเนเธญเธ
    const { images: imageUrls, videos: videoUrls } = await uploadMedia()

    await $api('/reviews', {
      method: 'POST',
      body: {
        bookingId: selectedTripForReview.value.id,
        rating: rating.value,
        comment: comment.value?.trim() || null,
        tags: selectedCategories.value || [],
        images: imageUrls || [],
        videos: videoUrls || []
      }
    })

    toast.success("เธฃเธตเธงเธดเธงเธชเธณเน€เธฃเนเธ ๐")

    resetReviewForm()

    await fetchMyTrips()

  } catch (error) {
    const message =
      error?.data?.message ||   // เธชเธณเธเธฑเธเนเธ Nuxt 3
      error?.response?.data?.message ||
      error?.message ||
      "Something went wrong"

    toast.error(message)
  }
}

const resetReviewForm = () => {
  showReviewModal.value = false
  rating.value = 0
  comment.value = ""
  selectedCategories.value = []
  selectedImages.value = []
  imagePreviews.value = []
  selectedVideos.value = []
  videoPreviews.value = []
}

const selectedTrip = computed(() => {
    return allTrips.value.find((trip) => trip.id === selectedTripId.value) || null
})

function cleanAddr(a) {
    return (a || '')
        .replace(/,?\s*(Thailand|เนเธ—เธข|เธเธฃเธฐเน€เธ—เธจ)\s*$/i, '')
        .replace(/\s{2,}/g, ' ')
        .trim()
}

// --- Methods ---
async function fetchMyTrips() {
    isLoading.value = true
    try {
        const bookings = await $api('/bookings/me')

        // map เธเนเธญเธกเธนเธฅเธเธทเนเธเธเธฒเธเธเนเธญเธ (เธ•เธฑเนเธเธเธทเนเธญเธเธฑเนเธงเธเธฃเธฒเธงเน€เธเนเธเธเธดเธเธฑเธ” เนเธฅเนเธงเนเธ reverse geocode เธ เธฒเธขเธซเธฅเธฑเธ)
        const formatted = bookings.map((b) => {
            const driverData = {
                id: b.route.driver.id, 
                name: `${b.route.driver.firstName} ${b.route.driver.lastName}`.trim(),
                image:
                    b.route.driver.profilePicture ||
                    `https://ui-avatars.com/api/?name=${encodeURIComponent(b.route.driver.firstName || 'U')}&background=random&size=64`,
                rating: 0,
                reviews: 0
            }


            const carDetails = []
            if (b.route.vehicle) {
                carDetails.push(`${b.route.vehicle.vehicleModel} (${b.route.vehicle.vehicleType})`)
                if (Array.isArray(b.route.vehicle.amenities) && b.route.vehicle.amenities.length) {
                    carDetails.push(...b.route.vehicle.amenities)
                }
            } else {
                carDetails.push('เนเธกเนเธกเธตเธเนเธญเธกเธนเธฅเธฃเธ–')
            }

            const start = b.route.startLocation
            const end = b.route.endLocation

            const wp = b.route.waypoints || {}
            const baseList =
                (Array.isArray(wp.used) && wp.used.length ? wp.used : Array.isArray(wp.requested) ? wp.requested : []) || []
            const orderedList =
                Array.isArray(wp.optimizedOrder) && wp.optimizedOrder.length === baseList.length
                    ? wp.optimizedOrder.map((i) => baseList[i])
                    : baseList

            const stops = orderedList
                .map((p) => {
                    const name = p?.name || ''
                    const address = cleanAddr(p?.address || '')
                    const fallback =
                        p?.lat != null && p?.lng != null ? `(${Number(p.lat).toFixed(6)}, ${Number(p.lng).toFixed(6)})` : ''
                    const title = name || fallback
                    return address ? `${title} โ€” ${address}` : title
                })
                .filter(Boolean)

            const stopsCoords = orderedList
                .map((p) =>
                    p && typeof p.lat === 'number' && typeof p.lng === 'number'
                        ? { lat: Number(p.lat), lng: Number(p.lng), name: p.name || '', address: p.address || '' }
                        : null
                )
                .filter(Boolean)

            return {
                id: b.id,
                status: String(b.status || '').toLowerCase(),
                status: b.status.toLowerCase(),
                routeStatus: String(b.route.status || '').toLowerCase(),
                origin: start?.name || `(${Number(start.lat).toFixed(2)}, ${Number(start.lng).toFixed(2)})`,
                destination: end?.name || `(${Number(end.lat).toFixed(2)}, ${Number(end.lng).toFixed(2)})`,
                originAddress: start?.address ? cleanAddr(start.address) : null,
                destinationAddress: end?.address ? cleanAddr(end.address) : null,
                originHasName: !!start?.name,
                destinationHasName: !!end?.name,
                pickupPoint: b.pickupLocation?.name || '-',
                date: dayjs(b.route.departureTime).format('D MMMM BBBB'),
                time: dayjs(b.route.departureTime).format('HH:mm เธ.'),
                price: (b.route.pricePerSeat || 0) * (b.numberOfSeats || 1),
                seats: b.numberOfSeats || 1,
                driver: driverData,
                coords: [
                    [start.lat, start.lng],
                    [end.lat, end.lng]
                ],
                polyline: b.route.routePolyline || null, // เนเธเนเน€เธกเธทเนเธญเธกเธต
                stops,
                stopsCoords,
                carDetails,
                conditions: b.route.conditions,
                photos: b.route.vehicle?.photos || [],
                durationText:
                    (typeof b.route.duration === 'string' ? formatDuration(b.route.duration) : b.route.duration) ||
                    (typeof b.route.durationSeconds === 'number' ? `${Math.round(b.route.durationSeconds / 60)} เธเธฒเธ—เธต` : '-'),
                distanceText:
                    (typeof b.route.distance === 'string' ? formatDistance(b.route.distance) : b.route.distance) ||
                    (typeof b.route.distanceMeters === 'number' ? `${(b.route.distanceMeters / 1000).toFixed(1)} เธเธก.` : '-') ,
                hasReport: false ,
                reportData: null
            }
        })

        allTrips.value = formatted
        await checkReportsForTrips()
        await Promise.all(
            allTrips.value.map((t, i) =>
                loadDriverReviews(t.driver.id, i)
            )
        )

        // เธฃเธญเนเธซเนเนเธเธเธ—เธตเนเธเธฃเนเธญเธกเธเนเธญเธ เนเธฅเนเธงเธเนเธญเธข reverse geocode เน€เธเธทเนเธญเนเธ”เน "เธเธทเนเธญเธชเธ–เธฒเธเธ—เธตเน" เธชเธงเธขเน
        await waitMapReady()

        const jobs = allTrips.value.map(async (t, idx) => {
            const [o, d] = await Promise.all([reverseGeocode(t.coords[0][0], t.coords[0][1]), reverseGeocode(t.coords[1][0], t.coords[1][1])])
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
        console.error('Failed to fetch my trips:', error)
        allTrips.value = []
    } finally {
        isLoading.value = false
    }
    
    
}

//review driver
async function loadDriverReviews(driverId, tripIndex) {
    try {
        const res = await $api(`/reviews/driver/${driverId}`)

        const reviews = res || []

        //เธเธณเธเธงเธ“เธเธฐเนเธเธเธเธฃเธดเธ
        const avg =
            reviews.length > 0
                ? reviews.reduce((s, r) => s + r.rating, 0) / reviews.length
                : 0

        allTrips.value[tripIndex].driver.rating = avg.toFixed(1)
        allTrips.value[tripIndex].driver.reviews = reviews.length

    } catch (e) {
        console.error('load driver reviews error', e)
    }
}
async function openDriverReviews(driver) {
    try {
        const res = await $api(`/reviews/driver/${driver.id}`)

        driverReviews.value = res || []
        selectedDriver.value = driver
        selectedTag.value = null
        showDriverReviewModal.value = true
    } catch (e) {
        console.error(e)
    }
}

function closeDriverReviewModal() {
    showDriverReviewModal.value = false
    selectedDriver.value = null
    driverReviews.value = []
    selectedTag.value = null
}

function parsedImages(review) {
  if (!review.images) return []
  
  if (typeof review.images === 'string') {
    try {
      return JSON.parse(review.images)
    } catch {
      return [review.images].filter(Boolean)
    }
  }
  
  return Array.isArray(review.images) ? review.images : []
}

function parsedVideos(review) {
  if (!review.videos) return []
  
  if (typeof review.videos === 'string') {
    try {
      return JSON.parse(review.videos)
    } catch {
      return [review.videos].filter(Boolean)
    }
  }
  
  return Array.isArray(review.videos) ? review.videos : []
}

function waitMapReady() {
    return new Promise((resolve) => {
        if (mapReady.value) return resolve(true)
        const t = setInterval(() => {
            if (mapReady.value) {
                clearInterval(t)
                resolve(true)
            }
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
    const byType = (t) => comps.find((c) => c.types.includes(t))?.long_name
    const byTypeShort = (t) => comps.find((c) => c.types.includes(t))?.short_name

    const types = geocodeResult.types || []
    const isPoi = types.includes('point_of_interest') || types.includes('establishment') || types.includes('premise')

    let name = null
    if (isPoi && geocodeResult.place_id) {
        const poiName = await getPlaceName(geocodeResult.place_id)
        if (poiName) name = poiName
    }
    if (!name) {
        const streetNumber = byType('street_number')
        const route = byType('route')
        name = streetNumber && route ? `${streetNumber} ${route}` : route || geocodeResult.formatted_address || null
    }

    const sublocality =
        byType('sublocality') || byType('neighborhood') || byType('locality') || byType('administrative_area_level_2')
    const province = byType('administrative_area_level_1') || byTypeShort('administrative_area_level_1')

    let area = null
    if (sublocality && province) area = `${sublocality}, ${province}`
    else if (province) area = province

    if (name) name = name.replace(/,?\s*(Thailand|เนเธ—เธข)\s*$/i, '')
    return { name, area }
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

const getTripCount = (status) => {
    if (status === 'all') return allTrips.value.length

    return allTrips.value.filter((trip) => {
        if (trip.routeStatus === 'completed') {
            return status === 'completed'
        }

        return trip.status === status
    }).length
}


const toggleTripDetails = (tripId) => {
    const tripForMap = allTrips.value.find((trip) => trip.id === tripId)
    if (tripForMap) {
        updateMap(tripForMap)
    }

    if (selectedTripId.value === tripId) {
        selectedTripId.value = null
    } else {
        selectedTripId.value = tripId
    }
}

async function updateMap(trip) {
    if (!trip) return
    await waitMapReady()
    if (!gmap) return

    // cleanup เธเธญเธเน€เธ”เธดเธก
    if (activePolyline) {
        activePolyline.setMap(null)
        activePolyline = null
    }
    if (startMarker) {
        startMarker.setMap(null)
        startMarker = null
    }
    if (endMarker) {
        endMarker.setMap(null)
        endMarker = null
    }
    if (stopMarkers.length) {
        stopMarkers.forEach((m) => m.setMap(null))
        stopMarkers = []
    }

    const start = { lat: Number(trip.coords[0][0]), lng: Number(trip.coords[0][1]) }
    const end = { lat: Number(trip.coords[1][0]), lng: Number(trip.coords[1][1]) }

    // เธซเธกเธธเธ” A/B
    startMarker = new google.maps.Marker({ position: start, map: gmap, label: 'A' })
    endMarker = new google.maps.Marker({ position: end, map: gmap, label: 'B' })

    if (Array.isArray(trip.stopsCoords) && trip.stopsCoords.length) {
        stopMarkers = trip.stopsCoords.map(
            (s, idx) =>
                new google.maps.Marker({
                    position: { lat: s.lat, lng: s.lng },
                    map: gmap,
                    icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
                    title: s.name || s.address || `เธเธธเธ”เนเธงเธฐ ${idx + 1}`
                })
        )
    }

    // เน€เธชเนเธเธ—เธฒเธเธเธฒเธ polyline เธ–เนเธฒเธกเธต
    if (trip.polyline && google.maps.geometry?.encoding) {
        const path = google.maps.geometry.encoding.decodePath(trip.polyline)
        activePolyline = new google.maps.Polyline({
            path,
            map: gmap,
            strokeColor: '#2563eb',
            strokeOpacity: 0.9,
            strokeWeight: 5
        })
        const bounds = new google.maps.LatLngBounds()
        path.forEach((p) => bounds.extend(p))

        if (trip.stopsCoords?.length) {
            trip.stopsCoords.forEach((s) => bounds.extend(new google.maps.LatLng(s.lat, s.lng)))
        }

        gmap.fitBounds(bounds)
    } else {
        // เนเธกเนเธกเธต polyline โ’ fit เธเธฒเธเธเธธเธ” A-B + เธเธธเธ”เนเธงเธฐ
        const bounds = new google.maps.LatLngBounds()
        bounds.extend(start)
        bounds.extend(end)
        if (trip.stopsCoords?.length) {
            trip.stopsCoords.forEach((s) => bounds.extend(new google.maps.LatLng(s.lat, s.lng)))
        }
        gmap.fitBounds(bounds)
    }
}

// --- Modal Logic ---
const isModalVisible = ref(false)
const tripToAction = ref(null)
const modalContent = ref({
    title: '',
    message: '',
    confirmText: '',
    action: null,
    variant: 'danger'
})

const openConfirmModal = (trip, action) => {
    tripToAction.value = trip
    if (action === 'cancel') {
        // เธ•เธญเธเธเธตเนเนเธกเนเนเธเนเธ—เธฒเธเธขเธทเธเธขเธฑเธเธ•เธฃเธ เน เนเธฅเนเธง เนเธ•เนเธเธเนเธเธฃเธเนเธงเนเน€เธเธทเนเธญเธญเธเธฒเธเธ•
        modalContent.value = {
            title: 'เธขเธทเธเธขเธฑเธเธเธฒเธฃเธขเธเน€เธฅเธดเธเธเธฒเธฃเธเธญเธ',
            message: `เธเธธเธ“เธ•เนเธญเธเธเธฒเธฃเธขเธเน€เธฅเธดเธเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเนเธเธ—เธตเน "${trip.destination}" เนเธเนเธซเธฃเธทเธญเนเธกเน?`,
            confirmText: 'เนเธเน, เธขเธเน€เธฅเธดเธเธเธฒเธฃเธเธญเธ',
            action: 'cancel',
            variant: 'danger'
        }
    } else if (action === 'delete') {
        modalContent.value = {
            title: 'เธขเธทเธเธขเธฑเธเธเธฒเธฃเธฅเธเธฃเธฒเธขเธเธฒเธฃ',
            message: `เธเธธเธ“เธ•เนเธญเธเธเธฒเธฃเธฅเธเธฃเธฒเธขเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเนเธเธ—เธตเน "${trip.destination}" เธญเธญเธเธเธฒเธเธเธฃเธฐเธงเธฑเธ•เธดเนเธเนเธซเธฃเธทเธญเนเธกเน?`,
            confirmText: 'เนเธเน, เธฅเธเธฃเธฒเธขเธเธฒเธฃ',
            action: 'delete',
            variant: 'danger'
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
    const tripId = tripToAction.value.id
    try {
        if (action === 'cancel') {
            // เนเธกเนเธขเธดเธ PATCH เธ•เธฃเธ เน โ€” เธ•เนเธญเธเนเธซเนเธเธนเนเนเธเนเน€เธฅเธทเธญเธเน€เธซเธ•เธธเธเธฅเธเนเธญเธ
            openCancelModal(tripToAction.value)
            closeConfirmModal()
            return
        } else if (action === 'delete') {
            await $api(`/bookings/${tripId}`, { method: 'DELETE' })
            toast.success('เธฅเธเธฃเธฒเธขเธเธฒเธฃเธชเธณเน€เธฃเนเธ', 'เธฃเธฒเธขเธเธฒเธฃเนเธ”เนเธ–เธนเธเธฅเธเธญเธญเธเธเธฒเธเธเธฃเธฐเธงเธฑเธ•เธดเนเธฅเนเธง')
        }
        closeConfirmModal()
        await fetchMyTrips()
    } catch (error) {
        console.error(`Failed to ${action} booking:`, error)
        toast.error('เน€เธเธดเธ”เธเนเธญเธเธดเธ”เธเธฅเธฒเธ”', error.data?.message || 'เนเธกเนเธชเธฒเธกเธฒเธฃเธ–เธ”เธณเน€เธเธดเธเธเธฒเธฃเนเธ”เน')
        closeConfirmModal()
    }
}

function openCancelModal(trip) {
    tripToCancel.value = trip
    selectedCancelReason.value = ''
    cancelReasonError.value = ''
    isCancelModalVisible.value = true
}

function closeCancelModal() {
    isCancelModalVisible.value = false
    tripToCancel.value = null
}

async function submitCancel() {
    if (!selectedCancelReason.value) {
        cancelReasonError.value = 'เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเน€เธซเธ•เธธเธเธฅ'
        return
    }
    if (!tripToCancel.value) return

    isSubmittingCancel.value = true
    try {
        await $api(`/bookings/${tripToCancel.value.id}/cancel`, {
            method: 'PATCH',
            body: { reason: selectedCancelReason.value } // โ… เธ•เธฃเธเธเธฑเธ schema เธเธฑเนเธ backend
        })
        toast.success('เธขเธเน€เธฅเธดเธเธเธฒเธฃเธเธญเธเธชเธณเน€เธฃเนเธ', 'เธฃเธฐเธเธเธเธฑเธเธ—เธถเธเน€เธซเธ•เธธเธเธฅเนเธฅเนเธง')
        closeCancelModal()
        await fetchMyTrips()
    } catch (err) {
        console.error('Cancel booking failed:', err)
        toast.error('เน€เธเธดเธ”เธเนเธญเธเธดเธ”เธเธฅเธฒเธ”', err?.data?.message || 'เนเธกเนเธชเธฒเธกเธฒเธฃเธ–เธขเธเน€เธฅเธดเธเนเธ”เน')
    } finally {
        isSubmittingCancel.value = false
    }
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
        else meters += n // เธชเธกเธกเธ•เธดเน€เธเนเธเน€เธกเธ•เธฃเธ–เนเธฒเนเธกเนเธเธเธซเธเนเธงเธข
    }

    if (meters >= 1000) {
        const km = Math.round((meters / 1000) * 10) / 10 // เธเธฑเธ”เธ—เธจเธเธดเธขเธก 1 เธ•เธณเนเธซเธเนเธ
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
        else minutes += n // เธเธฒเธ—เธต
    }

    const h = Math.floor(minutes / 60)
    const m = Math.round(minutes % 60)
    return h ? (m ? `${h} เธเธก. ${m} เธเธฒเธ—เธต` : `${h} เธเธก.`) : `${m} เธเธฒเธ—เธต`
}

// --- Status Helper Methods ---
function getStatusDotClass(status) {
    const classMap = {
        pending: 'bg-yellow-400',
        confirmed: 'bg-blue-500',
        completed: 'bg-green-500',
        rejected: 'bg-red-500',
        cancelled: 'bg-gray-400'
    }
    return classMap[status] || 'bg-gray-300'
}

function getStatusText(status) {
    const textMap = {
        pending: 'เธฃเธญเธ”เธณเน€เธเธดเธเธเธฒเธฃ',
        confirmed: 'เธขเธทเธเธขเธฑเธเนเธฅเนเธง',
        completed: 'เน€เธชเธฃเนเธเธชเธดเนเธ',
        rejected: 'เธเธเธดเน€เธชเธ',
        cancelled: 'เธขเธเน€เธฅเธดเธเนเธ”เธขเธเธนเนเนเธ”เธขเธชเธฒเธฃ'
    }
    return textMap[status] || '-'
}

function getStatusDescription(status) {
    const descMap = {
        pending: 'เธเธณเธฅเธฑเธเธฃเธญเนเธซเนเธเธเธเธฑเธเธขเธทเธเธขเธฑเธเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ',
        confirmed: 'เธเธเธเธฑเธเธขเธทเธเธขเธฑเธเนเธฅเนเธง เธเธฃเนเธญเธกเน€เธ”เธดเธเธ—เธฒเธ',
        completed: 'เธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเน€เธชเธฃเนเธเธชเธดเนเธเนเธฅเนเธง',
        rejected: 'เธเธเธเธฑเธเธเธเธดเน€เธชเธเธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธ',
        cancelled: 'เธเธธเธ“เธขเธเน€เธฅเธดเธเธเธฒเธฃเธเธญเธ'
    }
    return descMap[status] || '-'
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
        PASSENGER_ISSUE: "เธเธคเธ•เธดเธเธฃเธฃเธกเธเธนเนเนเธ”เธขเธชเธฒเธฃเธฃเนเธงเธกเธ—เธฃเธดเธเธ—เธตเนเนเธกเนเน€เธซเธกเธฒเธฐเธชเธก",
        ROAD_ISSUE: "เธเธฑเธเธซเธฒเธฃเธฐเธซเธงเนเธฒเธเน€เธชเนเธเธ—เธฒเธ",
        SAFETY_ISSUE: "เธเธคเธ•เธดเธเธฃเธฃเธกเธเธฒเธฃเธเธฑเธเธเธตเนเธ—เธตเนเนเธกเนเธเธฅเธญเธ”เธ เธฑเธข",
        PAYMENT_ISSUE: "เธเธฑเธเธซเธฒเธเธฒเธฃเธเธณเธฃเธฐเน€เธเธดเธ",
        NO_SHOW: "เนเธกเนเธกเธฒเธเธเธ•เธฒเธกเธเธธเธ”เธเธฑเธ”เธซเธกเธฒเธข",
        OTHER: "เธญเธทเนเธ เน"
    };
    return cats[category] || category || "เธ—เธฑเนเธงเนเธ";
}

<<<<<<< Updated upstream
=======
  function getReportLink(description) {
    if (!description) return ''
    const linkLine = String(description)
      .split('\n')
      .map(line => line.trim())
      .find(line => line.startsWith('เธฅเธดเธเธเน:'))
    if (!linkLine) return ''
    return linkLine.replace('เธฅเธดเธเธเน:', '').trim()
  }

  function getReportDetailText(description) {
    if (!description) return '-'
    return String(description)
      .split('\n')
      .filter(line => !line.trim().startsWith('เธฅเธดเธเธเน:'))
      .join('\n')
      .trim() || '-'
  }

>>>>>>> Stashed changes
// --- Lifecycle and Watchers ---
useHead({
    title: 'เธเธฒเธฃเน€เธ”เธดเธเธ—เธฒเธเธเธญเธเธเธฑเธ - เนเธเธเธณเนเธซเธเน',
    link: [{ rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap' }],
    script:
        process.client && !window.google?.maps
            ? [
                {
                    key: 'gmaps',
                    src: `https://maps.googleapis.com/maps/api/js?key=${useRuntimeConfig().public.googleMapsApiKey}&libraries=places,geometry&callback=__gmapsReady__`,
                    async: true,
                    defer: true
                }
            ]
            : []
})

onMounted(() => {
    // เธ–เนเธฒ script เนเธซเธฅเธ”เนเธฅเนเธง
    if (window.google?.maps) {
        initializeMap()
        fetchMyTrips().then(() => {
            // เธ–เนเธฒเธกเธตเธเนเธญเธกเธนเธฅเนเธฅเนเธงเนเธฅเธฐเธขเธฑเธเนเธกเนเนเธ”เนเน€เธฅเธทเธญเธ เนเธซเนเนเธเธงเนเนเธเธเธ—เธตเนเธเธญเธเธฃเธฒเธขเธเธฒเธฃเนเธฃเธเนเธเนเธ—เนเธเธเธฑเธเธเธธเธเธฑเธ
            if (filteredTrips.value.length) updateMap(filteredTrips.value[0])
        })
        return
    }

    // เธขเธฑเธเนเธกเนเนเธซเธฅเธ”เน€เธชเธฃเนเธ: เธ•เธฑเนเธ callback
    window[GMAPS_CB] = () => {
        try {
            delete window[GMAPS_CB]
        } catch { }
        initializeMap()
        fetchMyTrips().then(() => {
            if (filteredTrips.value.length) updateMap(filteredTrips.value[0])
        })
    }
})

//review driver
watch(showDriverReviewModal, async (val) => {
  if (!val) {
    return
  }
  // Summary is now calculated from driverReviews via computed property
})

function initializeMap() {
    if (!mapContainer.value || gmap) return
    gmap = new google.maps.Map(mapContainer.value, {
        center: { lat: 13.7563, lng: 100.5018 },
        zoom: 6,
        mapTypeControl: false,
        streetViewControl: false,
        fullscreenControl: true
    })
    geocoder = new google.maps.Geocoder()
    placesService = new google.maps.places.PlacesService(gmap)
    mapReady.value = true
}

// --- Report Modal State
const showReportModal = ref(false)
const reportTrip = ref(null)
const reportText = ref('')
const reportImages = ref([])
const reportVideos = ref([])

// limits for report attachments
const REPORT_MAX_IMAGES = 3
const REPORT_MAX_VIDEOS = 3
const REPORT_MAX_FILE_SIZE = 50 * 1024 * 1024 // 50 MB

function openReportModal(trip) {
    reportTrip.value = trip
    passengerReportCategory.value = ''
    reportText.value = ''
    resetReportAttachments()
    showReportModal.value = true
}

function openProgressForTrip(trip) {
    selectedTripId.value = trip.id
    modalTab.value = 'report' // Open to report tab by default when tracking
    isProgressModalVisible.value = true
}

function closeReportModal() {
    showReportModal.value = false
    resetReportAttachments()
    setTimeout(() => {
        reportTrip.value = null
    }, 200)
}

function resetReportAttachments() {
    reportImages.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    reportImages.value = []
    reportVideos.value.forEach(it => it.url && URL.revokeObjectURL(it.url))
    reportVideos.value = []
}

function handleReportFiles(e) {
    const files = Array.from(e.target.files || [])

    files.forEach(f => {
        if (f.size > REPORT_MAX_FILE_SIZE) {
            toast.error('เธเธเธฒเธ”เนเธเธฅเนเธ•เนเธญเธเนเธกเนเน€เธเธดเธ 50MB')
            return
        }
        if (f.type.startsWith('image/')) {
            if (reportImages.value.length >= REPORT_MAX_IMAGES) {
                toast.error(`เน€เธเธดเนเธกเธฃเธนเธเนเธ”เนเธชเธนเธเธชเธธเธ” ${REPORT_MAX_IMAGES} เธฃเธนเธ`)
                return
            }
            reportImages.value.push({ file: f, url: URL.createObjectURL(f) })
        } else if (f.type.startsWith('video/')) {
            if (reportVideos.value.length >= REPORT_MAX_VIDEOS) {
                toast.error(`เน€เธเธดเนเธกเธงเธดเธ”เธตเนเธญเนเธ”เนเธชเธนเธเธชเธธเธ” ${REPORT_MAX_VIDEOS} เธงเธดเธ”เธตเนเธญ`)
                return
            }
            reportVideos.value.push({ file: f, url: URL.createObjectURL(f) })
        } else {
            toast.error('เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเนเธเธฅเนเธฃเธนเธเธซเธฃเธทเธญเธงเธดเธ”เธตเนเธญเน€เธ—เนเธฒเธเธฑเนเธ')
        }
    })
    e.target.value = ''
}

function removeReportImage(idx) {
    const it = reportImages.value[idx]
    if (it?.url) URL.revokeObjectURL(it.url)
    reportImages.value.splice(idx, 1)
}

function removeReportVideo(idx) {
    const it = reportVideos.value[idx]
    if (it?.url) URL.revokeObjectURL(it.url)
    reportVideos.value.splice(idx, 1)
}

async function submitReport() {
    if (!reportTrip.value) return

<<<<<<< Updated upstream
    if (!passengerReportCategory.value) {
        toast.error('กรุณาเลือกหัวข้อปัญหา', 'กรุณาเลือกหัวข้อปัญหาที่พบ')
=======
    if (!passengerReportCategories.value.length) {
        toast.error('เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒ', 'เธเธฃเธธเธ“เธฒเน€เธฅเธทเธญเธเธซเธฑเธงเธเนเธญเธเธฑเธเธซเธฒเธ—เธตเนเธเธ')
>>>>>>> Stashed changes
        return
    }

  // Enforce max comment length
  if (reportText.value && reportText.value.length > 501) {
    toast.error('เธเนเธญเธเธงเธฒเธกเธ•เนเธญเธเนเธกเนเน€เธเธดเธ 501 เธ•เธฑเธงเธญเธฑเธเธฉเธฃ')
    return
  }

    try {
        const fd = new FormData()

<<<<<<< Updated upstream
=======
        const selectedCategoryLabels = passengerReportCategoryOptions
          .filter(opt => passengerReportCategories.value.includes(opt.value))
          .map(opt => opt.label)

        const primaryCategory = passengerReportCategories.value[0]
        const reportDescription = `เธซเธกเธงเธ”เธซเธกเธนเนเธ—เธตเนเน€เธฅเธทเธญเธ: ${selectedCategoryLabels.join(', ')}\n\n${reportText.value || 'เนเธกเนเนเธ”เนเธฃเธฐเธเธธเธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”'}`

>>>>>>> Stashed changes
        fd.append('type', 'PASSENGER')
        fd.append('category', passengerReportCategory.value)
        fd.append('description', reportText.value || 'ไม่ได้ระบุรายละเอียด')

        // โ… append เน€เธเธเธฒเธฐเธ•เธญเธเธกเธตเธเนเธฒเน€เธ—เนเธฒเธเธฑเนเธ
        if (reportTrip.value?.routeId) {
            fd.append('routeId', reportTrip.value.routeId)
        }

        if (reportTrip.value?.id) {
            fd.append('bookingId', reportTrip.value.id)
        }

        if (reportTrip.value?.driver?.id) {
            fd.append('targetUserId', reportTrip.value.driver.id)
        }

        // โ… images
        reportImages.value.forEach((it) => {
            if (it?.file) {
                fd.append('images', it.file)
            }
        })
        // โ… videos
        reportVideos.value.forEach((it) => {
            if (it?.file) {
                fd.append('videos', it.file)
            }
        })

        await $api('/reports', {
            method: 'POST',
            body: fd
        })

        toast.success('เธเธญเธเธเธธเธ“เธ—เธตเนเนเธเนเธเธฃเธฒเธขเธเธฒเธ', 'เธ—เธตเธกเธเธฒเธเธเธฐเธ•เธฃเธงเธเธชเธญเธเนเธเน€เธฃเนเธงเน เธเธตเน')

        // update trip in place
        const tripInList = allTrips.value.find(
            t => t.id === reportTrip.value.id
        )

        if (tripInList) {
            tripInList.hasReport = true
            tripInList.reportData = {
                status: 'PENDING',
                category: passengerReportCategory.value,
                description: reportText.value || 'ไม่ได้ระบุรายละเอียด',
                createdAt: new Date(),
                adminNotes: null
            }
        }

        closeReportModal()
        checkReportsForTrips()

    } catch (err) {
        console.error('Failed to submit report', err)
        toast.error(
            'เนเธกเนเธชเธฒเธกเธฒเธฃเธ–เธชเนเธเธฃเธฒเธขเธเธฒเธเนเธ”เน',
            err?.data?.message || 'เนเธเธฃเธ”เธฅเธญเธเธญเธตเธเธเธฃเธฑเนเธ'
        )
    }
}

async function checkReportsForTrips() {
    try {
        // Fetch all reports made by the current user
        const res = await $api('/reports/me')
        const reports = res.data || res || []
        
        // Match reports with trips by bookingId
        allTrips.value.forEach(trip => {
            const report = reports.find(r => r.bookingId === trip.id && r.type === 'PASSENGER')
            if (report) {
                trip.hasReport = true
                trip.reportData = report
            }
        })
    } catch (e) {
        console.error('Failed to check reports for trips', e)
    }
}
</script>

<style scoped>
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
</style>

