module.exports = {
  /*
  ** Headers of the page
  */
  head: {
    title: 'vue-frontend',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'authentication trial' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  /*
  ** Customize the progress bar color
  */
  loading: { color: '#3B8070' },
  /*
  ** Build configuration
  */
  server: {
    port: 8000, // default: 3000
    host: '0.0.0.0', // default: localhost
  },
  modules: [
    '@nuxtjs/vuetify',
    '@nuxtjs/axios',
    '@nuxtjs/auth'
  ],
  auth: {
    endpoints: {
      login:  { url: '/users/sign_in' },
      logout: { url: '/users/sign_out', method: 'delete' },
      user:   { url: '/users/current' }
    }
  },
  axios: {
    host: 'localhost',
    port: 3000,
    prefix: '/api/v1'
  },
  build: {
    /*
    ** Run ESLint on save
    */
    extend (config, { isDev, isClient }) {
      if (isDev && isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  }
}

