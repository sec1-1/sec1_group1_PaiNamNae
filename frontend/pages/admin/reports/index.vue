<template>
    <div>
        <AdminHeader />
        <AdminSidebar />

        <!-- Main Content -->
        <main id="main-content" class="main-content mt-16 ml-0 lg:ml-[280px] p-6">
            <div class="mx-auto max-w-8xl">
                <!-- Title + Controls -->
                <div class="flex flex-col gap-3 mb-6 sm:flex-row sm:items-center sm:justify-between">
                    <div class="flex items-center gap-3">
                        <h1 class="text-2xl font-semibold text-gray-800">Check Report</h1>
                    </div>

                    <!-- Right: Quick Search -->
                    <div class="flex items-center gap-2">
                        <input v-model.trim="filters.q" @keyup.enter="applyFilters" type="text"
                            placeholder="ค้นหา..."
                            class="max-w-full px-3 py-2 border border-gray-300 rounded-md w-72 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                        <button @click="applyFilters"
                            class="px-4 py-2 text-white bg-blue-600 rounded-md cursor-pointer hover:bg-blue-700">
                            ค้นหา
                        </button>
                    </div>
                </div>

                <!-- Card -->
                <div class="bg-white border border-gray-300 rounded-lg shadow-sm">
                    <div class="flex items-center justify-between px-4 py-4 border-b border-gray-200 sm:px-6">
                        <div class="text-sm text-gray-600">
                            หน้าที่ {{ pagination.page }} / {{ pagination.totalPages || 1 }} • ทั้งหมด {{ pagination.total }} รายงาน
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
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">ประเภท / หมวดหมู่</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">รายละเอียด</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">ผู้รายงาน</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">ผู้ถูกรายงาน</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">สร้างเมื่อ</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">สถานะ</th>
                                    <th class="px-4 py-3 text-xs font-medium text-left text-gray-500 uppercase">การกระทำ</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr v-for="report in reports" :key="report.id" class="transition-opacity hover:bg-gray-50">
                                    <td class="px-4 py-3 text-sm text-gray-900">
                                        <div class="font-medium">{{ report.type || '-' }}</div>
                                        <div class="text-xs text-gray-500">{{ report.category || '-' }}</div>
                                    </td>
                                    <td class="px-4 py-3 text-sm text-gray-500 max-w-xs truncate" :title="report.description">
                                        {{ report.description || '-' }}
                                    </td>
                                    <td class="px-4 py-3 text-sm text-gray-900">
                                        {{ report.reporterName || '-' }}
                                    </td>
                                    <td class="px-4 py-3 text-sm text-gray-900">
                                        {{ report.targetUser ? `${report.targetUser.firstName} ${report.targetUser.lastName}` : '-' }}
                                    </td>
                                    <td class="px-4 py-3 text-sm text-gray-500">
                                        {{ formatDate(report.createdAt) }}
                                    </td>
                                    <td class="px-4 py-3 text-sm">
                                        <span class="inline-flex items-center px-2 py-1 text-xs font-medium rounded-full" :class="statusBadge(report.status)">
                                            {{ statusLabel(report.status) }}
                                        </span>
                                    </td>
                                    <td class="px-4 py-3 text-sm">
                                        <button @click="openViewModal(report)" class="px-3 py-1 text-xs text-blue-600 bg-blue-50 border border-blue-200 rounded hover:bg-blue-100 shadow-sm" title="ตรวจสอบรายงาน">
                                            ตรวจสอบรายงาน
                                        </button>
                                    </td>
                                </tr>
                                <tr v-if="!reports.length">
                                    <td colspan="7" class="px-4 py-10 text-center text-gray-500">ไม่มีข้อมูลรายงาน</td>
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
        <div v-if="showViewModal && viewingReport" class="fixed inset-0 z-[1050] flex items-center justify-center p-4 bg-black/50" @click.self="closeViewModal">
            <div class="modal-popup w-full max-w-2xl bg-white rounded-lg shadow-xl overflow-hidden flex flex-col max-h-[90vh]">
                <!-- Header -->
                <div class="flex items-center justify-between px-6 py-4 border-b border-gray-200 bg-gray-50">
                    <h3 class="text-lg font-medium text-gray-900">ตรวจสอบรายงาน</h3>
                    <button @click="closeViewModal" class="text-gray-400 hover:text-gray-500 focus:outline-none">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                
                <!-- Body -->
                <div class="p-6 overflow-y-auto flex-1">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Left Col -->
                        <div class="space-y-4">
                            <div>
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">ประเภท / หมวดหมู่</h4>
                                <div class="text-sm font-medium text-gray-900">{{ viewingReport.type || '-' }} / {{ viewingReport.category || '-' }}</div>
                            </div>
                            
                            <div>
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">ผู้รายงาน</h4>
                                <div class="text-sm text-gray-900">{{ viewingReport.reporterName || '-' }}</div>
                                <div class="text-xs text-gray-500">{{ viewingReport.reporterEmail || '-' }}</div>
                            </div>

                            <div v-if="viewingReport.targetUser">
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">ผู้ถูกรายงาน</h4>
                                <div class="text-sm text-gray-900">{{ viewingReport.targetUser.firstName }} {{ viewingReport.targetUser.lastName }}</div>
                                <div class="text-xs text-gray-500">{{ viewingReport.targetUser.email || '-' }}</div>
                            </div>
                            
                            <div>
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">สถานะปัจจุบัน</h4>
                                <span class="inline-flex items-center px-2 py-1 text-xs font-medium rounded-full" :class="statusBadge(viewingReport.status)">
                                    {{ statusLabel(viewingReport.status) }}
                                </span>
                            </div>
                        </div>

                        <!-- Right Col -->
                        <div class="space-y-4">
                           <div>
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">สร้างเมื่อ</h4>
                                <div class="text-sm text-gray-900">{{ formatDate(viewingReport.createdAt) }}</div>
                            </div>
                            
                            <div v-if="viewingReport.routeId">
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">เส้นทางอ้างอิง</h4>
                                <div class="text-sm text-blue-600 hover:underline cursor-pointer" @click="goToRoute(viewingReport.routeId)">
                                    ดูเส้นทาง (#{{ viewingReport.routeId.substring(0,8) }})
                                </div>
                            </div>
                            
                            <div v-if="viewingReport.bookingId">
                                <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">การจองอ้างอิง</h4>
                                <div class="text-sm text-blue-600 hover:underline cursor-pointer" @click="goToBooking(viewingReport.bookingId)">
                                    ดูการจอง (#{{ viewingReport.bookingId.substring(0,8) }})
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-6">
                        <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">รายละเอียด</h4>
                        <div class="bg-gray-50 p-4 rounded-md text-sm text-gray-800 whitespace-pre-wrap border border-gray-200">{{ viewingReport.description || '-' }}</div>
                    </div>

                    <div v-if="viewingReport.images && viewingReport.images.length > 0" class="mt-6">
                        <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">รูปภาพแนบ</h4>
                        <div class="flex flex-wrap gap-2">
                            <a v-for="(img, idx) in viewingReport.images" :key="idx" :href="img" target="_blank" class="block">
                                <img :src="img" class="h-24 w-auto rounded border border-gray-200 object-cover hover:opacity-80 transition" alt="Report Attachment" />
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Footer Actions -->
                <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex flex-wrap items-center justify-between gap-3">
                    <div class="flex items-center gap-2">
                         <button @click="askDelete(viewingReport)" class="px-4 py-2 text-sm font-medium text-red-600 bg-white border border-red-200 rounded-md hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 shadow-sm">
                            ลบรายงานนี่
                        </button>
                    </div>
                    
                    <div class="flex items-center gap-2">
                        <button v-if="viewingReport.status !== 'RESOLVED' && viewingReport.status !== 'REJECTED'" @click="updateStatus(viewingReport, 'REJECTED')" class="px-4 py-2 text-sm font-medium text-white bg-red-600 hover:bg-red-700 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                            ปฏิเสธ
                        </button>
                        <button v-if="viewingReport.status === 'PENDING'" @click="updateStatus(viewingReport, 'APPROVED')" class="px-4 py-2 text-sm font-medium text-white bg-amber-500 hover:bg-amber-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                            กำลังตรวจสอบ
                        </button>
                        <button v-if="viewingReport.status === 'APPROVED' || viewingReport.status === 'PENDING'" @click="updateStatus(viewingReport, 'RESOLVED')" class="px-4 py-2 text-sm font-medium text-white bg-green-600 hover:bg-green-700 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                            ตอบรับการรายงาน
                        </button>
                        <button @click="closeViewModal" class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 shadow-sm ml-2">
                            ปิดหน้าต่าง
                        </button>
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

const filters = reactive({
    q: ''
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
        const token = useCookie('token').value || (process.client ? localStorage.getItem('token') : '')
        
        const params = new URLSearchParams()
        params.append('page', pagination.page)
        params.append('limit', pagination.limit)
        if (filters.q) params.append('q', filters.q)

        const res = await fetch(`${config.public.apiBase}/reports/admin?${params.toString()}`, {
            headers: {
                Accept: 'application/json',
                ...(token ? { Authorization: `Bearer ${token}` } : {})
            },
            credentials: 'include'
        })
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
    } finally {
        isLoading.value = false
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
    showViewModal.value = true
}

function closeViewModal() {
    showViewModal.value = false
    // viewingReport.value = null
}

async function updateStatus(report, status) {
    try {
        const token = useCookie('token').value || (process.client ? localStorage.getItem('token') : '')
        const res = await fetch(`${config.public.apiBase}/reports/admin/${report.id}`, {
            method: 'PATCH',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
                ...(token ? { Authorization: `Bearer ${token}` } : {})
            },
            body: JSON.stringify({ status }),
            credentials: 'include'
        })

        const body = await res.json()
        if (!res.ok) throw new Error(body?.message || `Request failed: ${res.status}`)

        // Update locally in list and modal
        const index = reports.value.findIndex(r => r.id === report.id)
        if (index !== -1) {
             reports.value[index].status = status
        }
        if (viewingReport.value && viewingReport.value.id === report.id) {
             viewingReport.value.status = status
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
        // if user resolved or rejected, might want to close the modal
        // if (status === 'RESOLVED' || status === 'REJECTED') {
        //   closeViewModal()
        // }
    } catch (err) {
        console.error(err)
        toast.error('ไม่สามารถอัปเดตสถานะได้', err.message)
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
    if (s === 'RESOLVED') return 'bg-green-100 text-green-700'
    if (s === 'APPROVED') return 'bg-amber-100 text-amber-700'
    if (s === 'REJECTED') return 'bg-red-100 text-red-700'
    return 'bg-gray-100 text-gray-700'
}

function statusLabel(s) {
    const map = {
        PENDING: 'รอดำเนินการ',
        APPROVED: 'กำลังตรวจสอบ',
        REJECTED: 'ปฏิเสธแล้ว',
        RESOLVED: 'ตอบรับแล้ว',
    }
    return map[s] || 'รอดำเนินการ'
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
