<template>
    <transition name="modal-fade">
        <div v-if="show" class="modal-overlay" @click.self="handleCancel">
            <div class="modal-content p-6 bg-white rounded-lg shadow-xl w-full max-w-md">
                <div v-if="step === 1">
                    <h3 class="mb-6 text-xl font-bold text-gray-900">จงระบุเหตุผลในการระงับผู้ใช้บัญชีนี้</h3>

                    <div class="space-y-4">
                        <label class="flex items-center space-x-3 cursor-pointer">
                            <input type="radio" v-model="selectedReason" value="ละเมิดข้อตกลงการใช้งาน"
                                class="w-5 h-5 text-blue-600 border-gray-300 focus:ring-blue-500">
                            <span class="text-gray-700">ละเมิดข้อตกลงการใช้งาน</span>
                        </label>

                        <label class="flex items-center space-x-3 cursor-pointer">
                            <input type="radio" v-model="selectedReason" value="ใช้ถ้อยคำไม่สุภาพหรือแสดงความเกลียดชัง"
                                class="w-5 h-5 text-blue-600 border-gray-300 focus:ring-blue-500">
                            <span class="text-gray-700">ใช้ถ้อยคำไม่สุภาพหรือแสดงความเกลียดชัง</span>
                        </label>

                        <label class="flex items-center space-x-3 cursor-pointer">
                            <input type="radio" v-model="selectedReason" value="พฤติกรรมสแปม"
                                class="w-5 h-5 text-blue-600 border-gray-300 focus:ring-blue-500">
                            <span class="text-gray-700">พฤติกรรมสแปม</span>
                        </label>

                        <div class="space-y-2">
                            <label class="flex items-center space-x-3 cursor-pointer">
                                <input type="radio" v-model="selectedReason" value="เหตุผลอื่นๆ"
                                    class="w-5 h-5 text-blue-600 border-gray-300 focus:ring-blue-500">
                                <span class="text-gray-700">เหตุผลอื่นๆ</span>
                            </label>

                            <div v-if="selectedReason === 'เหตุผลอื่นๆ'" class="pl-8">
                                <textarea v-model="otherReason" placeholder="จงระบุเหตุผล" rows="3"
                                    class="w-full p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500 resize-none"></textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex justify-center gap-4 mt-8">
                        <button @click="handleCancel"
                            class="px-8 py-2 text-gray-700 bg-gray-200 rounded hover:bg-gray-300 focus:outline-none transition-colors duration-200">
                            ยกเลิก
                        </button>
                        <button @click="goToStep2"
                            class="px-8 py-2 text-white bg-red-600 rounded hover:bg-red-700 focus:outline-none transition-colors duration-200">
                            ระงับผู้ใช้
                        </button>
                    </div>
                </div>

                <div v-else-if="step === 2" class="text-center">
                   <h3 class="mb-4 text-xl font-bold text-gray-900">ยืนยันการระงับบัญชีผู้ใช้นี้ หรือไม่?</h3>
                   <p class="mb-6 text-gray-600">
                        ทั้งนี้ หากต้องการยกเลิกการระงับสิทธิ์ในภายหลัง คุณสามารถดำเนินการได้โดยการเลือกกรองสถานะเป็น 'ถูกแบน' เพื่อทำรายการแก้ไข
                   </p>

                   <div class="flex justify-center gap-4 mt-8">
                        <button @click="step = 1"
                            class="px-8 py-2 text-gray-700 bg-gray-200 rounded hover:bg-gray-300 focus:outline-none transition-colors duration-200">
                            ย้อนกลับ
                        </button>
                        <button @click="handleConfirm"
                            class="px-8 py-2 text-white bg-red-600 rounded hover:bg-red-700 focus:outline-none transition-colors duration-200">
                            ระงับผู้ใช้
                        </button>
                    </div>
                </div>

                <div v-else-if="step === 3" class="text-center">
                    <h3 class="mb-6 text-xl font-bold text-gray-900">ระงับสิทธิ์การใช้งานสำเร็จ</h3>
                    
                    <div class="flex justify-center mt-6">
                        <button @click="handleCancel"
                            class="px-8 py-2 text-white bg-blue-600 rounded hover:bg-blue-700 focus:outline-none transition-colors duration-200">
                            ตกลง
                        </button>
                    </div>
                </div>



            </div>
        </div>
    </transition>
</template>

<script setup>
import { ref, watch } from 'vue';

const props = defineProps({
    show: {
        type: Boolean,
        required: true
    }
});

const emit = defineEmits(['close', 'confirm']);

// State for modal data
const selectedReason = ref('ละเมิดข้อตกลงการใช้งาน');
const otherReason = ref('');
const step = ref(1); // 1: reason to ban, 2: confirmation, 3: success

// Reset fields when modal is opened
watch(() => props.show, (newVal) => {
    if (newVal) {
        selectedReason.value = 'ละเมิดข้อตกลงการใช้งาน';
        otherReason.value = '';
        step.value = 1;
    }
});

function handleCancel() {
    emit('close');
}

function goToStep2() {
    step.value = 2;
}

// Exposed function to allow parent to trigger success state
function switchToSuccess() {
    step.value = 3;
}

defineExpose({
    switchToSuccess
});

function handleConfirm() {
    // Determine the final reason string
    let reason = selectedReason.value;
    if (reason === 'เหตุผลอื่นๆ') {
        reason = otherReason.value || 'เหตุผลอื่นๆ (ไม่ได้ระบุ)';
    }
    emit('confirm', reason);
}
</script>

<style scoped>
.modal-overlay {
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Transitions same as ConfirmModal */
.modal-fade-enter-active,
.modal-fade-leave-active {
    transition: opacity 0.3s ease;
}
.modal-fade-enter-from,
.modal-fade-leave-to {
    opacity: 0;
}
</style>
