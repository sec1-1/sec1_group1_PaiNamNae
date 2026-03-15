<template>
	<div class="min-h-[calc(100vh-64px)] bg-slate-50">
		<div class="px-4 py-8 mx-auto max-w-4xl sm:px-6 lg:px-8">
			<div class="mb-6">
				<h1 class="text-2xl font-bold text-gray-900 sm:text-3xl">รายงานระบบ</h1>
				<p class="mt-2 text-sm text-gray-600 sm:text-base">
					สำหรับผู้โดยสารและคนขับ แจ้งปัญหาทั่วไปของระบบเพื่อให้ทีมงานตรวจสอบ
				</p>
			</div>

			<div class="p-6 bg-white border border-gray-200 shadow-sm rounded-2xl sm:p-8">
				<div class="flex flex-wrap items-center gap-2 mb-6">
					<span class="text-sm font-medium text-gray-700">ประเภทผู้รายงาน:</span>
					<span
						class="inline-flex items-center px-3 py-1 text-xs font-semibold rounded-full"
						:class="reportType === 'DRIVER' ? 'bg-indigo-100 text-indigo-700' : 'bg-blue-100 text-blue-700'"
					>
						{{ reportTypeLabel }}
					</span>
				</div>

				<div class="space-y-5">
					<div>
						<label class="block mb-2 text-sm font-semibold text-gray-700">หัวข้อปัญหา (เลือกได้มากกว่า 1 ข้อ)</label>
						<div class="grid grid-cols-1 gap-2 sm:grid-cols-2">
							<button
								v-for="opt in categoryOptions"
								:key="opt.value"
								type="button"
								class="w-full px-3 py-2 text-sm text-left border rounded-lg transition"
								:class="selectedCategories.includes(opt.value)
									? 'border-blue-500 bg-blue-50 text-blue-700 font-semibold'
									: 'border-gray-200 bg-gray-50 text-gray-700 hover:border-blue-300 hover:bg-blue-50/40'"
								@click="toggleCategory(opt.value)"
							>
								{{ opt.label }}
							</button>
						</div>
						<div v-if="!selectedCategories.length" class="mt-2 text-xs text-gray-500">โปรดเลือกอย่างน้อย 1 หมวดหมู่</div>
						<div v-else class="mt-2 text-xs text-gray-500">เลือกแล้ว {{ selectedCategories.length }} หมวดหมู่</div>
					</div>

					<div>
						<label class="block mb-2 text-sm font-semibold text-gray-700">รายละเอียดเหตุการณ์</label>
						<textarea
							v-model="description"
							rows="5"
							maxlength="501"
							class="w-full p-4 transition-all border border-gray-300 rounded-xl focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
							placeholder="โปรดระบุปัญหาที่พบอย่างละเอียดเพื่อให้ทีมงานตรวจสอบได้รวดเร็วขึ้น"
						></textarea>
						<div class="flex justify-between mt-1 text-xs text-gray-500">
							<span>อย่างน้อย 5 ตัวอักษร</span>
							<span>{{ description.length }} / 501</span>
						</div>
					</div>

					<div>
						<label class="block mb-2 text-sm font-semibold text-gray-700">
							หลักฐานรูป วิดีโอ หรือเสียง (ถ้ามี)
							<span class="font-normal text-gray-400">(สูงสุดอย่างละ 3 ไฟล์, ไฟล์ละไม่เกิน 50MB)</span>
						</label>

						<div class="flex flex-wrap gap-4">
							<label
								v-if="images.length < MAX_IMAGES || videos.length < MAX_VIDEOS || audios.length < MAX_AUDIOS"
								class="flex flex-col items-center justify-center w-24 h-24 transition border-2 border-dashed border-gray-300 cursor-pointer rounded-2xl hover:border-blue-500 hover:bg-blue-50"
							>
								<span class="text-2xl text-gray-400">+</span>
								<span class="text-[10px] font-semibold tracking-wide text-gray-500 uppercase">เพิ่มไฟล์</span>
								<input
									type="file"
									class="hidden"
									multiple
									accept="image/*,video/*,audio/*"
									@change="handleFiles"
								/>
							</label>

							<div v-for="(img, idx) in images" :key="`img-${idx}`" class="relative">
								<img :src="img.url" class="object-cover w-24 h-24 border border-gray-200 shadow-sm rounded-2xl" />
								<button
									type="button"
									class="absolute flex items-center justify-center w-6 h-6 text-xs text-white transition bg-red-500 rounded-full -top-2 -right-2 hover:bg-red-600"
									@click="removeImage(idx)"
								>
									x
								</button>
							</div>

							<div v-for="(vid, idx) in videos" :key="`vid-${idx}`" class="relative">
								<video :src="vid.url" controls class="object-cover w-24 h-24 border border-gray-200 shadow-sm rounded-2xl"></video>
								<button
									type="button"
									class="absolute flex items-center justify-center w-6 h-6 text-xs text-white transition bg-red-500 rounded-full -top-2 -right-2 hover:bg-red-600"
									@click="removeVideo(idx)"
								>
									x
								</button>
							</div>

							<div v-for="(audio, idx) in audios" :key="`audio-${idx}`" class="relative p-2 bg-white border border-gray-200 shadow-sm rounded-2xl w-56">
								<div class="mb-1 text-xs font-medium text-gray-600 truncate">{{ audio.file.name }}</div>
								<audio :src="audio.url" controls class="w-full"></audio>
								<button
									type="button"
									class="absolute flex items-center justify-center w-6 h-6 text-xs text-white transition bg-red-500 rounded-full -top-2 -right-2 hover:bg-red-600"
									@click="removeAudio(idx)"
								>
									x
								</button>
							</div>
						</div>
					</div>

					<div>
						<label class="block mb-2 text-sm font-semibold text-gray-700">ลิงก์ (ถ้ามี)</label>
						<div class="flex flex-col gap-2 sm:flex-row">
							<button
								type="button"
								class="px-4 py-2 text-sm font-medium text-blue-700 transition border border-blue-200 rounded-lg bg-blue-50 hover:bg-blue-100"
								@click="toggleLinkInput"
							>
								{{ showLinkInput ? 'ซ่อนช่องแนบลิงก์' : 'แนบลิงก์' }}
							</button>
							<input
								v-if="showLinkInput"
								v-model.trim="attachedLink"
								type="url"
								placeholder="https://example.com"
								class="flex-1 px-3 py-2 text-sm border border-gray-300 rounded-lg focus:border-blue-500 focus:ring-2 focus:ring-blue-100"
							/>
						</div>
						<p v-if="linkError" class="mt-1 text-xs text-red-600">{{ linkError }}</p>
					</div>
				</div>

				<div class="flex flex-col gap-3 pt-6 mt-6 border-t border-gray-200 sm:flex-row sm:justify-end">
					<button
						type="button"
						class="px-5 py-2.5 text-sm font-semibold text-gray-700 transition bg-gray-100 rounded-xl hover:bg-gray-200"
						@click="resetForm"
					>
						ล้างฟอร์ม
					</button>
					<button
						type="button"
						class="px-6 py-2.5 text-sm font-semibold text-white transition bg-blue-600 rounded-xl hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
						:disabled="isSubmitDisabled || isSubmitting"
						@click="submitSystemReport"
					>
						{{ isSubmitting ? 'กำลังส่ง...' : 'ส่งรายงานระบบ' }}
					</button>
				</div>
			</div>
		</div>
	</div>
