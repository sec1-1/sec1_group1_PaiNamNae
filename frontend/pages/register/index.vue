<template>
  <div class="bg-gray-50 min-h-screen flex items-center justify-center p-4 font-['Kanit']">
    <main class="w-full max-w-md p-6 bg-white rounded-lg shadow-lg sm:p-8">
      <h1 class="mb-8 text-3xl font-bold text-center text-blue-600">สมัครสมาชิก</h1>

      <!-- Stepper Indicator -->
      <div class="relative mb-10">
        <div class="absolute left-0 right-0 top-5 h-0.5 bg-gray-200"></div>
        <div class="absolute left-0 top-5 h-0.5 bg-blue-600 transition-all duration-500"
          :style="{ width: stepProgress }"></div>
        <div class="relative flex items-center justify-between">
          <div v-for="step in totalSteps" :key="step" class="z-10 flex flex-col items-center w-1/3">
            <div :class="getStepClass(step)">
              <span>{{ step }}</span>
            </div>
            <span :class="getLabelClass(step)">{{ getStepLabel(step) }}</span>
          </div>
        </div>
      </div>

      <!-- Registration Form -->
      <form @submit.prevent="handleRegister" novalidate>
        <!-- Step 1: Account Info -->
        <div v-if="currentStep === 1">
          <h2 class="mb-4 text-xl font-semibold text-gray-800">ข้อมูลบัญชีผู้ใช้</h2>
          <div class="mb-4">
            <label for="username" class="block mb-1 text-sm font-medium text-gray-700">ชื่อผู้ใช้ <span
                class="text-red-500">*</span></label>
            <input type="text" id="username" v-model="formData.username" placeholder="example123"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.username }">
            <p v-if="errors.username" class="mt-1 text-xs text-red-600">{{ errors.username }}</p>
            <p v-else class="mt-1 text-xs text-gray-500">ความยาว 4–20 ตัวอักษร ภาษาอังกฤษ ตัวเลข หรือขีดล่าง (_)
              เท่านั้น</p>
          </div>
          <div class="mb-4">
            <label for="email" class="block mb-1 text-sm font-medium text-gray-700">อีเมล <span
                class="text-red-500">*</span></label>
            <input type="email" id="email" v-model="formData.email" placeholder="example@example.com"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.email }">
            <p v-if="errors.email" class="mt-1 text-xs text-red-600">{{ errors.email }}</p>
          </div>
          <div class="mb-4">
            <label for="password" class="block mb-1 text-sm font-medium text-gray-700">รหัสผ่าน <span
                class="text-red-500">*</span></label>
            <input type="password" id="password" v-model="formData.password" placeholder="อย่างน้อย 8 ตัวอักษร"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.password }">
            <p v-if="errors.password" class="mt-1 text-xs text-red-600">{{ errors.password }}</p>
            <p v-else class="mt-1 text-xs text-gray-500">ต้องประกอบด้วย A–Z, a–z และตัวเลข 0–9</p>
          </div>
          <div class="mb-6">
            <label for="confirmPassword" class="block mb-1 text-sm font-medium text-gray-700">ยืนยันรหัสผ่าน <span
                class="text-red-500">*</span></label>
            <input type="password" id="confirmPassword" v-model="formData.confirmPassword"
              placeholder="กรอกรหัสผ่านอีกครั้ง"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.confirmPassword }">
            <p v-if="errors.confirmPassword" class="mt-1 text-xs text-red-600">{{ errors.confirmPassword }}</p>
          </div>
          <button type="button" @click="nextStep"
            class="w-full py-3 font-medium text-white transition bg-blue-600 rounded-md hover:bg-blue-700">ถัดไป</button>
        </div>

        <!-- Step 2: Personal Info -->
        <div v-if="currentStep === 2">
          <h2 class="mb-4 text-xl font-semibold text-gray-800">ข้อมูลส่วนตัว</h2>
          <div class="mb-4">
            <label for="firstName" class="block mb-1 text-sm font-medium text-gray-700">ชื่อจริง <span
                class="text-red-500">*</span></label>
            <input type="text" id="firstName" v-model="formData.firstName" placeholder="กรอกชื่อจริง"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.firstName }">
            <p v-if="errors.firstName" class="mt-1 text-xs text-red-600">{{ errors.firstName }}</p>
          </div>
          <div class="mb-4">
            <label for="lastName" class="block mb-1 text-sm font-medium text-gray-700">นามสกุล <span
                class="text-red-500">*</span></label>
            <input type="text" id="lastName" v-model="formData.lastName" placeholder="กรอกนามสกุล"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.lastName }">
            <p v-if="errors.lastName" class="mt-1 text-xs text-red-600">{{ errors.lastName }}</p>
          </div>
          <div class="mb-4">
            <label for="phoneNumber" class="block mb-1 text-sm font-medium text-gray-700">เบอร์โทรศัพท์ <span
                class="text-red-500">*</span></label>
            <input type="tel" id="phoneNumber" v-model="formData.phoneNumber" placeholder="เช่น 0891234567"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.phoneNumber }">
            <p v-if="errors.phoneNumber" class="mt-1 text-xs text-red-600">{{ errors.phoneNumber }}</p>
          </div>
          <div class="mb-6">
            <label class="block mb-2 text-sm font-medium text-gray-700">เพศ <span class="text-red-500">*</span></label>
            <div class="flex gap-6">
              <label class="flex items-center"><input type="radio" name="gender" value="male" v-model="formData.gender"
                  class="mr-2 text-blue-600 focus:ring-blue-500"> ชาย</label>
              <label class="flex items-center"><input type="radio" name="gender" value="female"
                  v-model="formData.gender" class="mr-2 text-blue-600 focus:ring-blue-500"> หญิง</label>
            </div>
            <p v-if="errors.gender" class="mt-1 text-xs text-red-600">{{ errors.gender }}</p>
          </div>
          <div class="flex gap-4">
            <button type="button" @click="prevStep"
              class="w-full py-3 font-medium text-white transition bg-gray-600 rounded-md hover:bg-gray-700">ย้อนกลับ</button>
            <button type="button" @click="nextStep"
              class="w-full py-3 font-medium text-white transition bg-blue-600 rounded-md hover:bg-blue-700">ถัดไป</button>
          </div>
        </div>

        <!-- Step 3: Verification -->
        <div v-if="currentStep === 3">
          <h2 class="mb-4 text-xl font-semibold text-gray-800">ยืนยันตัวตน</h2>
          <div class="mb-4">
            <label class="block mb-1 text-sm font-medium text-gray-700">บัตรประชาชน <span
                class="text-red-500">*</span></label>
            <div v-if="!idCardPreview" @click="triggerFileUpload('idCardFile')"
              class="p-6 text-center transition border-2 border-gray-300 border-dashed rounded-md cursor-pointer hover:border-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.idCardFile }">
              <i class="text-4xl text-gray-400 fa-regular fa-image"></i>
              <p class="mt-2 text-sm text-gray-600">กดเพื่อเลือกรูปภาพ</p>
            </div>
            <div v-else class="relative">
              <img :src="idCardPreview" alt="ID Card Preview" class="w-full mt-2 rounded-md" />
              <button type="button" @click="removeImage('idCard')"
                class="absolute flex items-center justify-center w-6 h-6 text-white bg-black bg-opacity-50 rounded-full top-2 right-2">&times;</button>
            </div>
            <input type="file" id="idCardFile" @change="handleFileUpload($event, 'idCard')" accept="image/*"
              class="hidden">
            <p v-if="errors.idCardFile" class="mt-1 text-xs text-red-600">{{ errors.idCardFile }}</p>
          </div>
          <div class="mb-4">
            <label for="idNumber" class="block mb-1 text-sm font-medium text-gray-700">หมายเลขบัตรประชาชน <span
                class="text-red-500">*</span></label>
            <input type="text" id="idNumber" v-model="formData.idNumber" placeholder="กรอกหมายเลข 13 หลัก"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.idNumber }">
            <p v-if="errors.idNumber" class="mt-1 text-xs text-red-600">{{ errors.idNumber }}</p>
          </div>
          <div class="mb-4">
            <label for="expiryDate" class="block mb-1 text-sm font-medium text-gray-700">วันหมดอายุบัตร <span
                class="text-red-500">*</span></label>
            <input type="text" id="expiryDate" v-model="formData.expiryDate" placeholder="วว/ดด/ปปปป"
              @input="formatExpiryDate" maxlength="10"
              class="w-full px-4 py-2 transition border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.expiryDate }">
            <p v-if="errors.expiryDate" class="mt-1 text-xs text-red-600">{{ errors.expiryDate }}</p>
          </div>
          <div class="mb-4">
            <label class="block mb-1 text-sm font-medium text-gray-700">รูปถ่ายใบหน้าปกติ (Selfie) <span
                class="text-red-500">*</span></label>
            <div v-if="!selfiePreview" @click="triggerFileUpload('selfieFile')"
              class="p-6 text-center transition border-2 border-gray-300 border-dashed rounded-md cursor-pointer hover:border-blue-500"
              :class="{ 'border-red-500 ring-1 ring-red-500': errors.selfieFile }">
              <i class="text-4xl text-gray-400 fa-regular fa-image"></i>
              <p class="mt-2 text-sm text-gray-600">กดเพื่อเลือกรูปภาพ</p>
            </div>
            <div v-else class="relative">
              <img :src="selfiePreview" alt="Selfie Preview" class="w-full mt-2 rounded-md" />
              <button type="button" @click="removeImage('selfie')"
                class="absolute flex items-center justify-center w-6 h-6 text-white bg-black bg-opacity-50 rounded-full top-2 right-2">&times;</button>
            </div>
            <input type="file" id="selfieFile" @change="handleFileUpload($event, 'selfie')" accept="image/*"
              class="hidden">
            <p v-if="errors.selfieFile" class="mt-1 text-xs text-red-600">{{ errors.selfieFile }}</p>
          </div>
          <div class="p-4 mb-4 text-sm text-red-700 border border-red-200 rounded-md bg-red-50">
            <p class="mb-2 font-semibold">ข้อควรหลีกเลี่ยง:</p>
            <ul class="space-y-1">
              <li class="flex items-center"><i
                  class="mr-2 text-red-500 fa-solid fa-circle-xmark"></i>ใบหน้าไม่ชัดหรือถูกบัง</li>
              <li class="flex items-center"><i
                  class="mr-2 text-red-500 fa-solid fa-circle-xmark"></i>บัตรไม่ชัดหรือไม่เต็ม</li>
              <li class="flex items-center"><i class="mr-2 text-red-500 fa-solid fa-circle-xmark"></i>แสงน้อยเกินไป</li>
              <li class="flex items-center"><i class="mr-2 text-red-500 fa-solid fa-circle-xmark"></i>ระยะไกลเกินไป</li>
            </ul>
          </div>
          <div class="mb-6">
            <label class="flex items-start">
              <input type="checkbox" v-model="formData.pdpa"
                class="w-4 h-4 mt-1 mr-3 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
              <span class="text-sm text-gray-700">ข้าพเจ้ายินยอมรับ
                <NuxtLink to="/terms-of-service" target="_blank" rel="noopener noreferrer"
                  class="text-blue-600 hover:underline">ข้อตกลงและเงื่อนไขฯ</NuxtLink> และได้อ่าน <NuxtLink
                  to="/privacy" target="_blank" rel="noopener noreferrer" class="text-blue-600 hover:underline">
                  นโยบายความเป็นส่วนตัว</NuxtLink> แล้ว
              </span>
            </label>
            <p v-if="errors.pdpa" class="mt-1 text-xs text-red-600">{{ errors.pdpa }}</p>
          </div>
          <div class="flex gap-4">
            <button type="button" @click="prevStep"
              class="w-full py-3 font-medium text-white transition bg-gray-600 rounded-md hover:bg-gray-700">ย้อนกลับ</button>
            <button type="submit" :disabled="isLoading"
              class="flex items-center justify-center w-full py-3 font-medium text-white transition bg-blue-600 rounded-md hover:bg-blue-700 disabled:bg-blue-400 disabled:cursor-not-allowed">
              <svg v-if="isLoading" class="w-5 h-5 mr-3 -ml-1 text-white animate-spin"
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
              </svg>
              {{ isLoading ? 'กำลังบันทึก...' : 'สมัครสมาชิก' }}
            </button>
          </div>
        </div>
      </form>

      <p class="mt-8 text-sm text-center text-gray-600">
        มีบัญชีแล้ว? <NuxtLink to="/login" class="font-medium text-blue-600 hover:underline">เข้าสู่ระบบ</NuxtLink>
      </p>
    </main>
  </div>
