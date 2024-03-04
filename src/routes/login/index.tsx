import { LockOutlined, MobileOutlined, UserOutlined } from '@ant-design/icons'
import { LoginForm, ProFormCaptcha, ProFormCheckbox, ProFormText } from '@ant-design/pro-components'
import { message, Tabs } from 'antd'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

import { client } from '@/api'
import PasswordInput from '@/components/PasswordInput'
import AuthLayout from '@/layouts/AuthLayout'
import { LoginType, useAuth } from '@/store/auth'

const Login = () => {
  const { login } = useAuth()
  const navigate = useNavigate()
  const [loginType, setLoginType] = useState<LoginType>(LoginType.Password)
  const onLogin = async (values: { username: string; password: string }) => {
    const [success] = await login(loginType, values)
    if (success) {
      navigate('/')
    }
  }
  return (
    <AuthLayout>
      <div className="flex flex-col items-center justify-center">
        <LoginForm
          // logo={
          //   <img src="https://www.fireboom.io/images/logo.png" />
          // }
          title="Fireboom"
          subTitle="前端变全栈，后端不搬砖"
          // actions={}
          onFinish={onLogin}
          initialValues={{
            rememberMe: true
          }}
        >
          <Tabs
            centered
            activeKey={loginType}
            items={[
              { key: LoginType.Password, label: '账号密码登录' },
              { key: LoginType.Sms, label: '手机号登录' }
            ]}
            onChange={activeKey => setLoginType(activeKey as LoginType)}
          />
          {loginType === LoginType.Password && (
            <>
              <ProFormText
                name="username"
                fieldProps={{
                  size: 'large',
                  prefix: <UserOutlined className={'prefixIcon'} />
                }}
                placeholder={'用户名'}
                rules={[
                  {
                    required: true,
                    message: '请输入用户名!'
                  }
                ]}
              />
              <PasswordInput size="large" showIcon showStatus={false} />
            </>
          )}
          {loginType === LoginType.Sms && (
            <>
              <ProFormText
                fieldProps={{
                  size: 'large',
                  prefix: <MobileOutlined className={'prefixIcon'} />
                }}
                name="mobile"
                placeholder={'手机号'}
                rules={[
                  {
                    required: true,
                    message: '请输入手机号！'
                  },
                  {
                    pattern: /^1\d{10}$/,
                    message: '手机号格式错误！'
                  }
                ]}
              />
              <ProFormCaptcha
                fieldProps={{
                  size: 'large',
                  prefix: <LockOutlined className={'prefixIcon'} />
                }}
                captchaProps={{
                  size: 'large'
                }}
                placeholder={'请输入验证码'}
                captchaTextRender={(timing, count) => {
                  if (timing) {
                    return `${count} ${'获取验证码'}`
                  }
                  return '获取验证码'
                }}
                phoneName="mobile"
                name="captcha"
                rules={[
                  {
                    required: true,
                    message: '请输入验证码！'
                  }
                ]}
                onGetCaptcha={async phone => {
                  const { error } = await client.mutate({
                    operationName: 'user/casdoor/sendCode',
                    input: {
                      dest: phone
                    }
                  })
                  if (!error) {
                    message.success('验证码已发送')
                  } else {
                    return
                  }
                }}
              />
            </>
          )}
          <div
            style={{
              marginBlockEnd: 24
            }}
          >
            <ProFormCheckbox noStyle name="rememberMe">
              自动登录
            </ProFormCheckbox>
          </div>
        </LoginForm>
      </div>
    </AuthLayout>
  )
}

export default Login