</template>

<script setup>
import { computed, onBeforeUnmount, ref } from 'vue'
import { useAuth } from '~/composables/useAuth'
import { useToast } from '~/composables/useToast'

definePageMeta({ middleware: 'auth' })

const { user } = useAuth()
const { toast } = useToast()
const { $api } = useNuxtApp()

const selectedCategories = ref([])
const description = ref('')
const images = ref([])
const videos = ref([])
const audios = ref([])
const attachedLink = ref('')
const showLinkInput = ref(false)
const linkError = ref('')
const isSubmitting = ref(false)

const MAX_IMAGES = 3
const MAX_VIDEOS = 3
const MAX_AUDIOS = 3
const MAX_FILE_SIZE = 50 * 1024 * 1024
const MAX_COMMENT_LENGTH = 501

const categoryOptions = [
	{ value: 'APP_ISSUE', label: 'ปัญหาแอปพลิเคชัน' },
	{ value: 'ACCOUNT_ISSUE', label: 'ปัญหาบัญชีผู้ใช้' },
	{ value: 'TRIP_ISSUE', label: 'ปัญหาเกี่ยวกับทริป' },
	{ value: 'SAFETY_ISSUE', label: 'ความปลอดภัย' },
	{ value: 'OTHER', label: 'อื่นๆ' }
]

const uiCategoryToBackendCategory = {
	APP_ISSUE: 'OTHER',
	ACCOUNT_ISSUE: 'OTHER',
	TRIP_ISSUE: 'ROAD_ISSUE',
	SAFETY_ISSUE: 'SAFETY_ISSUE',
	OTHER: 'OTHER'
}

const reportType = computed(() => {
	if (user.value?.role === 'DRIVER') return 'DRIVER'
	if (user.value?.role === 'PASSENGER') return 'PASSENGER'
	return null
})

const reportTypeLabel = computed(() => {
	if (reportType.value === 'DRIVER') return 'คนขับ'
	if (reportType.value === 'PASSENGER') return 'ผู้โดยสาร'
	return 'ไม่รองรับ'
})

const isSubmitDisabled = computed(() => {
	const textLen = description.value.trim().length
	return !selectedCategories.value.length || textLen < 5 || textLen > MAX_COMMENT_LENGTH || !reportType.value
})

