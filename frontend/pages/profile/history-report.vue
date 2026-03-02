<template>
    <div >
        <div class=" flex items-center justify-center py-8">
            <div
                class="flex bg-white rounded-lg shadow-lg overflow-hidden max-w-6xl w-full mx-4 border border-gray-300">

                <ProfileSidebar />

                <main class="flex-1 p-8">
                    <div class="text-center mb-8">
                        <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-600 rounded-full mb-4">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                                </path>
                            </svg>
                        </div>
                        <h1 class="text-3xl font-bold text-gray-800 mb-2">ประวัติการรายงานของฉัน</h1>
                        <p class="text-gray-600 max-w-md mx-auto">
                            ดูรายการรายงานของคุณ
                        </p>
                    </div>

                    <div class="bg-white rounded-xl shadow-xl p-8 border border-gray-300">
                        <div
                            class="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4 bg-[#F2F2F2] p-4 md:px-6 md:py-6 rounded-[8px]">
                            <p class="text-gray-800 text-base md:text-[18px] text-center sm:text-left">
                                {{ reports.length > 0 ? `คุณมี ${reports.length} รายการรายงาน` :
                                    'คุณยังไม่มีรายการรายงาน' }}
                            </p>
                        </div>
                        <div v-if="reports.length > 0" class="mt-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div
                                v-for="report in reports"
                                :key="report.id"
                                class="flex flex-col gap-2 cursor-pointer"
                                @click="openReportDetail(report)"
                            >
                                <ReportStatusCard :status="report.status" />
                                <p class="text-sm text-gray-700">ประเภท: {{ getCategoryText(report.category) }}</p>
                                <p class="text-sm text-gray-700">วันที่: {{ formatDate(report.createdAt) }}</p>
                            </div>
                        </div>

                    </div>
                </main>
            </div>
        </div>

        <!-- Report Detail Modal (progress style) -->
        <div v-if="showReportDetailModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40"
            @click.self="closeReportDetail">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-in">
                <!-- Header -->
                <div class="bg-gradient-to-r from-red-500 to-red-600 p-6 text-white">
                    <div class="flex items-center justify-between mb-2">
                        <h2 class="text-xl font-bold">ติดตามสถานะรายงาน</h2>
                        <button @click="closeReportDetail" class="text-white/80 hover:text-white transition">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                    <!-- optional subtitle could show category or reporter if desired -->
                </div>

                <!-- Content -->
                <div class="p-0 overflow-y-auto max-h-[70vh]">
                    <div v-if="selectedReport" class="p-6 space-y-6">
                        <!-- ✅ Report Status Card -->
                        <ReportStatusCard
                            :status="selectedReport.status"
                        />
                        <!-- Summary Block -->
                        <div class="bg-blue-50 border border-blue-200 rounded-xl p-5 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
                                <h4 class="font-bold text-blue-900">สรุปการรายงาน</h4>
                                <span 
                                    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold shadow-sm"
                                    :class="{
                                        'bg-yellow-100 text-yellow-800 border border-yellow-200': selectedReport.status === 'PENDING',
                                        'bg-green-100 text-green-800 border border-green-200': ['APPROVED', 'RESOLVED'].includes(selectedReport.status),
                                        'bg-red-100 text-red-800 border border-red-200': selectedReport.status === 'REJECTED'
                                    }"
                                >
                                    {{ getReportStatusText(selectedReport.status) }}
                                </span>
                            </div>

                            <div class="space-y-3 text-sm text-blue-800">
                                <div class="flex justify-between border-b border-blue-100 pb-2">
                                    <span class="opacity-75">หัวข้อข้อปัญหา:</span>
                                    <span class="font-semibold">{{ getCategoryText(selectedReport.category) }}</span>
                                </div>
                                <div class="flex justify-between border-b border-blue-100 pb-2">
                                    <span class="opacity-75">วันที่แจ้ง:</span>
                                    <span class="font-semibold text-right">{{ selectedReport.createdAt ? dayjs(selectedReport.createdAt).format('D MMM BBBB HH:mm น.') : '-' }}</span>
                                </div>
                                <div class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">รายละเอียดที่แจ้ง:</span>
                                    <p class="text-gray-700 bg-white/60 p-3 rounded-lg border border-blue-100 italic leading-relaxed">
                                        "{{ selectedReport.description }}"
                                    </p>
                                </div>
                                <div v-if="(selectedReport.images?.length || selectedReport.videos?.length)" class="pt-2">
                                    <span class="opacity-75 block mb-2 font-medium">ไฟล์ประกอบ:</span>
                                    <div class="flex flex-wrap gap-2">
                                        <img v-if="selectedReport.images" 
                                            v-for="(img, idx) in selectedReport.images" :key="`img-${idx}`" :src="img" 
                                            class="w-20 h-20 object-cover rounded-lg border-2 border-white shadow-sm hover:scale-105 transition-transform cursor-pointer" 
                                            @click="window.open(img, '_blank')"
                                        />
                                        <video v-if="selectedReport.videos" 
                                            v-for="(vid, idx) in selectedReport.videos" :key="`vid-${idx}`" :src="vid" 
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
                                การตอบรับจากทีมงาน
                            </h4>
                            <div v-if="selectedReport.status !== 'PENDING'" class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                                <p class="text-sm text-gray-700 leading-relaxed italic">
                                    "{{ selectedReport.adminNotes || 'ได้รับการตรวจสอบเรียบร้อยแล้ว' }}"
                                </p>
                                <div v-if="selectedReport.resolvedAt" class="mt-3 pt-3 border-t border-gray-200 flex justify-between items-center text-[10px] text-gray-400">
                                    <span>ตรวจสอบเมื่อ: {{ dayjs(selectedReport.resolvedAt).format('D MMM BBBB HH:mm') }}</span>
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
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                    <button @click="closeReportDetail"
                        class="w-full px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-all shadow-md active:scale-95">
                        ปิด
                    </button>
                </div>
            </div>
        </div>

    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import ProfileSidebar from '~/components/ProfileSidebar.vue';
