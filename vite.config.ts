import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

import react from '@vitejs/plugin-react-swc'
import UnoCSS from 'unocss/vite'
// import postcssNested from 'postcss-nested'
import { defineConfig } from 'vite'
import MonacoEditorPlugin from 'vite-plugin-monaco-editor-new'
import Pages from 'vite-plugin-pages'
import svgr from 'vite-plugin-svgr'

const path = fileURLToPath(new URL(import.meta.url))
const root = dirname(path)

// https://vitejs.dev/config/
export default defineConfig({
  root,
  resolve: {
    alias: {
      '@': resolve(root, 'src')
    }
  },
  // css: {
  //   postcss: {
  //     plugins: [postcssNested]
  //   }
  // },
  server: {
    port: 8080,
    proxy: {
      // 测试服地址：https://test.admin.enjoyfreetalk.com
      '/auth': 'http://localhost:9991',
      '/operations': 'http://localhost:9991',
      '/s3': 'http://localhost:9991'
    }
  },
  plugins: [
    react(),
    svgr(),
    Pages({
      extensions: ['tsx'],
      exclude: ['**/components/**/*.*', '**/blocks/**/*.*', '**/hooks/**/*.*'],
      routeStyle: 'next',
      importMode: 'async',
      dirs: 'src/routes',
      resolver: 'react'
    }),
    UnoCSS(),
    MonacoEditorPlugin({})
  ],
  optimizeDeps: {
    include: [
      '@ant-design/icons',
      '@ant-design/pro-components',
      'amis',
      'amis-editor',
      'copy-to-clipboard',
      'react',
      'react-dom',
      'react-router-dom'
    ]
  }
})