</template>

<script setup>
import { ref, reactive, computed, nextTick } from 'vue';
import { useAuth } from '~/composables/useAuth';
import { useToast } from '~/composables/useToast';
import { useRouter } from '#app';

const { register } = useAuth();
const { toast } = useToast();
const router = useRouter();

const currentStep = ref(1);
const totalSteps = 3;

const formData = reactive({
  username: '',
  email: '',
  password: '',
  confirmPassword: '',
  firstName: '',
  lastName: '',
  phoneNumber: '',
  gender: '',
  idCardFile: null,
  idNumber: '',
  expiryDate: '',
  selfieFile: null,
  pdpa: false,
});

const errors = reactive({});
const idCardPreview = ref(null);
const selfiePreview = ref(null);

const isLoading = ref(false);

// onMounted(() => {
//   const faScript = document.createElement('script');
//   faScript.src = 'https://kit.fontawesome.com/a076d05399.js';
//   faScript.crossOrigin = 'anonymous';
//   document.head.appendChild(faScript);

//   const fontLink = document.createElement('link');
//   fontLink.href = 'https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap';
//   fontLink.rel = 'stylesheet';
//   document.head.appendChild(fontLink);
// });

useHead({
  link: [
    { rel: 'stylesheet', href: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css' },
    { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap' },
  ],
});

const stepProgress = computed(() => {
  if (totalSteps <= 1) return '0%';
  return `${((currentStep.value - 1) / (totalSteps - 1)) * 100}%`;
});

const getStepLabel = (step) => {
  return ['บัญชีผู้ใช้', 'ข้อมูลส่วนตัว', 'ยืนยันตัวตน'][step - 1];
};

const getStepClass = (step) => {
  let baseClasses = 'flex items-center justify-center w-10 h-10 rounded-full font-semibold transition-all duration-500';
  if (step < currentStep.value) {
    return `${baseClasses} bg-blue-600 text-white`;
  } else if (step === currentStep.value) {
    return `${baseClasses} bg-blue-600 text-white ring-4 ring-blue-200`;
  } else {
    return `${baseClasses} bg-gray-300 text-gray-500`;
  }
};

const getLabelClass = (step) => {
  let baseClasses = 'text-xs text-center mt-2 transition-all duration-500';
  if (step < currentStep.value) {
    return `${baseClasses} font-semibold text-blue-600`;
  } else if (step === currentStep.value) {
    return `${baseClasses} font-semibold text-blue-600`;
  } else {
    return `${baseClasses} text-gray-500`;
  }
};

const clearErrors = () => {
  Object.keys(errors).forEach(key => delete errors[key]);
};

const validationFunctions = [
  () => {
    clearErrors();
    if (!formData.username || formData.username.length < 4) errors.username = 'ชื่อผู้ใช้ต้องมีอย่างน้อย 4 ตัวอักษร';
    if (!/^\S+@\S+\.\S+$/.test(formData.email)) errors.email = 'รูปแบบอีเมลไม่ถูกต้อง';
    if (!formData.password || formData.password.length < 8) errors.password = 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
    if (formData.password !== formData.confirmPassword || !formData.confirmPassword) errors.confirmPassword = 'รหัสผ่านไม่ตรงกัน';
    return Object.keys(errors).length === 0;
  },
  () => {
    clearErrors();
    if (!formData.firstName.trim()) errors.firstName = 'กรุณากรอกชื่อจริง';
    if (!formData.lastName.trim()) errors.lastName = 'กรุณากรอกนามสกุล';
    if (!/^\d{9,10}$/.test(formData.phoneNumber)) errors.phoneNumber = 'รูปแบบเบอร์โทรศัพท์ไม่ถูกต้อง';
    if (!formData.gender) errors.gender = 'กรุณาเลือกเพศ';
    return Object.keys(errors).length === 0;
  },
  () => {
    clearErrors();
    if (!formData.idCardFile) errors.idCardFile = 'กรุณาอัปโหลดรูปบัตรประชาชน';
    if (!/^\d{13}$/.test(formData.idNumber)) errors.idNumber = 'กรุณากรอกหมายเลขบัตรประชาชน 13 หลัก';
    if (!formData.expiryDate.trim() || !/^\d{2}\/\d{2}\/\d{4}$/.test(formData.expiryDate)) {
      errors.expiryDate = 'กรุณากรอกวันหมดอายุบัตรในรูปแบบ วว/ดด/ปปปป';
    } else if (!isValidDDMMYYYY(formData.expiryDate)) {
      errors.expiryDate = 'วันที่ไม่ถูกต้อง โปรดตรวจสอบวัน/เดือน เช่น 31/04/2025 ไม่ถูกต้อง';
    }
    if (!formData.selfieFile) errors.selfieFile = 'กรุณาอัปโหลดรูปถ่ายใบหน้า';
    if (!formData.pdpa) errors.pdpa = 'กรุณายอมรับข้อตกลงและเงื่อนไข';
    return Object.keys(errors).length === 0;
  }
];

const nextStep = () => {
  if (validationFunctions[currentStep.value - 1]()) {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
    }
  }
};

const prevStep = () => {
  if (currentStep.value > 1) {
    currentStep.value--;
    clearErrors();
  }
};

// ===== Helpers (same behavior as admin create) =====
const apiBase = useRuntimeConfig().public.apiBase || 'http://localhost:3000/api';

async function postForm(url, formData, token = '') {
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      Accept: 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    },
    body: formData,
    credentials: 'include',
  });
  let body;
  try {
    body = await res.json();
  } catch {
    const text = await res.text();
    const err = new Error(text || 'Unexpected response from server');
    err.status = res.status;
    throw err;
  }
  if (!res.ok) {
    const msg = body?.message || `Request failed with status ${res.status}`;
    const err = new Error(msg);
    err.status = res.status;
    err.payload = body;
    throw err;
  }
  return body;
}

