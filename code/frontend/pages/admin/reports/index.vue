<template>
    <div>
        <AdminHeader />
        <AdminSidebar />

        <!-- Main Content -->
        <main id="main-content" class="main-content mt-2 ml-0 lg:ml-[280px] p-6">
            <div class="mx-auto max-w-8xl">
                <!-- Title + Controls -->
                <div class="flex flex-col gap-3 mb-6 sm:flex-row sm:items-center sm:justify-between">
                    <div class="flex items-center gap-3">
                        <h1 class="text-2xl font-semibold text-gray-800">Check Report</h1>
                    </div>
</div>
                    <!-- Report Statistics -->
<!-- Report Statistics -->
<div class="mb-6">
    <div class="flex gap-2">
        <div
            v-for="item in categoryStatCards"
            :key="item.key"
            class="flex-1 min-w-0 p-2 rounded-lg border bg-white border-gray-200"
        >
            <div class="text-[11px] text-gray-500 font-medium truncate">
                {{ item.label }}
            </div>
            <div class="text-base font-bold text-gray-800 mt-1 leading-none">
                {{ item.count }}
            </div>
        </div>
    </div>
</div>

                

                <!-- Card -->
                <div class="bg-white border border-gray-300 rounded-lg shadow-sm">
                    <div class="px-4 py-4 border-b border-gray-200 sm:px-6">
                        <div class="flex flex-col gap-4 xl:flex-row xl:items-center xl:justify-between">
                            <div class="text-sm text-gray-600">
                                หน้าที่ {{ pagination.page }} / {{ pagination.totalPages || 1 }} • ทั้งหมด {{ pagination.total }} รายงาน
                            </div>

                            <div class="flex flex-col gap-3 lg:flex-row lg:items-start lg:justify-between lg:flex-1 lg:max-w-4xl xl:max-w-5xl">
                                <div class="flex flex-col gap-2">
                                    <span class="text-xs font-semibold tracking-wide text-gray-500 uppercase">สถานะ</span>
                                    <div class="flex flex-wrap gap-2">
                                        <button
                                            @click="filterByStatus('')"
                                            class="px-3 py-1 text-xs rounded-full border transition"
                                            :class="!filters.status
                                                ? 'bg-blue-600 text-white border-blue-600'
                                                : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'"
                                        >
                                            สถานะทั้งหมด
                                        </button>

                                        <button
                                            v-for="s in statuses"
                                            :key="s.key"
                                            @click="filterByStatus(s.key)"
                                            class="px-3 py-1 text-xs rounded-full border transition"
                                            :class="filters.status === s.key
                                                ? 'bg-blue-600 text-white border-blue-600'
                                                : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'"
                                        >
                                            {{ s.label }}
                                        </button>
                                    </div>
                                </div>

                                <div class="flex flex-col gap-2 lg:items-end">
                                    <span class="text-xs font-semibold tracking-wide text-gray-500 uppercase">ประเภทรายงาน</span>
                                    <div class="flex flex-wrap gap-2 lg:justify-end">
                                        <button
                                            @click="filterByReportScope('')"
                                            class="px-3 py-1 text-xs rounded-full border transition"
                                            :class="!filters.reportScope
                                                ? 'bg-indigo-600 text-white border-indigo-600'
                                                : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'"
                                        >
                                            ประเภทรายงานทั้งหมด
                                        </button>

                                        <button
                                            v-for="s in reportScopes"
                                            :key="s.key"
                                            @click="filterByReportScope(s.key)"
                                            class="px-3 py-1 text-xs rounded-full border transition"
                                            :class="filters.reportScope === s.key
                                                ? 'bg-indigo-600 text-white border-indigo-600'
                                                : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'"
                                        >
                                            {{ s.label }}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Loading / Error -->
                    <div v-if="isLoading" class="p-8 text-center text-gray-500">กำลังโหลดข้อมูล...</div>
                    <div v-else-if="loadError" class="p-8 text-center text-red-600">{{ loadError }}</div>

                    <!-- Table -->
                    <div v-else class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">หมวดหมู่</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">ประเภทรายงาน</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">ผู้รายงาน</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">ผู้ถูกรายงาน</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">สร้างเมื่อ</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">สถานะ</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">การกระทำ</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
  <tr
    v-for="report in reports"
    :key="report.id"
    class="transition-opacity hover:bg-gray-50"
  >
    <!-- ประเภท / หมวดหมู่ -->
    <td class="px-4 py-3 text-sm text-gray-900">
      <div class="font-medium">
        {{ categoryLabel(report.category) }}
      </div>

    </td>

        <!-- ขอบเขตรายงาน -->
        <td class="px-4 py-3 text-sm text-gray-900 whitespace-nowrap">
            <span class="text-sm font-medium text-gray-900 whitespace-nowrap">
                {{ reportScopeLabel(report.reportScope) }}
            </span>
        </td>

    <!-- ผู้รายงาน -->
    <td class="px-4 py-3 text-sm text-gray-900">
      {{ report.reporterName || 'ไม่ระบุ' }}
    </td>

    <!-- ผู้ถูกรายงาน -->
    <td class="px-4 py-3 text-sm text-gray-900">
      {{
        report.targetUser
          ? `${report.targetUser.firstName} ${report.targetUser.lastName}`
          : 'ไม่ระบุ'
      }}
    </td>

    <!-- วันที่สร้าง -->
    <td class="px-4 py-3 text-sm text-gray-500">
      {{ formatDate(report.createdAt) || 'ไม่ระบุวันที่' }}
    </td>

    <!-- สถานะ -->
        <td class="px-4 py-3 text-sm whitespace-nowrap">
      <span
                class="inline-flex items-center px-2 py-1 text-xs font-medium rounded-full whitespace-nowrap"
        :class="statusBadge(report.status)"
      >
        {{ statusLabel(report.status) }}
      </span>
    </td>

    <!-- การกระทำ -->
    <td class="px-4 py-3 text-sm">
      <button
        @click="openViewModal(report)"
                class="px-3 py-1 text-xs text-blue-600 bg-white border border-blue-200 rounded hover:bg-blue-50 shadow-sm"
        title="ตรวจสอบรายงาน"
      >
        ตรวจสอบ
      </button>
    </td>
  </tr>

  <!-- ไม่มีข้อมูล -->
  <tr v-if="!reports.length">
                <td colspan="7" class="px-4 py-10 text-center text-gray-500">
      ไม่พบข้อมูลรายงาน
    </td>
  </tr>
</tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div
                        class="flex flex-col gap-3 px-4 py-4 border-t border-gray-200 sm:px-6 sm:flex-row sm:items-center sm:justify-between">
                        <div class="flex flex-wrap items-center gap-3 text-sm">
                            <div class="flex items-center gap-2">
                                <span class="text-xs text-gray-500">Limit:</span>
                                <select v-model.number="pagination.limit" @change="applyFilters"
                                    class="px-2 py-1 text-sm border border-gray-300 rounded-md focus:ring-blue-500">
                                    <option :value="10">10</option>
                                    <option :value="20">20</option>
                                    <option :value="50">50</option>
                                </select>
                            </div>
                        </div>

                        <nav class="flex items-center gap-1">
                            <button class="px-3 py-2 text-sm border rounded-md disabled:opacity-50"
                                :disabled="pagination.page <= 1 || isLoading" @click="changePage(pagination.page - 1)">
                                Previous
                            </button>

                            <template v-for="(p, idx) in pageButtons" :key="`p-${idx}-${p}`">
                                <span v-if="p === '…'" class="px-2 text-sm text-gray-500">…</span>
                                <button v-else class="px-3 py-2 text-sm border rounded-md"
                                    :class="p === pagination.page ? 'bg-blue-50 text-blue-600 border-blue-200' : 'hover:bg-gray-50'"
                                    :disabled="isLoading" @click="changePage(p)">
                                    {{ p }}
                                </button>
                            </template>

                            <button class="px-3 py-2 text-sm border rounded-md disabled:opacity-50"
                                :disabled="pagination.page >= pagination.totalPages || isLoading"
                                @click="changePage(pagination.page + 1)">
                                Next
                            </button>
                        </nav>
                    </div>

                </div>
            </div>
        </main>
        
        <div id="overlay" class="fixed inset-0 z-[1040] hidden bg-black bg-opacity-50 lg:hidden" @click="closeMobileSidebar"></div>

        <!-- View Report Modal -->
        <Transition name="modal-fade">
        <div v-if="showViewModal && viewingReport" class="fixed inset-0 z-[1050] flex items-center justify-center p-4 bg-slate-950/60 backdrop-blur-sm" @click.self="closeViewModal">
            <div class="modal-popup w-full max-w-5xl bg-slate-50 rounded-3xl shadow-2xl overflow-hidden flex flex-col max-h-[92vh] border border-slate-200">
                <div class="relative overflow-hidden border-b border-slate-200 bg-white px-6 py-5 text-slate-900">
                    <div class="relative flex items-start justify-between gap-4">
                        <div>
                            <h3 class="text-2xl font-semibold tracking-tight">ตรวจสอบรายงาน</h3>
                        </div>
                        <button @click="closeViewModal" class="relative z-10 inline-flex h-10 w-10 items-center justify-center rounded-full border border-slate-200 text-slate-500 transition hover:bg-slate-100 hover:text-slate-900 focus:outline-none">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                </div>

                <div class="flex-1 overflow-y-auto bg-slate-50/80 p-6">
                    <div class="space-y-6">
                        <section class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                            <h4 class="text-lg font-semibold text-slate-900">ข้อมูลรายงาน</h4>
                            <div class="mt-4 grid grid-cols-1 gap-4 md:grid-cols-2">
                                <div class="rounded-2xl bg-slate-50 p-4">
                                    <p class="text-xs font-semibold tracking-wide text-slate-500">ประเภทรายงาน</p>
                                    <p class="mt-2 text-sm font-semibold text-slate-900">{{ reportScopeLabel(viewingReport.reportScope) }}</p>
                                </div>
                                <div class="rounded-2xl bg-slate-50 p-4">
                                    <p class="text-xs font-semibold tracking-wide text-slate-500">สถานะ</p>
                                    <div class="mt-2">
                                        <span class="inline-flex items-center rounded-full px-3 py-1 text-xs font-semibold" :class="statusBadge(viewingReport.status)">
                                            {{ statusLabel(viewingReport.status) }}
                                        </span>
                                    </div>
                                </div>
                                <div class="rounded-2xl bg-slate-50 p-4">
                                    <p class="text-xs font-semibold tracking-wide text-slate-500">หมวดหมู่</p>
                                    <p class="mt-2 text-sm font-semibold text-slate-900">{{ categoryLabel(viewingReport.category) }}</p>
                                </div>
                                <div class="rounded-2xl bg-slate-50 p-4">
                                    <p class="text-xs font-semibold tracking-wide text-slate-500">วันที่สร้าง</p>
                                    <p class="mt-2 text-sm font-semibold text-slate-900">{{ formatDate(viewingReport.createdAt) }}</p>
                                </div>
                                <div class="rounded-2xl bg-slate-50 p-4">
                                    <p class="text-xs font-semibold tracking-wide text-slate-500">ผู้รายงาน</p>
                                    <p class="mt-2 text-sm font-semibold text-slate-900">{{ viewingReport.reporterName || '-' }}</p>
                                    <p class="mt-1 text-xs text-slate-500 break-all">{{ viewingReport.reporterEmail || '-' }}</p>
                                </div>
                                <div v-if="viewingReport.targetUser" class="rounded-2xl bg-slate-50 p-4">
                                    <p class="text-xs font-semibold tracking-wide text-slate-500">ผู้ถูกรายงาน</p>
                                    <p class="mt-2 text-sm font-semibold text-slate-900">{{ targetUserName(viewingReport) }}</p>
                                    <p class="mt-1 text-xs text-slate-500 break-all">{{ targetUserEmail(viewingReport) }}</p>
                                </div>
                            </div>

                            <div v-if="viewingReport.routeId || viewingReport.bookingId" class="mt-4 grid grid-cols-1 gap-3 md:grid-cols-2">
                                <button v-if="viewingReport.routeId" @click="goToRoute(viewingReport.routeId)" class="flex w-full items-center justify-between rounded-2xl border border-slate-200 bg-white px-4 py-4 text-left transition hover:border-blue-200 hover:bg-blue-50">
                                    <div>
                                        <p class="text-xs font-semibold tracking-wide text-slate-500">เส้นทางอ้างอิง</p>
                                        <p class="mt-1 text-sm font-medium text-slate-900">ดูเส้นทาง</p>
                                    </div>
                                    <i class="fas fa-arrow-up-right-from-square text-blue-500"></i>
                                </button>

                                <button v-if="viewingReport.bookingId" @click="goToBooking(viewingReport.bookingId)" class="flex w-full items-center justify-between rounded-2xl border border-slate-200 bg-white px-4 py-4 text-left transition hover:border-blue-200 hover:bg-blue-50">
                                    <div>
                                        <p class="text-xs font-semibold tracking-wide text-slate-500">การจองอ้างอิง</p>
                                        <p class="mt-1 text-sm font-medium text-slate-900">ดูการจอง</p>
                                    </div>
                                    <i class="fas fa-arrow-up-right-from-square text-blue-500"></i>
                                </button>
                            </div>
                        </section>

                        <section class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                            <h4 class="text-lg font-semibold text-slate-900">รายละเอียดการรายงาน</h4>
                            <div class="mt-4 rounded-2xl border border-slate-200 bg-slate-50 p-4 text-sm leading-7 text-slate-700 whitespace-pre-wrap">{{ getReportDetailText(viewingReport.description) }}</div>

                            <div v-if="getReportLink(viewingReport.description)" class="mt-4 rounded-2xl border border-blue-200 bg-blue-50 p-4">
                                <p class="text-xs font-semibold tracking-wide text-blue-600">ลิงก์ที่แนบ</p>
                                <a :href="getReportLink(viewingReport.description)" target="_blank" rel="noopener noreferrer" class="mt-2 block break-all text-sm font-medium text-blue-700 underline decoration-blue-300 underline-offset-2 hover:text-blue-800">
                                    {{ getReportLink(viewingReport.description) }}
                                </a>
                            </div>

                            <div v-if="viewingReport.adminNotes" class="mt-4 rounded-2xl border border-emerald-200 bg-emerald-50 p-4">
                                <p class="text-xs font-semibold tracking-wide text-emerald-600">หมายเหตุจากผู้ดูแล</p>
                                <p class="mt-2 text-sm leading-7 text-emerald-900 whitespace-pre-wrap">{{ viewingReport.adminNotes }}</p>
                            </div>
                        </section>

                        <section v-if="viewingReport.images?.length || viewingReport.videos?.length" class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                            <h4 class="text-lg font-semibold text-slate-900">ไฟล์แนบ</h4>

                            <div v-if="viewingReport.images?.length" class="mt-4">
                                <p class="mb-3 text-sm font-semibold text-slate-700">รูปภาพ</p>
                                <div class="grid grid-cols-2 gap-3 md:grid-cols-3 xl:grid-cols-4">
                                    <a v-for="(img, idx) in viewingReport.images" :key="`img-${idx}`" :href="img" target="_blank" rel="noopener noreferrer" class="group overflow-hidden rounded-2xl border border-slate-200 bg-slate-100 shadow-sm">
                                        <img :src="img" class="h-36 w-full object-cover transition duration-300 group-hover:scale-105" alt="ไฟล์แนบรายงาน" />
                                    </a>
                                </div>
                            </div>

                            <div v-if="viewingReport.videos?.length" class="mt-5">
                                <p class="mb-3 text-sm font-semibold text-slate-700">วิดีโอหรือเสียง</p>
                                <div class="grid grid-cols-1 gap-4 lg:grid-cols-2">
                                    <div v-for="(vid, idx) in viewingReport.videos" :key="`vid-${idx}`" class="overflow-hidden rounded-2xl border border-slate-200 bg-slate-950 shadow-sm">
                                        <video :src="vid" controls class="h-56 w-full bg-black object-contain"></video>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>

                <div class="px-6 py-4 border-t border-slate-200 bg-white">
                    <div class="mb-4">
                        <label for="admin-notes" class="block text-sm font-semibold text-slate-700 mb-2">
                            หมายเหตุหรือข้อความตอบกลับจากผู้ดูแล
                        </label>
                        <textarea
                            id="admin-notes"
                            v-model="adminComment"
                            rows="3"
                            class="w-full px-4 py-3 text-sm text-slate-700 bg-slate-50 border border-slate-200 rounded-2xl focus:ring-2 focus:ring-blue-100 focus:border-blue-400 transition-all placeholder:text-slate-400"
                            placeholder="กรอกข้อความที่ต้องการแจ้งให้ผู้รายงานทราบ... (เช่น ขอข้อมูลเพิ่มเติม หรือแจ้งการดำเนินการ)"
                        ></textarea>
                    </div>

                    <div class="flex flex-wrap items-center justify-between gap-4">
                        <div class="text-xs text-slate-500 italic">
                            * ข้อความนี้จะถูกแสดงให้ผู้รายงานเห็นในหน้ารายละเอียดการรายงาน
                        </div>

                        <div class="flex flex-wrap items-center gap-2">
                            <button 
                                v-if="viewingReport.status !== 'RESOLVED' && viewingReport.status !== 'REJECTED'" 
                                @click="updateStatus(viewingReport, 'REJECTED')" 
                                :disabled="isUpdating"
                                class="px-5 py-2 text-sm font-semibold text-red-600 bg-white border border-red-200 hover:bg-red-50 hover:border-red-300 rounded-xl transition shadow-sm disabled:opacity-50"
                            >
                                <i class="fas fa-times-circle mr-1.5"></i>ปฏิเสธ
                            </button>
                            <button 
                                v-if="viewingReport.status === 'PENDING'" 
                                @click="updateStatus(viewingReport, 'APPROVED')" 
                                :disabled="isUpdating"
                                class="px-5 py-2 text-sm font-semibold text-amber-600 bg-white border border-amber-200 hover:bg-amber-50 hover:border-amber-300 rounded-xl transition shadow-sm disabled:opacity-50"
                            >
                                <i class="fas fa-search mr-1.5"></i>กำลังตรวจสอบ
                            </button>
                            <button 
                                v-if="viewingReport.status === 'APPROVED' || viewingReport.status === 'PENDING'" 
                                @click="updateStatus(viewingReport, 'RESOLVED')" 
                                :disabled="isUpdating"
                                class="px-5 py-2 text-sm font-semibold text-emerald-600 bg-white border border-emerald-200 hover:bg-emerald-50 hover:border-emerald-300 rounded-xl transition shadow-sm disabled:opacity-50"
                            >
                                <i class="fas fa-check-circle mr-1.5"></i>ตอบรับการรายงาน
                            </button>
                            <button 
                                @click="closeViewModal" 
                                class="px-5 py-2 text-sm font-semibold text-slate-600 bg-white border border-slate-200 rounded-xl hover:bg-slate-50 transition shadow-sm ml-2"
                            >
                                ปิด
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </Transition>

        <!-- Confirm Delete Modal -->
        <ConfirmModal :show="showDelete" :title="`ลบการรายงาน${deletingReport?.id ? ' : ' + deletingReport.id.substring(0,8) : ''}`"
            message="การลบนี้เป็นการลบถาวร ข้อมูลทั้งหมดจะถูกลบและไม่สามารถกู้คืนได้ คุณต้องการดำเนินการต่อหรือไม่?"
            confirmText="ลบถาวร" cancelText="ยกเลิก" variant="danger" @confirm="confirmDelete" @cancel="cancelDelete" />

    </div>
