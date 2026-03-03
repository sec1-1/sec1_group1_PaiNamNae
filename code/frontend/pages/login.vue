<template>
  <div class="min-h-[80vh] flex items-center justify-center p-4">
    <main class="bg-white rounded-lg shadow-lg max-w-md w-full p-8 border border-gray-300">
      <h1 class="text-3xl font-bold text-blue-600 mb-6 text-center">
        เข้าสู่ระบบ
      </h1>

      <form @submit.prevent="submit" id="loginForm">
        <!-- username / Email -->
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-1">
            ชื่อผู้ใช้ หรือ อีเมล <span class="text-red-500">*</span>
          </label>

          <input
            v-model="identifier"
            type="text"
            required
            placeholder="กรอกชื่อผู้ใช้หรืออีเมล"
            class="w-full px-4 py-3 border border-gray-300 rounded-md
                   focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>

        <!-- password -->
        <div class="mb-6">
          <label class="block text-sm font-medium text-gray-700 mb-1">
            รหัสผ่าน <span class="text-red-500">*</span>
          </label>

          <input
            v-model="password"
            type="password"
            required
            minlength="6"
            placeholder="กรอกรหัสผ่าน"
            class="w-full px-4 py-3 border border-gray-300 rounded-md
                   focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>

        <!-- ปุ่ม -->
        <button
          type="submit"
          :disabled="loading"
          class="w-full py-3 bg-blue-600 text-white rounded-md font-medium
                 hover:bg-blue-700 transition duration-200
                 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ loading ? 'กำลังเข้าสู่ระบบ...' : 'เข้าสู่ระบบ' }}
        </button>

        <!-- ❌ error -->
        <div v-if="errorMessage" class="mt-4 text-red-600 text-sm text-center">
          {{ errorMessage }}
        </div>
      </form>

      <!-- register -->
      <p class="mt-6 text-center text-gray-600 text-sm">
        ยังไม่มีบัญชี?
        <NuxtLink to="/register" class="text-blue-600 hover:underline">
          สมัครสมาชิก
        </NuxtLink>
      </p>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '~/composables/useAuth'

const identifier = ref('')
const password = ref('')
const errorMessage = ref('')
const loading = ref(false)

const router = useRouter()
const { login } = useAuth()

const submit = async () => {
  errorMessage.value = ''
  loading.value = true

  try {
    await login(identifier.value, password.value)

    // ✅ login สำเร็จ
    router.push('/')
  } catch (e: any) {
    console.error(e)

    const message = e?.data?.message
    const reason = e?.data?.reason

    // 🔥 กรณี blacklist (สำคัญ)
    if (reason) {
      errorMessage.value = `บัญชีของคุณถูกระงับ: ${reason}`
      return
    }

    // ❌ login fail ปกติ
    errorMessage.value =
      message ||
      e?.data?.error ||
      'เข้าสู่ระบบไม่สำเร็จ กรุณาตรวจสอบข้อมูล'
  } finally {
    loading.value = false
  }
}
</script>
