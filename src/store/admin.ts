import { create } from 'zustand'

type AdminStore = {
  isMobile: boolean
  asideCollapsed: boolean
  toggleAsideCollapsed: VoidFunction
  init: () => VoidFunction
}

export const useAdmin = create<AdminStore>((set, get) => ({
  isMobile: document.body.clientWidth < 768,
  asideCollapsed: false,
  init() {
    function onResize() {
      set({ isMobile: document.body.clientWidth < 768 })
    }
    window.addEventListener('resize', onResize)
    return () => {
      window.removeEventListener('resize', onResize)
    }
  },
  toggleAsideCollapsed() {
    set({ asideCollapsed: !get().asideCollapsed })
  }
}))