</template>

<script setup>

import { ref, reactive, computed, onMounted, onUnmounted } from 'vue'
import { useCookie, useRuntimeConfig, navigateTo } from '#app'
import dayjs from 'dayjs'
import 'dayjs/locale/th'
import buddhistEra from 'dayjs/plugin/buddhistEra'
import AdminHeader from '~/components/admin/AdminHeader.vue'
import AdminSidebar from '~/components/admin/AdminSidebar.vue'
import ConfirmModal from '~/components/ConfirmModal.vue'
import { useToast } from '~/composables/useToast'

const reportStats = ref({ categoryStats: [] })

dayjs.locale('th')
dayjs.extend(buddhistEra)

definePageMeta({ middleware: ['admin-auth'] })

const { toast } = useToast()
const config = useRuntimeConfig()

const reports = ref([])
const isLoading = ref(false)
const loadError = ref('')

const pagination = reactive({
    page: 1,
    limit: 20,
    total: 0,
    totalPages: 1
})

const adminComment = ref('')
const isUpdating = ref(false)

const filters = reactive({
  q: '',
    status: '',
    reportScope: ''
})

function formatDate(iso) {
    if (!iso) return '-'
    return dayjs(iso).format('D MMMM BBBB HH:mm')
}

const pageButtons = computed(() => {
    const total = pagination.totalPages
    const current = pagination.page
    if (!total || total < 1) return []
    if (total <= 5) return Array.from({ length: total }, (_, i) => i + 1)
    const set = new Set([1, total, current])
    if (current - 1 > 1) set.add(current - 1)
    if (current + 1 < total) set.add(current + 1)
    const pages = Array.from(set).sort((a, b) => a - b)
    const out = []
    for (let i = 0; i < pages.length; i++) {
        if (i > 0 && pages[i] - pages[i - 1] > 1) out.push('…')
        out.push(pages[i])
    }
    return out
})
async function fetchReports() {
    isLoading.value = true
    loadError.value = ''

    try {
        const token = useCookie('token').value || 
            (process.client ? localStorage.getItem('token') : '')

        const params = new URLSearchParams()
        params.append('page', pagination.page)
        params.append('limit', pagination.limit)

        if (filters.q) params.append('q', filters.q)
        if (filters.status) params.append('status', filters.status)
        if (filters.reportScope) params.append('reportScope', filters.reportScope)

        const res = await fetch(
            `${config.public.apiBase}/reports/admin?${params.toString()}`,
            { 
                headers: {
                    Accept: 'application/json',
                    ...(token ? { Authorization: `Bearer ${token}` } : {})
                },
                credentials: 'include'
            }
        )

        const body = await res.json()
        if (!res.ok) throw new Error(body?.message || `Request failed: ${res.status}`)

        reports.value = Array.isArray(body?.data) ? body.data : []

        if (body.pagination) {
            pagination.total = body.pagination.total
            pagination.totalPages = body.pagination.totalPages
            pagination.page = body.pagination.page
        } else {
            pagination.total = reports.value.length
            pagination.totalPages = 1
        }

    } catch (err) {
        console.error(err)
        loadError.value = err?.message || 'ไม่สามารถโหลดข้อมูลได้'
        toast.error('เกิดข้อผิดพลาด', loadError.value)
        reports.value = []
        reportStats.value = { categoryStats: [] }
    } finally {
        isLoading.value = false
    }
}

