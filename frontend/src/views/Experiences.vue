<template>
  <div>
    <h1>Pengalaman</h1>

    <div v-if="loading">
      Memuat data...
    </div>

    <div v-else-if="error">
      {{ error }}
    </div>

    <div v-else>
      <div
        v-for="experience in experiences"
        :key="experience.id"
      >
        <h2>{{ experience.position }}</h2>

        <p>
          <strong>{{ experience.company }}</strong>
        </p>

        <p>{{ experience.description }}</p>

        <p>
          {{ experience.start_year }}
          -
          {{ experience.end_year ?? 'Sekarang' }}
        </p>

        <hr>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const experiences = ref([])
const loading = ref(true)
const error = ref('')

onMounted(async () => {
    try {
        const response = await fetch(
            `${import.meta.env.VITE_API_URL}/api/experiences`
        )

        if (!response.ok) {
            throw new Error('Gagal mengambil data pengalaman.')
        }

        experiences.value = await response.json()
    } catch (err) {
        error.value = err.message
    } finally {
        loading.value = false
    }
})
</script>