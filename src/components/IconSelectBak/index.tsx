import './index.scss'

import Icon from '@ant-design/icons'
import * as Icons from '@ant-design/icons'
import { ProFormText } from '@ant-design/pro-components'
import { Button, Popover } from 'antd'

export type IconSelectProps = {
  value: string
  onChange: (item: string) => void
}

const iconList = Object.keys(Icons).filter(
  item => typeof (Icons as any)[item] === 'object' && item !== 'default' && item !== 'IconProvider'
)

const IconSelect = ({ value, onChange }: IconSelectProps) => {
  return (
    <Popover
      content={
        <div className="flex items-center w-xl h-md overflow-y-auto flex-wrap">
          {iconList.map((item, index) => (
            <Button
              className="mr-2 mb-2"
              key={index}
              icon={<Icon key={index} component={(Icons as any)[item]} />}
              onClick={() => onChange(item)}
            />
          ))}
        </div>
      }
      title="选择图标"
      placement="bottom"
    >
      <div>
        {/* <div className="mr-1">
            {value ? (
              <Button icon={<Icon component={(Icons as any)[value]} />}></Button>
            ) : (
              <Button />
            )}
          </div> */}
        <ProFormText
          width="md"
          name="icon"
          label="图标"
          placeholder="点击选择图标"
          // disabled
          onReset={() => onChange('')}
          fieldProps={{
            prefix: value ? <Icon component={(Icons as any)[value]} /> : <></>
          }}
        />
      </div>
    </Popover>
  )
}

export default IconSelect
