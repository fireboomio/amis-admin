import { ProForm, ProFormText } from '@ant-design/pro-components'
import { Card, Col, Row, Space } from 'antd'

import { useAuth } from '@/store/auth'

const BasicInfo = () => {
  const { user, updateMyInfo } = useAuth()
  return (
    <Card>
      <ProForm
        layout="horizontal"
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 8 }}
        initialValues={user || undefined}
        onFinish={updateMyInfo}
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
        <ProFormText name="name" label="名称" placeholder="请输入名称" required />
      </ProForm>
    </Card>
  )
}

export default BasicInfo