const categoryStatCards = computed(() => reportStats.value?.categoryStats || [])

const statuses = [
  { key: 'PENDING', label: 'รอดำเนินการ' },
  { key: 'APPROVED', label: 'กำลังตรวจสอบ' },
  { key: 'RESOLVED', label: 'ตอบรับแล้ว' },
  { key: 'REJECTED', label: 'ปฏิเสธแล้ว' }
]

const reportScopes = [
    { key: 'SYSTEM', label: 'รายงานระบบ' },
    { key: 'POST_TRIP', label: 'รายงานหลังจบทริป' }
]

function reportScopeLabel(scope) {
    const map = {
        SYSTEM: 'รายงานระบบ',
        POST_TRIP: 'รายงานหลังจบทริป'
    }
    return map[scope] || scope || '-'
}

function scopeBadge(scope) {
    if (scope === 'POST_TRIP') return 'bg-orange-100 text-orange-700'
    if (scope === 'SYSTEM') return 'bg-blue-100 text-blue-700'
    return 'bg-gray-100 text-gray-700'
}

function categoryLabel(category) {
  const map = {
    VEHICLE_ISSUE: 'ปัญหายานพาหนะ',
    PASSENGER_ISSUE: 'ปัญหาผู้โดยสาร',
    ROAD_ISSUE: 'ปัญหาเส้นทาง',
    SAFETY_ISSUE: 'ความปลอดภัย',
    PAYMENT_ISSUE: 'ปัญหาการชำระเงิน',
    NO_SHOW: 'ไม่มาตามนัด',
    OTHER: 'อื่น ๆ'
  }
  return map[category] || category || '-'
}

