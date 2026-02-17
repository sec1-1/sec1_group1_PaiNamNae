import tailwindcssVite from "@tailwindcss/vite";

export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',

  devtools: { enabled: true },

  runtimeConfig: {
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE || "https://sec1-group1-painamnae.onrender.com/api/",
      googleMapsApiKey: process.env.NUXT_PUBLIC_GOOGLE_MAPS_API_KEY || ""
    },
  },

  devServer: {
    port: 3001,
  },

  plugins: ["~/plugins/api.client.js"],

  vite: {
    plugins: [tailwindcssVite()],
  },

  css: [
    '~/assets/css/input.css',
  ],
  build: {
    transpile: ['leaflet']
  },
});