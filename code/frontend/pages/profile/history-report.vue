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
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4 md:p-6">
                            <div class="flex flex-col gap-4">
                                <div class="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
                                    <div>
                                        <p class="text-lg font-semibold text-slate-800 md:text-xl">
                                            รายงานที่ส่งทั้งหมด {{ reports.length }} รายการ
                                        </p>
                                        <p class="text-sm text-slate-500">
                                            คลิกที่สถานะเพื่อดูรายการรายงานในหมวดนั้น
                                        </p>
                                    </div>
                                    <button
                                        type="button"
                                        class="inline-flex items-center justify-center rounded-lg border px-3 py-2 text-sm font-medium transition"
                                        :class="activeStatus === 'ALL' ? 'border-blue-600 bg-blue-600 text-white' : 'border-slate-300 bg-white text-slate-600 hover:border-blue-300 hover:text-blue-600'"
                                        @click="setActiveStatus('ALL')"
                                    >
                                        ทั้งหมด {{ reports.length }}
                                    </button>
                                </div>

                                <div class="flex flex-wrap gap-2">
                                    <button
                                        v-for="item in reportStatusSummary"
                                        :key="item.status"
                                        type="button"
                                        class="inline-flex items-center gap-2 rounded-full border bg-white px-4 py-2 text-sm shadow-sm transition hover:-translate-y-0.5 hover:shadow-md"
                                        :class="activeStatus === item.status ? 'border-slate-400 shadow-md' : 'border-slate-200 hover:border-slate-300'"
                                        @click="setActiveStatus(item.status)"
                                    >
                                        <span class="font-semibold" :class="item.textClass">{{ item.label }}</span>
                                        <span
                                            class="inline-flex items-center justify-center rounded-full px-2 py-0.5 text-xs font-bold min-w-[1.4rem]"
                                            :class="item.badgeClass"
                                        >
                                            {{ item.count }}
                                        </span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div v-if="filteredReports.length > 0" class="mt-6 flex flex-col gap-4">
                            <div
                                v-for="report in filteredReports"
                                :key="report.id"
                                class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-gradient-to-br from-white to-slate-50 p-5 shadow-sm transition-all duration-200 hover:-translate-y-0.5 hover:border-red-200 hover:shadow-lg"
                            >
                                <div class="pointer-events-none absolute inset-x-0 top-0 h-1 bg-gradient-to-r from-red-500 to-rose-500"></div>

                                <div class="space-y-3">
                                    <div class="flex flex-wrap items-center justify-between gap-3">
                                        <div class="flex items-center gap-2 text-[11px] text-slate-500">
                                            <span class="inline-flex h-7 w-7 items-center justify-center rounded-full bg-blue-100 text-blue-700">
                                                <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                </svg>
                                            </span>
                                            <span class="font-medium tracking-wide">รายงาน</span>
                                        </div>

                                        <div class="flex flex-wrap items-center justify-end gap-2">
                                            <span
                                                class="inline-flex shrink-0 items-center rounded-full px-3 py-1 text-xs font-semibold border"
                                                :class="getReportScopeClass(report.reportScope)"
                                            >
                                                {{ getReportScopeText(report.reportScope) }}
                                            </span>
                                            <span
                                                class="inline-flex shrink-0 items-center rounded-full px-3 py-1 text-xs font-semibold shadow-sm"
                                                :class="getStatusBadgeClass(report.status)"
                                            >
                                                {{ getReportStatusText(report.status) }}
                                            </span>
                                        </div>
                                    </div>

                                    <p class="text-sm font-semibold text-slate-800 leading-6">
                                        {{ getCategoryText(report.category) }}
                                    </p>

                                    <p class="w-full text-sm text-slate-600 line-clamp-2 rounded-lg bg-white/80 border border-slate-200 px-3 py-2">
                                        {{ getReportDetailText(report.description) }}
                                    </p>

                                    <div class="mt-4 flex items-center justify-between gap-3">
                                            <span class="inline-flex items-center gap-1 rounded-full bg-slate-100 px-3 py-1 text-xs font-medium text-slate-600 border border-slate-200">
                                                <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10m-11 9h12a2 2 0 002-2V7a2 2 0 00-2-2H6a2 2 0 00-2 2v11a2 2 0 002 2z" />
                                                </svg>
                                                {{ formatDate(report.createdAt) }}
                                            </span>

                                            <button
                                                type="button"
                                                class="ml-auto inline-flex items-center justify-center rounded-lg border border-blue-600 bg-white px-3 py-2 text-xs font-semibold text-blue-600 transition hover:bg-blue-50 active:scale-95"
                                                @click="openReportDetail(report)"
                                            >
                                                ดูรายละเอียด
                                            </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="mt-6 rounded-2xl border border-dashed border-slate-300 bg-slate-50 p-8 text-center text-slate-500">
                            {{ activeStatus === 'ALL' ? 'คุณยังไม่มีรายการรายงาน' : `ไม่พบรายการรายงานสถานะ${getReportStatusText(activeStatus)}` }}
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
                <div class="border-b border-gray-200 bg-white p-6 text-black">
                    <div class="flex items-center justify-between mb-3">
                        <h2 class="text-xl font-bold">ติดตามสถานะรายงาน</h2>
                        <button @click="closeReportDetail" class="text-gray-500 hover:text-black transition">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
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
                                <div class="flex flex-wrap items-center gap-2">
                                    <h4 class="font-bold text-blue-900">สรุปการรายงาน</h4>
                                    <button
                                        type="button"
                                        class="inline-flex items-center rounded-full px-3 py-1 text-xs font-semibold border"
                                        :class="getReportScopeClass(selectedReport.reportScope)"
                                    >
                                        {{ getReportScopeText(selectedReport.reportScope) }}
                                    </button>
                                </div>
                                <span 
                                    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold shadow-sm"
                                    :class="{
                                        'bg-yellow-100 text-yellow-800 border border-yellow-200': selectedReport.status === 'PENDING',
                                        'bg-blue-100 text-blue-800 border border-blue-200': selectedReport.status === 'APPROVED',
                                        'bg-green-100 text-green-800 border border-green-200': selectedReport.status === 'RESOLVED',
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
                                        "{{ getReportDetailText(selectedReport.description) }}"
                                    </p>
                                </div>
                                <div v-if="getReportLink(selectedReport.description)" class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">ลิงก์ที่แนบ:</span>
                                    <a
                                        :href="getReportLink(selectedReport.description)"
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        class="block break-all text-blue-700 hover:text-blue-800 underline bg-white/60 p-3 rounded-lg border border-blue-100"
                                    >
                                        {{ getReportLink(selectedReport.description) }}
                                    </a>
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
                            <div class="mt-4 p-3 bg-blue-50 border border-blue-100 rounded-lg text-xs text-blue-800 text-center">
                                หากปัญหานี้ได้รับการแก้ไขแล้ว หรือต้องการให้ข้อมูลเพิ่มเติม<br>สามารถติดต่อแอดมินได้ที่ <strong>admin@example.com</strong>
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
import { computed, ref, onMounted } from 'vue';
import ProfileSidebar from '~/components/ProfileSidebar.vue';
import dayjs from 'dayjs';
import 'dayjs/locale/th';
import ReportStatusCard from '~/components/ReportStatusCard.vue';
import { useAuth } from '~/composables/useAuth';

