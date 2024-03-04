import { useState } from 'react'

export function useDisclosure(defaultValue = false) {
  const [opened, setOpened] = useState<boolean>(defaultValue)
  const open = () => setOpened(true)
  const close = () => setOpened(false)
  const toggle = () => setOpened(!opened)
  return [opened, { open, close, toggle, set: setOpened }] as const
}
