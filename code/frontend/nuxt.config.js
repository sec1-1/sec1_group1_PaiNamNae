import tailwindcssVite from "@tailwindcss/vite";

export default defineNuxtConfig({
  ssr: false,

  app: {
    head: {
      link: [
        {
          rel: 'stylesheet',
          href: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css'
        }
      ]
    }
  },

  nitro: {
    prerender: {
      crawlLinks: true,
    }
  },

  // compatibility settings – explicit future key avoids Nuxt bug
  future: {
    // default version, ensure object is defined so schema resolution doesn't fail
    compatibilityVersion: 3
  },

  compatibilityDate: '2024-04-03',

  devtools: { enabled: true },

  runtimeConfig: {
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE || "http://localhost:3000/api",
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