dayjs.locale('th');

definePageMeta({
    middleware: 'auth'
});

const { $api } = useNuxtApp();
const { user } = useAuth();

const reports = ref([]);
const activeStatus = ref('ALL');

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
        REJECTED: 'ถูกปฏิเสธ',
        RESOLVED: 'ดำเนินการแก้ไขแล้ว'
    };
    return reportStatus[status] || 'ไม่ทราบสถานะ';
}

function getStatusBadgeClass(status) {
    const statusColor = {
        PENDING: 'bg-yellow-100 text-yellow-800 border border-yellow-200',
        APPROVED: 'bg-blue-100 text-blue-800 border border-blue-200',
        REJECTED: 'bg-red-100 text-red-800 border border-red-200',
        RESOLVED: 'bg-green-100 text-green-800 border border-green-200'
    };
    return statusColor[status] || 'bg-gray-100 text-gray-700 border border-gray-200';
}

const reportStatusSummary = computed(() => {
    const summaryConfig = [
        {
            status: 'PENDING',
            label: getReportStatusText('PENDING'),
            textClass: 'text-yellow-700',
            badgeClass: 'bg-yellow-100 text-yellow-800',
            activeClass: 'border-yellow-300 bg-yellow-500 text-white'
        },
        {
            status: 'APPROVED',
            label: getReportStatusText('APPROVED'),
            textClass: 'text-blue-700',
            badgeClass: 'bg-blue-100 text-blue-800',
            activeClass: 'border-blue-300 bg-blue-500 text-white'
        },
        {
            status: 'RESOLVED',
            label: getReportStatusText('RESOLVED'),
            textClass: 'text-green-700',
            badgeClass: 'bg-green-100 text-green-800',
            activeClass: 'border-green-300 bg-green-500 text-white'
        },
        {
            status: 'REJECTED',
            label: getReportStatusText('REJECTED'),
            textClass: 'text-red-700',
            badgeClass: 'bg-red-100 text-red-800',
            activeClass: 'border-red-300 bg-red-500 text-white'
        }
    ];

    return summaryConfig.map((item) => ({
        ...item,
        count: reports.value.filter((report) => report.status === item.status).length,
    }));
});

const filteredReports = computed(() => {
    if (activeStatus.value === 'ALL') {
        return reports.value;
    }

    return reports.value.filter((report) => report.status === activeStatus.value);
});

function setActiveStatus(status) {
    activeStatus.value = status;
}

function getReportScopeText(scope) {
    const scopeMap = {
        SYSTEM: 'รายงานระบบ',
        POST_TRIP: 'รายงานหลังจบทริป',
    };
    return scopeMap[scope] || 'รายงานระบบ';
}

function getReportScopeClass(scope) {
    return 'bg-gray-100 text-gray-700 border-gray-300';
}

function parseReportContent(description) {
    const raw = String(description || '').trim();
    if (!raw) {
        return { detailText: '-', link: '' };
    }

    const lines = raw.split('\n');
    let link = '';
    const detailLines = [];

    for (const line of lines) {
        const trimmed = line.trim();
        const thaiMatch = trimmed.match(/^ลิงก์\s*:\s*(https?:\/\/\S+)/i);
        const enMatch = trimmed.match(/^link\s*:\s*(https?:\/\/\S+)/i);

        if (!link && thaiMatch?.[1]) {
            link = thaiMatch[1];
            continue;
        }

        if (!link && enMatch?.[1]) {
            link = enMatch[1];
            continue;
        }

        detailLines.push(line);
    }

    return {
        detailText: detailLines.join('\n').trim() || '-',
        link,
    };
}

function getReportDetailText(description) {
    return parseReportContent(description).detailText;
}

function getReportLink(description) {
    return parseReportContent(description).link;
}

const fetchReports = async () => {
    try {
        // request only current user's reports
        const res = await $api('/reports/me');
        const allReports = res.data || res || [];
        const currentUserId = user.value?.id;
        reports.value = currentUserId
            ? allReports.filter((r) => r?.reporter?.id === currentUserId || r?.reporterId === currentUserId)
            : allReports;
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
