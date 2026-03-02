import tailwindcssVite from "@tailwindcss/vite";

export default defineNuxtConfig({
  ssr: false,
  nitro: {
    prerender: {
      crawlLinks: true,
    }
  },
  compatibilityDate: '2024-04-03',

  devtools: { enabled: true },

  runtimeConfig: {
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE || "http://localhost:3000/api/",
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