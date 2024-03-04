import type { SVGAttributes } from 'react'
import { useEffect, useRef } from 'react'

interface SVGIconProps {
  url: string
}

const iconCache: Record<string, string> = {}

const SVGIcon = ({ url, ...props }: SVGIconProps & SVGAttributes<SVGSVGElement>) => {
  const svgRef = useRef<SVGSVGElement>(null)
  function renderDOM(svg: string) {
    const parser = new DOMParser()
    const doc = parser.parseFromString(svg, 'image/svg+xml')
    for (const attr of doc.documentElement.attributes) {
      if (['width', 'height'].includes(attr.name) && props[attr.name as 'width' | 'height']) {
        break
      }
      svgRef.current!.setAttribute(attr.name, attr.value)
    }
    if (props.className) {
      svgRef.current!.classList.add(...props.className.split(' '))
    }
    svgRef.current!.innerHTML = doc.documentElement.innerHTML
  }

  useEffect(() => {
    if (iconCache[url]) {
      return renderDOM(iconCache[url])
    }
    fetch(url)
      .then(res => res.text())
      .then(svg => {
        iconCache[url] = svg
        renderDOM(svg)
      })
  }, [url])

  return <svg ref={svgRef} {...props} />
}

export default SVGIcon
