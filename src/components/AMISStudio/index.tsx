import './index.scss'
import 'amis-editor-core/lib/style.css'

import { type SchemaObject } from 'amis'
import { Editor, ShortcutKey } from 'amis-editor'
import { Select } from 'antd'
import { useEffect, useState } from 'react'

import IconH5Preview from '@/assets/h5-preview.svg?react'
import IconPCPreview from '@/assets/pc-preview.svg?react'
import { alert, copy, fetcher, injectAmisCss, notify, theme } from '@/utils/amis'

const host = `${window.location.protocol}//${window.location.host}`
const schemaUrl = `${host}/#/schema.json`

export type AMISStudioProps = {
  schema?: string | SchemaObject
  onSave: (schema?: SchemaObject) => Promise<void>
  onExit: () => void
}

const editorLanguages = [
  {
    label: '简体中文',
    value: 'zh-CN'
  },
  {
    label: 'English',
    value: 'en-US'
  }
]

const LangStoreKey = 'suda-i18n-locale'
const curLanguage = localStorage.getItem(LangStoreKey) || navigator.language || 'zh-CN'

const AMISStudio = ({ schema: originSchema, onSave, onExit }: AMISStudioProps) => {
  const [schema, setSchema] = useState<SchemaObject>(
    typeof originSchema === 'string' ? JSON.parse(originSchema) : originSchema
  )
  const [isMobile, setIsMobile] = useState(false)
  const [preview, setPreview] = useState(false)

  function changeLocale(value: string) {
    localStorage.setItem(LangStoreKey, value)
    window.location.reload()
  }

  const exit = () => {
    if (preview) {
      setPreview(false)
    }
    onExit()
  }

  const save = async () => {
    if (schema) {
      schema.type = 'page'
      await onSave(schema)
    }
  }

  const saveAndExit = async () => {
    await save()
    exit()
  }

  useEffect(() => {
    return injectAmisCss()
  }, [])

  return (
    <div className="amis-studio">
      <div className="studio-header">
        <div className="studio-title">amis 可视化编辑器</div>
        <div className="studio-view-mode-group-container">
          <div className="studio-view-mode-group">
            <div
              className={`studio-view-mode-btn editor-header-icon ${!isMobile ? 'is-active' : ''}`}
              onClick={() => {
                setIsMobile(false)
              }}
            >
              <IconH5Preview />
            </div>
            <div
              className={`studio-view-mode-btn editor-header-icon ${isMobile ? 'is-active' : ''}`}
              onClick={() => {
                setIsMobile(true)
              }}
            >
              <IconPCPreview />
            </div>
          </div>
        </div>

        <div className="studio-header-actions">
          <ShortcutKey />
          <Select
            className="margin-left-space"
            options={editorLanguages}
            value={curLanguage}
            allowClear={false}
            onChange={e => changeLocale(e)}
          />
          <div
            className={`header-action-btn m-1 ${preview ? 'primary' : ''}`}
            onClick={() => {
              setPreview(!preview)
            }}
          >
            {preview ? '编辑' : '预览'}
          </div>
          {!preview && (
            <>
              <div className={`header-action-btn exit-btn`} onClick={exit}>
                退出不保存
              </div>
              <div className={`header-action-btn`} onClick={saveAndExit}>
                保存并退出
              </div>
            </>
          )}
        </div>
      </div>
      <div className="studio-inner">
        <Editor
          theme={theme}
          preview={preview}
          isMobile={isMobile}
          value={schema}
          onChange={s => {
            setSchema(s)
          }}
          onPreview={() => {
            setPreview(true)
          }}
          data={{
            abc: () => {
              console.log(1)
            }
          }}
          onSave={save}
          className="is-fixed"
          $schemaUrl={schemaUrl}
          showCustomRenderersPanel={true}
          amisEnv={{
            // @ts-ignore
            fetcher,
            notify,
            alert,
            copy
          }}
        />
      </div>
    </div>
  )
}

export default AMISStudio
