import { defineConfig, type UserConfig } from 'unocss'

export default defineConfig({
  content: {
    filesystem: ['src/**/*.{ts,tsx}']
  },
  theme: {
    colors: {
      primary: '#246FEF'
    }
  }
}) as UserConfig