function getReportLink(description) {
    if (!description) return ''
    const linkLine = String(description)
        .split('\n')
        .map(line => line.trim())
        .find(line => line.startsWith('ลิงก์:'))
    if (!linkLine) return ''
    return linkLine.replace('ลิงก์:', '').trim()
}

function getReportDetailText(description) {
    if (!description) return '-'
    return String(description)
        .split('\n')
        .filter(line => !line.trim().startsWith('ลิงก์:'))
        .join('\n')
        .trim() || '-'
}

function targetUserName(report) {
    if (!report?.targetUser) return 'ไม่ระบุ'
    return `${report.targetUser.firstName} ${report.targetUser.lastName}`.trim() || 'ไม่ระบุ'
}

function targetUserEmail(report) {
    return report?.targetUser?.email || '-'
}

function filterByStatus(statusKey) {
  filters.status = statusKey
  pagination.page = 1
  fetchReports()
}

function filterByReportScope(scopeKey) {
    filters.reportScope = scopeKey
    pagination.page = 1
    fetchReports()
}

async function fetchReportStats() {
    try {
        const token = useCookie('token').value || 
            (process.client ? localStorage.getItem('token') : '')

        const res = await fetch(
            `${config.public.apiBase}/reports/admin/stats`,
            {
                headers: {
                    Accept: 'application/json',
                    ...(token ? { Authorization: `Bearer ${token}` } : {})
                },
                credentials: 'include'
            }
        )

        const body = await res.json()
        if (!res.ok) throw new Error(body?.message || `Request failed: ${res.status}`)

        reportStats.value = {
            categoryStats: Array.isArray(body?.categoryStats) ? body.categoryStats : []
        }

    } catch (err) {
        console.error(err)
        reportStats.value = { categoryStats: [] }
    }
}