import dayjs from 'dayjs';
import 'dayjs/locale/th';
import ReportStatusCard from '~/components/ReportStatusCard.vue';

dayjs.locale('th');

definePageMeta({
    middleware: 'auth'
});

const { $api } = useNuxtApp();

const reports = ref([]);

// modal state for viewing a single report
const showReportDetailModal = ref(false);
const selectedReport = ref(null);

// helpers
function openReportDetail(report) {
    selectedReport.value = report;
    showReportDetailModal.value = true;
}

function closeReportDetail() {
    showReportDetailModal.value = false;
    setTimeout(() => {
        selectedReport.value = null;
    }, 200);
}

function getCategoryText(cat) {
    const cats = {
        VEHICLE_ISSUE: 'ปัญหาสภาพรถ/ข้อมูลรถไม่ตรง',
        PASSENGER_ISSUE: 'พฤติกรรมผู้โดยสารร่วมทริปที่ไม่เหมาะสม',
        ROAD_ISSUE: 'ปัญหาระหว่างเส้นทาง',
        SAFETY_ISSUE: 'พฤติกรรมการขับขี่ที่ไม่ปลอดภัย',
        PAYMENT_ISSUE: 'ปัญหาการชำระเงิน',
        NO_SHOW: 'ไม่มาพบตามจุดนัดหมาย',
        OTHER: 'อื่น ๆ'
    };
    return cats[cat] || cat || '-';
}

function getReportStatusText(status) {
    const reportStatus = {
        PENDING: 'รอการตรวจสอบ',
        APPROVED: 'รับเรื่องแล้ว',
        REJECTED: 'ไม่พบสถานะ',
        RESOLVED: 'ดำเนินการแก้ไขแล้ว'
    };
    return reportStatus[status] || 'ไม่ทราบสถานะ';
}

const fetchReports = async () => {
    try {
        // request only current user's reports
        const res = await $api('/reports/me');
        reports.value = res.data || res || [];
    } catch (error) {
        console.error('Failed to fetch reports:', error);
    }
};

const formatDate = (dateString) => {
    if (!dateString) return '';
    return dayjs(dateString).format('D MMMM YYYY HH:mm');
};

onMounted(() => {
    fetchReports();
});
</script>

<style scoped>
/* add scoped styles here if needed */
</style>
