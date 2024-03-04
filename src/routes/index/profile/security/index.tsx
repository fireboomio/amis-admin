import { ProForm, ProFormDependency, ProFormText } from '@ant-design/pro-components'
import { Card, Col, Row, Space } from 'antd'

import PasswordInput from '@/components/PasswordInput'
import { useAuth } from '@/store/auth'

const ProfileSecurity = () => {
  const { updateMyPassword } = useAuth()

  const updatePassword = async (values: { password: string; confirm: string }) => {
    await updateMyPassword(values.password)
  }

  return (
    <Card title="修改密码">
      <ProForm
        layout="horizontal"
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 8 }}
        onFinish={updatePassword}
        submitter={{
          render(props, dom) {
            return (
              <Row>
                <Col span={14} offset={4}>
                  <Space>{dom}</Space>
                </Col>
              </Row>
            )
          }
        }}
      >
        <PasswordInput label="新密码" />
        <ProFormDependency name={['password']}>
          {({ password }) => {
            return (
              <ProFormText.Password
                name="confirm"
                label="确认密码"
                rules={[
                  { required: true },
                  () => ({
                    validator(_, value) {
                      if (!value || password === value) {
                        return Promise.resolve()
                      }
                      return Promise.reject(new Error('两次输入密码不一致'))
                    }
                  })
                ]}
              />
            )
          }}
        </ProFormDependency>
      </ProForm>
    </Card>
  )
}

export default ProfileSecurity
