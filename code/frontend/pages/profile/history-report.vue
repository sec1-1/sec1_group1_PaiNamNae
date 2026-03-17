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
                        <h1 class="text-3xl font-bold text-gray-800 mb-2">เธเธฃเธฐเธงเธฑเธ•เธดเธเธฒเธฃเธฃเธฒเธขเธเธฒเธเธเธญเธเธเธฑเธ</h1>
                        <p class="text-gray-600 max-w-md mx-auto">
                            เธ”เธนเธฃเธฒเธขเธเธฒเธฃเธฃเธฒเธขเธเธฒเธเธเธญเธเธเธธเธ“
                        </p>
                    </div>

                    <div class="bg-white rounded-xl shadow-xl p-8 border border-gray-300">
<<<<<<< Updated upstream
                        <div
                            class="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4 bg-[#F2F2F2] p-4 md:px-6 md:py-6 rounded-[8px]">
                            <p class="text-gray-800 text-base md:text-[18px] text-center sm:text-left">
                                {{ reports.length > 0 ? `คุณมี ${reports.length} รายการรายงาน` :
                                    'คุณยังไม่มีรายการรายงาน' }}
                            </p>
=======
                        <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4 md:p-6">
                            <div class="flex flex-col gap-4">
                                <div class="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
                                    <div>
                                        <p class="text-lg font-semibold text-slate-800 md:text-xl">
                                            เธฃเธฒเธขเธเธฒเธเธ—เธตเนเธชเนเธเธ—เธฑเนเธเธซเธกเธ” {{ reports.length }} เธฃเธฒเธขเธเธฒเธฃ
                                        </p>
                                        <p class="text-sm text-slate-500">
                                            เธเธฅเธดเธเธ—เธตเนเธชเธ–เธฒเธเธฐเน€เธเธทเนเธญเธ”เธนเธฃเธฒเธขเธเธฒเธฃเธฃเธฒเธขเธเธฒเธเนเธเธซเธกเธงเธ”เธเธฑเนเธ
                                        </p>
                                    </div>
                                    <button
                                        type="button"
                                        class="inline-flex items-center justify-center rounded-lg border px-3 py-2 text-sm font-medium transition"
                                        :class="activeStatus === 'ALL' ? 'border-blue-600 bg-blue-600 text-white' : 'border-slate-300 bg-white text-slate-600 hover:border-blue-300 hover:text-blue-600'"
                                        @click="setActiveStatus('ALL')"
                                    >
                                        เธ—เธฑเนเธเธซเธกเธ” {{ reports.length }}
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
>>>>>>> Stashed changes
                        </div>
                        <div v-if="reports.length > 0" class="mt-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div
                                v-for="report in reports"
                                :key="report.id"
                                class="flex flex-col gap-2 cursor-pointer"
                                @click="openReportDetail(report)"
                            >
<<<<<<< Updated upstream
                                <ReportStatusCard :status="report.status" />
                                <p class="text-sm text-gray-700">ประเภท: {{ getCategoryText(report.category) }}</p>
                                <p class="text-sm text-gray-700">วันที่: {{ formatDate(report.createdAt) }}</p>
                            </div>
                        </div>
=======
                                <div class="pointer-events-none absolute inset-x-0 top-0 h-1 bg-gradient-to-r from-red-500 to-rose-500"></div>

                                <div class="space-y-3">
                                    <div class="flex flex-wrap items-center justify-between gap-3">
                                        <div class="flex items-center gap-2 text-[11px] text-slate-500">
                                            <span class="inline-flex h-7 w-7 items-center justify-center rounded-full bg-blue-100 text-blue-700">
                                                <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                </svg>
                                            </span>
                                            <span class="font-medium tracking-wide">เธฃเธฒเธขเธเธฒเธ</span>
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
                                        {{ getCategoryText(report) }}
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
                                                เธ”เธนเธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”
                                            </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="mt-6 rounded-2xl border border-dashed border-slate-300 bg-slate-50 p-8 text-center text-slate-500">
                            {{ activeStatus === 'ALL' ? 'เธเธธเธ“เธขเธฑเธเนเธกเนเธกเธตเธฃเธฒเธขเธเธฒเธฃเธฃเธฒเธขเธเธฒเธ' : `เนเธกเนเธเธเธฃเธฒเธขเธเธฒเธฃเธฃเธฒเธขเธเธฒเธเธชเธ–เธฒเธเธฐ${getReportStatusText(activeStatus)}` }}
                        </div>
>>>>>>> Stashed changes

                    </div>
                </main>
            </div>
        </div>

        <!-- Report Detail Modal (progress style) -->
        <div v-if="showReportDetailModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40"
            @click.self="closeReportDetail">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 overflow-hidden animate-in">
                <!-- Header -->
<<<<<<< Updated upstream
                <div class="bg-gradient-to-r from-red-500 to-red-600 p-6 text-white">
                    <div class="flex items-center justify-between mb-2">
                        <h2 class="text-xl font-bold">ติดตามสถานะรายงาน</h2>
                        <button @click="closeReportDetail" class="text-white/80 hover:text-white transition">
=======
                <div class="border-b border-gray-200 bg-white p-6 text-black">
                    <div class="flex items-center justify-between mb-3">
                        <h2 class="text-xl font-bold">เธ•เธดเธ”เธ•เธฒเธกเธชเธ–เธฒเธเธฐเธฃเธฒเธขเธเธฒเธ</h2>
                        <button @click="closeReportDetail" class="text-gray-500 hover:text-black transition">
