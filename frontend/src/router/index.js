import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Experiences from '../views/Experiences.vue'

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',
            name: 'home',
            component: Home,
        },
        {
            path: '/experiences',
            name: 'experiences',
            component: Experiences,
        },
    ],
})

export default router