function changePage(next) {
    if (next < 1 || next > pagination.totalPages) return
    pagination.page = next
    fetchReports()
}

function applyFilters() {
    pagination.page = 1
    fetchReports()
}

const showViewModal = ref(false)
const viewingReport = ref(null)

function openViewModal(report) {
    viewingReport.value = { ...report }
    adminComment.value = report.adminNotes || ''
    showViewModal.value = true
}

function closeViewModal() {
    showViewModal.value = false
    adminComment.value = ''
    // viewingReport.value = null
}

async function updateStatus(report, status) {
    if (isUpdating.value) return
    isUpdating.value = true

    try {
        const token = useCookie('token').value || (process.client ? localStorage.getItem('token') : '')
        const res = await fetch(`${config.public.apiBase}/reports/admin/${report.id}`, {
            method: 'PATCH',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
                ...(token ? { Authorization: `Bearer ${token}` } : {})
            },
            body: JSON.stringify({ 
                status,
                adminNotes: adminComment.value 
            }),
            credentials: 'include'
        })

        const body = await res.json()
        if (!res.ok) throw new Error(body?.message || `Request failed: ${res.status}`)

        // Update locally in list and modal
        const index = reports.value.findIndex(r => r.id === report.id)
        if (index !== -1) {
             reports.value[index].status = status
             reports.value[index].adminNotes = adminComment.value
        }
        if (viewingReport.value && viewingReport.value.id === report.id) {
             viewingReport.value.status = status
             viewingReport.value.adminNotes = adminComment.value
        }
        
        let statusTh = status
        if (status === 'APPROVED') statusTh = 'กำลังตรวจสอบ'
        if (status === 'RESOLVED') statusTh = 'ตอบรับการรายงานแล้ว'
        if (status === 'REJECTED') statusTh = 'ปฏิเสธ'

        if (status === 'APPROVED') {
            toast.info('อัปเดตสถานะสำเร็จ', `สถานะรายงานเปลี่ยนเป็น ${statusTh}`)
        } else if (status === 'REJECTED') {
            toast.error('อัปเดตสถานะสำเร็จ', `สถานะรายงานเปลี่ยนเป็น ${statusTh}`)
        } else {
            toast.success('อัปเดตสถานะสำเร็จ', `สถานะรายงานเปลี่ยนเป็น ${statusTh}`)
        }
        
        // Refresh full list to get correct resolvedBy / etc.
        fetchReports()
        
        // Close modal after success
        // closeViewModal()
        
    } catch (err) {
        console.error(err)
        toast.error('ไม่สามารถอัปเดตสถานะได้', err.message)
    } finally {
        isUpdating.value = false
    }
}

