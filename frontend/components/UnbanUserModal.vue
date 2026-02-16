<template>
    <transition name="modal-fade">
        <div v-if="show" class="modal-overlay" @click.self="handleClose">
            <div class="modal-content p-6 bg-white rounded-lg shadow-xl w-full max-w-md">
                
                <!-- Step 1: Confirmation -->
                <div v-if="step === 1" class="text-center">
                    <h3 class="mb-4 text-xl font-bold text-gray-900">
                        ยืนยันการคืนสิทธิ์ใช้งานให้กับ {{ user?.username || 'ผู้ใช้' }} ใช่หรือไม่?
                    </h3>
                    <p class="mb-6 text-gray-600">
                        ระบบจะเปลี่ยนสถานะเป็น 'ใช้งานปกติ' และผู้ใช้จะสามารถเข้าสู่ระบบได้ทันที
                    </p>

                    <div class="flex justify-center gap-4 mt-8">
                        <button @click="handleClose"
                            class="px-6 py-2 text-gray-700 bg-gray-200 rounded hover:bg-gray-300 focus:outline-none transition-colors duration-200">
                            ยกเลิก
                        </button>
                        <button @click="handleConfirm"
                            class="px-6 py-2 text-white bg-green-600 rounded hover:bg-green-700 focus:outline-none transition-colors duration-200">
                            ยกเลิกการระงับ
                        </button>
                    </div>
                </div>

                <!-- Step 2: Success -->
                <div v-else-if="step === 2" class="text-center">
                    <h3 class="mb-6 text-xl font-bold text-gray-900">คืนสิทธิ์การใช้งานสำเร็จ</h3>
                    
                    <div class="flex justify-center mt-6">
                        <button @click="handleClose"
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
    },
    user: {
        type: Object,
        default: null
    }
});

const emit = defineEmits(['close', 'confirm']);

// State for modal step
const step = ref(1); // 1: confirmation, 2: success

// Reset step when modal is opened
watch(() => props.show, (newVal) => {
    if (newVal) {
        step.value = 1;
    }
});

function handleClose() {
    emit('close');
}

function handleConfirm() {
    emit('confirm');
}

// Exposed function to allow parent to trigger success state
function switchToSuccess() {
    step.value = 2;
}

defineExpose({
    switchToSuccess
});
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

.modal-content {
    background-color: white;
    padding: 1.5rem;
    border-radius: 0.5rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    width: 100%;
    max-width: 28rem;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
    transition: opacity 0.3s ease;
}
.modal-fade-enter-from,
.modal-fade-leave-to {
    opacity: 0;
}
</style>