// dd/mm/yyyy -> ISO (T00:00:00.000Z) เพื่อกันปัญหา timezone/off-by-one
function isValidDDMMYYYY(ddmmyyyy) {
  if (!/^\d{2}\/\d{2}\/\d{4}$/.test(ddmmyyyy)) return false;
  const [dd, mm, yyyy] = ddmmyyyy.split('/').map(Number);
  const d = new Date(yyyy, mm - 1, dd);
  return d.getFullYear() === yyyy && d.getMonth() === mm - 1 && d.getDate() === dd;
}

// dd/mm/yyyy -> ISO (T00:00:00.000Z) (กัน timezone/off-by-one และกัน invalid)
function toISODateFromDDMMYYYY(ddmmyyyy) {
  if (!isValidDDMMYYYY(ddmmyyyy)) return '';
  const [dd, mm, yyyy] = ddmmyyyy.split('/');
  const d = new Date(`${yyyy}-${mm}-${dd}T00:00:00.000Z`);
  return Number.isNaN(d.getTime()) ? '' : d.toISOString();
}

// const handleRegister = async () => {
//   if (validationFunctions[currentStep.value - 1]()) {
//     isLoading.value = true;
//     await nextTick();
//     console.log('Form is valid, preparing data to submit...');
//     const parts = formData.expiryDate.split('/');
//     const isoDate = new Date(`${parts[2]}-${parts[1]}-${parts[0]}`).toISOString();