function clearAttachments() {
	images.value.forEach((it) => it.url && URL.revokeObjectURL(it.url))
	videos.value.forEach((it) => it.url && URL.revokeObjectURL(it.url))
	audios.value.forEach((it) => it.url && URL.revokeObjectURL(it.url))
	images.value = []
	videos.value = []
	audios.value = []
}

function resetForm() {
	selectedCategories.value = []
	description.value = ''
	attachedLink.value = ''
	showLinkInput.value = false
	linkError.value = ''
	clearAttachments()
}

function toggleCategory(categoryValue) {
	const idx = selectedCategories.value.indexOf(categoryValue)
	if (idx >= 0) {
		selectedCategories.value.splice(idx, 1)
		return
	}
	selectedCategories.value.push(categoryValue)
}

function toggleLinkInput() {
	showLinkInput.value = !showLinkInput.value
	if (!showLinkInput.value) {
		attachedLink.value = ''
		linkError.value = ''
	}
}

function isValidUrl(url) {
	try {
		const parsed = new URL(url)
		return parsed.protocol === 'http:' || parsed.protocol === 'https:'
	} catch {
		return false
	}
}

function handleFiles(e) {
	const files = Array.from(e.target.files || [])

	files.forEach((file) => {
		if (file.size > MAX_FILE_SIZE) {
			toast.error('ขนาดไฟล์ต้องไม่เกิน 50MB')
			return
		}

		if (file.type.startsWith('image/')) {
			if (images.value.length >= MAX_IMAGES) {
				toast.error(`เพิ่มรูปได้สูงสุด ${MAX_IMAGES} รูป`)
				return
			}
			images.value.push({ file, url: URL.createObjectURL(file) })
			return
		}

		if (file.type.startsWith('video/')) {
			if (videos.value.length >= MAX_VIDEOS) {
				toast.error(`เพิ่มวิดีโอได้สูงสุด ${MAX_VIDEOS} วิดีโอ`)
				return
			}
			videos.value.push({ file, url: URL.createObjectURL(file) })
			return
		}

		if (file.type.startsWith('audio/')) {
			if (audios.value.length >= MAX_AUDIOS) {
				toast.error(`เพิ่มเสียงได้สูงสุด ${MAX_AUDIOS} ไฟล์`)
				return
			}
			audios.value.push({ file, url: URL.createObjectURL(file) })
			return
		}

		toast.error('กรุณาเลือกไฟล์รูป วิดีโอ หรือเสียงเท่านั้น')
	})

	e.target.value = ''
}

function removeImage(index) {
	const item = images.value[index]
	if (item?.url) URL.revokeObjectURL(item.url)
	images.value.splice(index, 1)
}

function removeVideo(index) {
	const item = videos.value[index]
	if (item?.url) URL.revokeObjectURL(item.url)
	videos.value.splice(index, 1)
}

function removeAudio(index) {
	const item = audios.value[index]
	if (item?.url) URL.revokeObjectURL(item.url)
	audios.value.splice(index, 1)
}

async function submitSystemReport() {
	if (isSubmitDisabled.value) return

	if (description.value.trim().length > MAX_COMMENT_LENGTH) {
		toast.error('รายละเอียดต้องไม่เกิน 501 ตัวอักษร')
		return
	}

	if (attachedLink.value && !isValidUrl(attachedLink.value)) {
		linkError.value = 'กรุณากรอกลิงก์ให้ถูกต้อง (ต้องขึ้นต้นด้วย http:// หรือ https://)'
		return
	}
	linkError.value = ''

	isSubmitting.value = true
	try {
		const selectedCategoryLabels = categoryOptions
			.filter(opt => selectedCategories.value.includes(opt.value))
			.map(opt => opt.label)
		const primaryUiCategory = selectedCategories.value[0]
		const backendCategory = uiCategoryToBackendCategory[primaryUiCategory] || 'OTHER'

		const fd = new FormData()
		fd.append('type', reportType.value)
		fd.append('category', backendCategory)
		const detailWithCategories = `หมวดหมู่ที่เลือก: ${selectedCategoryLabels.join(', ')}\n\n${description.value.trim()}`
		const finalDescription = attachedLink.value
			? `${detailWithCategories}\n\nลิงก์: ${attachedLink.value}`
			: detailWithCategories
		fd.append('description', finalDescription)

		images.value.forEach((it) => {
			if (it?.file) fd.append('images', it.file)
		})

		videos.value.forEach((it) => {
			if (it?.file) fd.append('videos', it.file)
		})

		audios.value.forEach((it) => {
			if (it?.file) fd.append('audios', it.file)
		})

		await $api('/reports', {
			method: 'POST',
			body: fd
		})

		toast.success('ส่งรายงานสำเร็จ', 'ทีมงานจะตรวจสอบและอัปเดตสถานะให้เร็วที่สุด')
		resetForm()
	} catch (error) {
		toast.error('ไม่สามารถส่งรายงานได้', error?.data?.message || 'โปรดลองอีกครั้ง')
	} finally {
		isSubmitting.value = false
	}
}

onBeforeUnmount(() => {
	clearAttachments()
})
</script>
