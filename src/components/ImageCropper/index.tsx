import 'cropperjs/dist/cropper.css'

import type { MutableRefObject } from 'react'
import { useEffect, useRef, useState } from 'react'
import type { ReactCropperElement } from 'react-cropper'
import Cropper from 'react-cropper'

export type ImageCropperActions = {
  getCanvas: () => HTMLCanvasElement
}

export interface ImageCropperProps {
  image?: string | File
  aspectRatio?: number
  actionRef?: MutableRefObject<ImageCropperActions | undefined>
  onChange?: (previewUrl: string) => void
  // toDataURL 第一个参数
  outputType?: string
  // 质量
  quality?: number
  // 初始裁剪区比例
  autoCropArea?: number
}

const ImageCropper = ({
  image,
  aspectRatio,
  actionRef,
  onChange,
  outputType,
  quality
}: ImageCropperProps) => {
  const [src, setSrc] = useState<string>(typeof image === 'string' ? image : '')
  const cropperRef = useRef<ReactCropperElement>(null)

  const onCrop = () => {
    const cropper = cropperRef.current!.cropper
    onChange?.(cropper.getCroppedCanvas().toDataURL(outputType, quality))
  }

  useEffect(() => {
    if (image instanceof File) {
      const reader = new FileReader()
      reader.onload = () => {
        setSrc(reader.result as string)
        // cropperRef.current!.cropper.replace(reader.result as string);
      }
      reader.readAsDataURL(image)
    }
  }, [image])

  useEffect(() => {
    if (actionRef) {
      actionRef.current = {
        getCanvas: () => cropperRef.current!.cropper.getCroppedCanvas()
      }
    }
  }, [actionRef])

  return (
    <Cropper
      src={src}
      className="w-full h-full"
      viewMode={1}
      // Cropper.js options
      aspectRatio={aspectRatio}
      guides={false}
      crop={onCrop}
      autoCropArea={1}
      ref={cropperRef}
    />
  )
}

export default ImageCropper