//     const dataToSubmit = new FormData();
//     dataToSubmit.append('email', formData.email);
//     dataToSubmit.append('username', formData.username);
//     dataToSubmit.append('password', formData.password);
//     dataToSubmit.append('firstName', formData.firstName);
//     dataToSubmit.append('lastName', formData.lastName);
//     dataToSubmit.append('phoneNumber', formData.phoneNumber);
//     dataToSubmit.append('gender', formData.gender.toUpperCase());
//     dataToSubmit.append('nationalIdNumber', formData.idNumber);
//     dataToSubmit.append('nationalIdExpiryDate', isoDate);
//     dataToSubmit.append('nationalIdPhotoUrl', formData.idCardFile);
//     dataToSubmit.append('selfiePhotoUrl', formData.selfieFile);

//     try {
//       await register(dataToSubmit);
//       router.push('/register/success');
//     } catch (err) {
//       console.error('Registration failed:', err);
//       const errorMessage = err.data?.message || 'สมัครสมาชิกไม่สำเร็จ กรุณาลองใหม่อีกครั้ง';
//       alert(errorMessage);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// };

const handleRegister = async () => {
  if (!validationFunctions[currentStep.value - 1]()) return;
  isLoading.value = true;
  await nextTick();
  const isoDate = toISODateFromDDMMYYYY(formData.expiryDate);
  if (!isoDate) {
    // แจ้งผู้ใช้ทันทีผ่าน toast
    const msg = (errors.expiryDate || 'วันที่ไม่ถูกต้อง โปรดกรอกเป็น วว/ดด/ปปปป');
    toast.error('ข้อมูลไม่ถูกต้อง', msg);
    isLoading.value = false;
    return;
  }

  const fd = new FormData();
  fd.append('email', formData.email);
  fd.append('username', formData.username);
  fd.append('password', formData.password);
  fd.append('firstName', formData.firstName);
  fd.append('lastName', formData.lastName);
  fd.append('phoneNumber', formData.phoneNumber);
  fd.append('gender', String(formData.gender || '').toUpperCase()); // 'MALE' | 'FEMALE'
  fd.append('nationalIdNumber', formData.idNumber);
  fd.append('nationalIdExpiryDate', isoDate);
  fd.append('nationalIdPhotoUrl', formData.idCardFile);
  fd.append('selfiePhotoUrl', formData.selfieFile);
  // ผู้ใช้ทั่วไป: บังคับ role เป็น PASSENGER (สอดคล้องฝั่ง backend/แอดมิน)
  fd.append('role', 'PASSENGER');
  try {
    await postForm(`${apiBase}/users`, fd);
    router.push('/register/success');
  } catch (err) {
    console.error('Registration failed:', err);

    const status = err?.status;
    const msg = err?.message || 'สมัครสมาชิกไม่สำเร็จ กรุณาลองใหม่อีกครั้ง';

    if (status === 403) {
      // 🚫 โดน blacklist
      toast.error('ไม่สามารถสมัครได้', msg);
    } else if (status === 409) {
      // 🔁 ข้อมูลซ้ำ
      toast.error('ข้อมูลซ้ำ', msg);
    } else {
      toast.error('เกิดข้อผิดพลาด', msg);
    }
  }finally {
    isLoading.value = false;
  }
};

