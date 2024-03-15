import './index.scss'

import { UploadOutlined } from '@ant-design/icons'
import { Button, Upload } from 'antd'
import { useState } from 'react'

import type { ImageCropperProps } from '../ImageCropper'
import ImageCropper from '../ImageCropper'

export type AvatarEditorProps = {
  value?: ImageCropperProps['image']
  onChange?: ImageCropperProps['onChange']
}

const AvatarEditor = ({ value, onChange }: AvatarEditorProps) => {
  const [editingAvatarSrc, setEditingAvatarSrc] = useState<string | File>(value ?? '')
  const [previewAvatar, setPreviewAvatar] = useState<string | undefined>(
    typeof value === 'string' ? value : undefined
  )
  return (
    <div className="flex items-center">
      <div className="flex flex-col">
        <div className="bg-[#7f7f7f] w-[480px] h-[320px]">
          {editingAvatarSrc && (
            <ImageCropper
              image={editingAvatarSrc}
              quality={0.8}
              aspectRatio={1 / 1}
              autoCropArea={0.8}
              outputType="image/jpeg"
              onChange={v => {
                setPreviewAvatar(v)
                onChange?.(v)
              }}
            />
          )}
        </div>
        <Upload
          className="mt-2"
          accept="image/*"
          multiple={false}
          beforeUpload={() => false}
          fileList={[]}
          onChange={e => {
            const file = e.fileList?.[0]?.originFileObj
            if (file) {
              setEditingAvatarSrc(file)
            }
          }}
        >
          <Button icon={<UploadOutlined />}>更改图片</Button>
        </Upload>
      </div>
      <div className="h-[120px] w-[120px] mb-[44px] ml-6 flex items-center justify-center">
        {previewAvatar && (
          <img src={previewAvatar} className="rounded-[120px] h-full w-full shadow" alt="preview" />
        )}
      </div>
    </div>
  )
}

export default AvatarEditor
