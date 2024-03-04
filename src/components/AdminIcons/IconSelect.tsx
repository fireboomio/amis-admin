import { ProFormText } from '@ant-design/pro-components'
import type { InputRef } from 'antd'
import { Button, Input, Popover, Tabs } from 'antd'
import { useEffect, useMemo, useRef, useState } from 'react'

import { useDisclosure } from '@/hooks'

import styles from './icon.module.css'
import SVGIcon from './SVGIcon'

export type IconSelectProps = {
  name?: string
  value: string
  onChange: (item: string | undefined) => void
}

const iconCategories = [
  {
    group: 'tabler',
    url: '',
    index: 'https://icons.fireboom.io/tabler/index.json',
    iconUrl: 'https://icons.fireboom.io/tabler/icons/{item}.svg'
  }
] as const
const iconH = 32 + 12
const iconsPerRow = 6
const rowsPerPage = 6
const indexCache: Record<string, string[]> = {}

const IconSelect = ({ name = 'icon', value, onChange }: IconSelectProps) => {
  const [opened, { close, open }] = useDisclosure()
  const [search, setSearch] = useState('')
  const [allIcons, setAllIcons] = useState<string[]>([])
  const [icons, setIcons] = useState<string[]>([])
  const [category, setCategory] = useState(iconCategories[0])
  const inputRef = useRef<InputRef>(null)
  const [originRenderStartIndex, setOriginRenderStartIndex] = useState(0)
  const renderStartIndex = Math.max(0, originRenderStartIndex - 3)

  const searchedIcons = useMemo(() => {
    if (search) {
      return icons.filter(item => item.includes(search))
    } else {
      return icons
    }
  }, [icons, search])
  const iconRows = Math.ceil(searchedIcons.length / iconsPerRow)
  const renderEndIndex = Math.min(iconRows, renderStartIndex + rowsPerPage + 3)

  useEffect(() => {
    if (opened && icons.length < allIcons.length && allIcons.length) {
      let i = icons.length
      // 分阶段设置，防止数组过大导致渲染变慢
      const end = Math.min(i + 200, allIcons.length)
      setIcons([...icons, ...allIcons.slice(i, end)])
    }
  }, [allIcons, icons, opened])

  useEffect(() => {
    if (!indexCache[category.group]?.length) {
      fetch('https://icons.fireboom.io/tabler/index.json')
        .then(resp => resp.json())
        .then(icons => {
          indexCache[category.group] = icons
          setAllIcons(icons)
        })
    } else {
      setAllIcons(indexCache[category.group])
    }
  }, [category])

  return (
    <Popover
      open={opened}
      onOpenChange={v => {
        if (v) {
          open()
          setTimeout(() => {
            inputRef.current?.focus()
          }, 1000)
        } else {
          close()
          setSearch('')
          setCategory(iconCategories[0])
        }
      }}
      trigger={['click']}
      content={
        <>
          <Input
            placeholder="搜索"
            allowClear
            ref={inputRef}
            value={search}
            onChange={e => setSearch(e.target.value)}
          />
          <Tabs
            activeKey={category.group}
            items={iconCategories.map(item => ({
              label: item.group,
              key: item.group,
              children: (
                <div
                  className="grid grid-cols-6 gap-3 h-66 overflow-y-auto w-85"
                  onScroll={e => {
                    setOriginRenderStartIndex(
                      Math.floor((e.target as HTMLDivElement).scrollTop / iconH)
                    )
                  }}
                >
                  {searchedIcons.map((item, index) => {
                    if (
                      index < renderStartIndex * iconsPerRow ||
                      index >= renderEndIndex * iconsPerRow
                    ) {
                      return <div className={styles.placeholder} key={index} />
                    }
                    const svgUrl = category.iconUrl.replace('{item}', item)
                    return (
                      <Button
                        className="mr-2 mb-2"
                        key={index}
                        icon={<SVGIcon url={svgUrl} />}
                        onClick={() => {
                          onChange(svgUrl)
                          close()
                        }}
                      />
                    )
                  })}
                </div>
              )
            }))}
            onChange={e => setCategory(iconCategories.find(item => item.group === e)!)}
          />
        </>
      }
      // title="选择图标(Alpha)"
      placement="bottom"
    >
      <div onClick={open}>
        <ProFormText
          width="md"
          name={name}
          label="图标"
          placeholder="点击选择图标"
          // disabled
          onReset={() => onChange(undefined)}
          fieldProps={{
            prefix: value ? <SVGIcon url={value} /> : <></>
          }}
        />
      </div>
    </Popover>
  )
}

export default IconSelect
