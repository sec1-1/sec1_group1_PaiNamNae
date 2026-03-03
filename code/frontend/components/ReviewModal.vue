<script setup>
import { ref } from "vue"

const props = defineProps({
  bookingId: String,
  show: Boolean
})

const emit = defineEmits(["close", "success"])

const rating = ref(0)
const comment = ref("")
const images = ref([])

const submitReview = async () => {
  try {
    await $fetch("http://localhost:3001/api/reviews", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`
      },
      body: {
        bookingId: props.bookingId,
        rating: rating.value,
        comment: comment.value,
        images: images.value
      }
    })

    emit("success")
    emit("close")

  } catch (err) {
    alert(err.data?.message || "Error")
  }
}
</script>

<template>
  <div v-if="show" class="modal">
    <div class="bg-white p-4 rounded-lg w-96">

      <h2 class="text-lg font-bold mb-3">ให้คะแนน</h2>

      <!-- ⭐ ดาว -->
      <div class="flex gap-2 mb-3">
        <span
          v-for="i in 5"
          :key="i"
          @click="rating = i"
          class="cursor-pointer text-2xl"
        >
          {{ i <= rating ? "⭐" : "☆" }}
        </span>
      </div>

      <!-- 📝 comment -->
      <textarea
        v-model="comment"
        class="w-full border p-2 mb-3"
        placeholder="เขียนรีวิว..."
      ></textarea>

      <!-- 📸 รูป (ตอนนี้ยังใส่ url manual ก่อน) -->
      <input
        type="text"
        v-model="images[0]"
        placeholder="Image URL"
        class="w-full border p-2 mb-3"
      />

      <button
        @click="submitReview"
        class="bg-blue-600 text-white px-4 py-2 rounded"
      >
        ส่งรีวิว
      </button>

      <button @click="$emit('close')" class="ml-2 text-gray-500">
        ยกเลิก
      </button>

    </div>
  </div>
</template>