const showDelete = ref(false)
const deletingReport = ref(null)
function askDelete(r) { 
    deletingReport.value = r; 
    showDelete.value = true 
}
function cancelDelete() { 
    showDelete.value = false; 
    deletingReport.value = null 
}

async function confirmDelete() {
    if (!deletingReport.value) return
    const r = deletingReport.value
    try {
        const token = useCookie('token').value || (process.client ? localStorage.getItem('token') : '')
        const res = await fetch(`${config.public.apiBase}/reports/admin/${r.id}`, {
            method: 'DELETE',
            headers: { Accept: 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) },
            credentials: 'include',
        })
        if (!res.ok) { 
            const body = await res.json()
            throw new Error(body?.message || `Request failed with status ${res.status}`) 
        }

        toast.success('ลบรายงานเรียบร้อย', `รายงานถูกลบถาวรแล้ว`)
        cancelDelete()
        closeViewModal()
        fetchReports()
    } catch (err) {
        console.error(err)
        toast.error('ลบไม่สำเร็จ', err.message || 'ไม่สามารถลบการรายงานได้')
    }
}

function goToRoute(routeId) {
    navigateTo(`/admin/routes/${routeId}`)
}
function goToBooking(bookingId) {
    navigateTo(`/admin/bookings/${bookingId}`)
}

function statusBadge(s) {
    const status = String(s || '').toUpperCase()
    if (status === 'PENDING') return 'bg-yellow-100 text-yellow-700'
    if (status === 'RESOLVED') return 'bg-green-100 text-green-700'
    if (status === 'APPROVED') return 'bg-amber-100 text-amber-700'
    if (status === 'REJECTED') return 'bg-red-100 text-red-700'
    return 'bg-gray-100 text-gray-700'
}

function statusLabel(s) {
    const status = String(s || '').toUpperCase()
    const map = {
        PENDING: 'รอดำเนินการ',
        APPROVED: 'กำลังตรวจสอบ',
        REJECTED: 'ปฏิเสธแล้ว',
        RESOLVED: 'ตอบรับแล้ว',
    }
    return map[status] || 'รอดำเนินการ'
}