const triggerFileUpload = (inputId) => {
  document.getElementById(inputId)?.click();
};

const handleFileUpload = (event, type) => {
  const file = event.target.files?.[0];
  if (!file) return;

  const reader = new FileReader();
  reader.onload = (e) => {
    const result = e.target?.result;
    if (type === 'idCard') {
      idCardPreview.value = result;
      formData.idCardFile = file;
      if (errors.idCardFile) delete errors.idCardFile;
    } else if (type === 'selfie') {
      selfiePreview.value = result;
      formData.selfieFile = file;
      if (errors.selfieFile) delete errors.selfieFile;
    }
  };
  reader.readAsDataURL(file);
};

const removeImage = (type) => {
  if (type === 'idCard') {
    idCardPreview.value = null;
    formData.idCardFile = null;
  } else if (type === 'selfie') {
    selfiePreview.value = null;
    formData.selfieFile = null;
  }
}

const formatExpiryDate = () => {
  let value = formData.expiryDate;
  const digits = value.replace(/\D/g, '');
  if (digits.length <= 2) {
    formData.expiryDate = digits;
  } else if (digits.length <= 4) {
    formData.expiryDate = `${digits.slice(0, 2)}/${digits.slice(2)}`;
  } else {
    formData.expiryDate = `${digits.slice(0, 2)}/${digits.slice(2, 4)}/${digits.slice(4, 8)}`;
  }
};
</script>

<style scoped>
/* Scoped styles for the parent component can remain here if any */
</style>