>>>>>>> Stashed changes
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
                        <!-- โ… Report Status Card -->
                        <ReportStatusCard
                            :status="selectedReport.status"
                        />
                        <!-- Summary Block -->
                        <div class="bg-blue-50 border border-blue-200 rounded-xl p-5 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
<<<<<<< Updated upstream
                                <h4 class="font-bold text-blue-900">สรุปการรายงาน</h4>
=======
                                <div class="flex flex-wrap items-center gap-2">
                                    <h4 class="font-bold text-blue-900">เธชเธฃเธธเธเธเธฒเธฃเธฃเธฒเธขเธเธฒเธ</h4>
                                    <button
                                        type="button"
                                        class="inline-flex items-center rounded-full px-3 py-1 text-xs font-semibold border"
                                        :class="getReportScopeClass(selectedReport.reportScope)"
                                    >
                                        {{ getReportScopeText(selectedReport.reportScope) }}
                                    </button>
                                </div>
>>>>>>> Stashed changes
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
                                    <span class="opacity-75">เธซเธฑเธงเธเนเธญเธเนเธญเธเธฑเธเธซเธฒ:</span>
                                    <span class="font-semibold">{{ getCategoryText(selectedReport) }}</span>
                                </div>
                                <div class="flex justify-between border-b border-blue-100 pb-2">
                                    <span class="opacity-75">เธงเธฑเธเธ—เธตเนเนเธเนเธ:</span>
                                    <span class="font-semibold text-right">{{ selectedReport.createdAt ? dayjs(selectedReport.createdAt).format('D MMM BBBB HH:mm เธ.') : '-' }}</span>
                                </div>
                                <div class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">เธฃเธฒเธขเธฅเธฐเน€เธญเธตเธขเธ”เธ—เธตเนเนเธเนเธ:</span>
                                    <p class="text-gray-700 bg-white/60 p-3 rounded-lg border border-blue-100 italic leading-relaxed">
                                        "{{ selectedReport.description }}"
                                    </p>
                                </div>
<<<<<<< Updated upstream
=======
                                <div v-if="getReportLink(selectedReport.description)" class="pt-1">
                                    <span class="opacity-75 block mb-1 font-medium">เธฅเธดเธเธเนเธ—เธตเนเนเธเธ:</span>
                                    <a
                                        :href="getReportLink(selectedReport.description)"
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        class="block break-all text-blue-700 hover:text-blue-800 underline bg-white/60 p-3 rounded-lg border border-blue-100"
                                    >
                                        {{ getReportLink(selectedReport.description) }}
                                    </a>
                                </div>
>>>>>>> Stashed changes
                                <div v-if="(selectedReport.images?.length || selectedReport.videos?.length)" class="pt-2">
                                    <span class="opacity-75 block mb-2 font-medium">เนเธเธฅเนเธเธฃเธฐเธเธญเธ:</span>
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
                                เธเธฒเธฃเธ•เธญเธเธฃเธฑเธเธเธฒเธเธ—เธตเธกเธเธฒเธ
                            </h4>
                            <div v-if="selectedReport.status !== 'PENDING'" class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                                <p class="text-sm text-gray-700 leading-relaxed italic">
                                    "{{ selectedReport.adminNotes || 'เนเธ”เนเธฃเธฑเธเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธเน€เธฃเธตเธขเธเธฃเนเธญเธขเนเธฅเนเธง' }}"
                                </p>
                                <div v-if="selectedReport.resolvedAt" class="mt-3 pt-3 border-t border-gray-200 flex justify-between items-center text-[10px] text-gray-400">
                                    <span>เธ•เธฃเธงเธเธชเธญเธเน€เธกเธทเนเธญ: {{ dayjs(selectedReport.resolvedAt).format('D MMM BBBB HH:mm') }}</span>
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

                <!-- Footer -->
                <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                    <button @click="closeReportDetail"
                        class="w-full px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-all shadow-md active:scale-95">
                        เธเธดเธ”
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
    return cats[category] || category || "-";
}

function getReportStatusText(status) {
    const reportStatus = {
<<<<<<< Updated upstream
        PENDING: 'รอการตรวจสอบ',
        APPROVED: 'รับเรื่องแล้ว',
        REJECTED: 'ไม่พบสถานะ',
        RESOLVED: 'ดำเนินการแก้ไขแล้ว'
=======
        PENDING: 'เธฃเธญเธเธฒเธฃเธ•เธฃเธงเธเธชเธญเธ',
        APPROVED: 'เธฃเธฑเธเน€เธฃเธทเนเธญเธเนเธฅเนเธง',
        REJECTED: 'เธ–เธนเธเธเธเธดเน€เธชเธ',
        RESOLVED: 'เธ”เธณเน€เธเธดเธเธเธฒเธฃเนเธเนเนเธเนเธฅเนเธง'
>>>>>>> Stashed changes
    };
    return reportStatus[status] || 'เนเธกเนเธ—เธฃเธฒเธเธชเธ–เธฒเธเธฐ';
}

<<<<<<< Updated upstream
=======
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
        SYSTEM: 'เธฃเธฒเธขเธเธฒเธเธฃเธฐเธเธ',
        POST_TRIP: 'เธฃเธฒเธขเธเธฒเธเธซเธฅเธฑเธเธเธเธ—เธฃเธดเธ',
    };
    return scopeMap[scope] || 'เธฃเธฒเธขเธเธฒเธเธฃเธฐเธเธ';
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
        const thaiMatch = trimmed.match(/^เธฅเธดเธเธเน\s*:\s*(https?:\/\/\S+)/i);
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

>>>>>>> Stashed changes
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


