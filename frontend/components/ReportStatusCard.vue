<template>
  <div class="bg-white rounded-lg shadow-md p-6 text-center">
    <!-- icon circle -->
    <div :class="circleClass">
      <!-- SUCCESS -->
      <svg
        v-if="isSuccess"
        class="w-10 h-10"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="3"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M5 13l4 4L19 7"
        />
      </svg>

      <!-- REJECT -->
      <svg
        v-else-if="isRejected"
        class="w-10 h-10"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="3"
      >
        <path stroke-linecap="round" stroke-linejoin="round" d="M6 6l12 12M6 18L18 6" />
      </svg>

      <!-- PENDING / DEFAULT -->
      <svg
        v-else
        class="w-10 h-10 animate-pulse"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
      >
        <circle cx="12" cy="12" r="9" />
        <path stroke-linecap="round" stroke-linejoin="round" d="M12 7v5l3 3" />
      </svg>
    </div>

    <!-- title -->
    <h2 :class="titleClass" class="text-2xl font-bold mb-2">
      {{ titleText }}
    </h2>

    <!-- description -->
    <p class="text-gray-600 text-sm">
      {{ descriptionText }}
    </p>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  status: String
})

/* ---------------- STATUS FLAGS ---------------- */
const isSuccess = computed(() =>
  ['RESOLVED', 'APPROVED'].includes(props.status)
)

const isRejected = computed(() =>
  props.status === 'REJECTED'
)

/* ---------------- COLOR ---------------- */
const circleClass = computed(() => {
  const map = {
    PENDING: 'w-20 h-20 bg-orange-100 text-orange-600 rounded-full flex items-center justify-center mx-auto mb-4',
    IN_PROGRESS: 'w-20 h-20 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center mx-auto mb-4',
    RESOLVED: 'w-20 h-20 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-4',
    APPROVED: 'w-20 h-20 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-4',
    REJECTED: 'w-20 h-20 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4'
  }
  return map[props.status] || map.PENDING
})

/* ---------------- TEXT ---------------- */
const titleClass = computed(() => {
  const map = {
    PENDING: 'text-orange-600',
    IN_PROGRESS: 'text-blue-600',
    RESOLVED: 'text-green-600',
    APPROVED: 'text-green-600',
    REJECTED: 'text-red-600'
  }
  return map[props.status] || 'text-gray-600'
})

const titleText = computed(() => {
  const map = {
    PENDING: 'รอการตรวจสอบ',
    IN_PROGRESS: 'กำลังตรวจสอบ',
    RESOLVED: 'ดำเนินการแล้ว',
    APPROVED: 'รับเรื่องแล้ว',
    REJECTED: 'ไม่พบปัญหา'
  }
  return map[props.status] || 'ไม่ทราบสถานะ'
})

const descriptionText = computed(() => {
  const map = {
    PENDING: 'ทีมงานจะตรวจสอบคำร้องของคุณโดยเร็ว',
    IN_PROGRESS: 'ทีมงานกำลังดำเนินการตรวจสอบ',
    RESOLVED: 'ปัญหาของคุณได้รับการดำเนินการแล้ว',
    APPROVED: 'คำร้องของคุณได้รับการรับเรื่องแล้ว',
    REJECTED: 'ไม่พบความผิดปกติจากการตรวจสอบ'
  }
  return map[props.status] || '-'
})
</script>