<template>
    <section id="experience" class="experience">
        <div class="experience-container">
            <p class="subtitle">PERJALANAN KARIER</p>
            <h2>Pengalaman Kerja</h2>

            <p v-if="loading" class="message">
                Memuat data pengalaman kerja...
            </p>

            <p v-else-if="error" class="message">
                {{ error }}
            </p>

            <p v-else-if="experiences.length === 0" class="message">
                Belum ada data pengalaman kerja.
            </p>

            <div v-else class="experience-list">
                <article
                    v-for="item in experiences"
                    :key="item.id"
                    class="experience-card"
                >
                    <h3>{{ item.position }}</h3>

                    <p class="company">{{ item.company }}</p>

                    <p class="period">
                        {{ item.start_year }} -
                        {{ item.end_year || 'Sekarang' }}
                    </p>

                    <p v-if="item.description" class="description">
                        {{ item.description }}
                    </p>
                </article>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const experiences = ref([]);
const loading = ref(true);
const error = ref('');

onMounted(async () => {
    try {
        const response = await fetch('/api/experiences');

        if (!response.ok) {
            throw new Error('Gagal mengambil data pengalaman kerja.');
        }

        experiences.value = await response.json();
    } catch (err) {
        error.value = err.message;
    } finally {
        loading.value = false;
    }
});
</script>

<style scoped>
.experience {
    padding: 100px 10%;
    background: #f8f8f8;
}

.experience-container {
    max-width: 1100px;
    margin: auto;
}

.subtitle {
    font-size: 14px;
    font-weight: bold;
    letter-spacing: 2px;
    color: #777;
}

h2 {
    font-size: 40px;
    margin: 15px 0 30px;
}

.experience-list {
    display: grid;
    gap: 20px;
}

.experience-card {
    padding: 25px;
    background: white;
    border: 1px solid #eeeeee;
    border-radius: 6px;
}

.experience-card h3 {
    margin: 0 0 10px;
    font-size: 22px;
    color: #333;
}

.company {
    margin: 0 0 8px;
    font-weight: bold;
    color: #555;
}

.period {
    margin: 0 0 15px;
    font-size: 14px;
    color: #777;
}

.description {
    margin: 0;
    line-height: 1.8;
    color: #666;
}

.message {
    color: #666;
}

@media (max-width: 800px) {
    .experience {
        padding: 70px 6%;
    }

    h2 {
        font-size: 32px;
    }
}
</style>