function closeMobileSidebar() {
    const sidebar = document.getElementById('sidebar')
    const overlay = document.getElementById('overlay')
    if (!sidebar || !overlay) return
    sidebar.classList.remove('mobile-open')
    overlay.classList.add('hidden')
}

// Global scripts identical to bookings
function defineGlobalScripts() {
    window.toggleSidebar = function () {
        const sidebar = document.getElementById('sidebar')
        const mainContent = document.getElementById('main-content')
        const toggleIcon = document.getElementById('toggle-icon')
        if (!sidebar || !mainContent || !toggleIcon) return
        sidebar.classList.toggle('collapsed')
        if (sidebar.classList.contains('collapsed')) {
            mainContent.style.marginLeft = '80px'
            toggleIcon.classList.replace('fa-chevron-left', 'fa-chevron-right')
        } else {
            mainContent.style.marginLeft = '280px'
            toggleIcon.classList.replace('fa-chevron-right', 'fa-chevron-left')
        }
    }
    window.toggleMobileSidebar = function () {
        const sidebar = document.getElementById('sidebar')
        const overlay = document.getElementById('overlay')
        if (!sidebar || !overlay) return
        sidebar.classList.toggle('mobile-open')
        overlay.classList.toggle('hidden')
    }
    window.toggleSubmenu = function (menuId) {
        const menu = document.getElementById(menuId)
        const icon = document.getElementById(menuId + '-icon')
        if (!menu || !icon) return
        menu.classList.toggle('hidden')
        if (menu.classList.contains('hidden')) {
            icon.classList.replace('fa-chevron-up', 'fa-chevron-down')
        } else {
            icon.classList.replace('fa-chevron-down', 'fa-chevron-up')
        }
    }
    window.__adminResizeHandler__ = function () {
        const sidebar = document.getElementById('sidebar')
        const mainContent = document.getElementById('main-content')
        const overlay = document.getElementById('overlay')
        if (!sidebar || !mainContent || !overlay) return
        if (window.innerWidth >= 1024) {
            sidebar.classList.remove('mobile-open')
            overlay.classList.add('hidden')
            if (sidebar.classList.contains('collapsed')) {
                mainContent.style.marginLeft = '80px'
            } else {
                mainContent.style.marginLeft = '280px'
            }
        } else {
            mainContent.style.marginLeft = '0'
        }
    }
    window.addEventListener('resize', window.__adminResizeHandler__)
}

function cleanupGlobalScripts() {
    window.removeEventListener('resize', window.__adminResizeHandler__ || (() => { }))
    delete window.toggleSidebar
    delete window.toggleMobileSidebar
    delete window.closeMobileSidebar
    delete window.toggleSubmenu
    delete window.__adminResizeHandler__
}

onMounted(() => {
    defineGlobalScripts()
    if (typeof window.__adminResizeHandler__ === 'function') window.__adminResizeHandler__()
    fetchReports()
    fetchReportStats()
})

onUnmounted(() => { cleanupGlobalScripts() })
</script>

<style>
.sidebar {
    transition: width 0.3s ease;
}

.sidebar.collapsed {
    width: 80px;
}

.sidebar:not(.collapsed) {
    width: 280px;
}

.sidebar-item {
    transition: all 0.3s ease;
}

.sidebar-item:hover {
    background-color: rgba(59, 130, 246, 0.05);
}

.sidebar.collapsed .sidebar-text {
    display: none;
}

.sidebar.collapsed .sidebar-item {
    justify-content: center;
}

.main-content {
    transition: margin-left 0.3s ease;
}

@media (max-width: 768px) {
    .sidebar {
        position: fixed;
        z-index: 1000;
        transform: translateX(-100%);
    }

    .sidebar.mobile-open {
        transform: translateX(0);
    }

    .main-content {
        margin-left: 0 !important;
    }
}

/* Modal popup animation */
.modal-fade-enter-active {
    transition: opacity 0.25s ease;
}
.modal-fade-enter-active .modal-popup {
    transition: transform 0.25s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.25s ease;
}
.modal-fade-leave-active {
    transition: opacity 0.2s ease;
}
.modal-fade-leave-active .modal-popup {
    transition: transform 0.2s ease, opacity 0.2s ease;
}
.modal-fade-enter-from {
    opacity: 0;
}
.modal-fade-enter-from .modal-popup {
    opacity: 0;
    transform: scale(0.9);
}
.modal-fade-leave-to {
    opacity: 0;
}
.modal-fade-leave-to .modal-popup {
    opacity: 0;
    transform: scale(0.9);
}

</style>
