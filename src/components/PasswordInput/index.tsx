import { LockOutlined } from '@ant-design/icons'
import { ProFormText } from '@ant-design/pro-components'
import { theme } from 'antd'
import type { SizeType } from 'antd/es/config-provider/SizeContext'
import type { ComponentProps } from 'react'

type PasswordProps = ComponentProps<typeof ProFormText.Password>

const PasswordInput = ({
  name = 'password',
  size,
  showIcon,
  showStatus = true,
  ...rest
}: PasswordProps & {
  name?: string
  size?: SizeType
  showIcon?: boolean
  showStatus?: boolean
}) => {
  const { token } = theme.useToken()
  return (
    <ProFormText.Password
      name={name}
      fieldProps={{
        size,
        prefix: showIcon ? <LockOutlined className={'prefixIcon'} /> : undefined,
        strengthText: '密码需要包含数字、字母和特殊字符，至少8位长。',
        statusRender: showStatus
          ? value => {
              const getStatus = () => {
                if (value && value.length > 12) {
                  return 'ok'
                }
                if (value && value.length > 6) {
                  return 'pass'
                }
                return 'poor'
              }
              const status = getStatus()
              if (status === 'pass') {
                return <div style={{ color: token.colorWarning }}>强度：中</div>
              }
              if (status === 'ok') {
                return <div style={{ color: token.colorSuccess }}>强度：强</div>
              }
              return <div style={{ color: token.colorError }}>强度：弱</div>
            }
          : undefined
      }}
      placeholder={'密码'}
      rules={[
        {
          required: true,
          message: '请输入密码！'
        }
      ]}
      {...rest}
    />
  )
}

export default PasswordInput
