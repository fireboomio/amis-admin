import { UserOutlined } from '@ant-design/icons'
import { ModalForm, ProForm } from '@ant-design/pro-components'
import { Avatar, Card, Col, Divider, Menu, message, Row } from 'antd'
import { useEffect } from 'react'
import { Outlet, useLocation, useNavigate } from 'react-router-dom'

import { client } from '@/api'
import AvatarEditor from '@/components/AvatarEditor'
import { Path } from '@/constants'
import { useAuth } from '@/store/auth'

const ProfileLayout = () => {
  const { user } = useAuth()
  const location = useLocation()
  const navigate = useNavigate()
  const {
    computed: { avatar, username },
    updateMyInfo
  } = useAuth()

  const updateMyAvatar = async ({ avatar }: { avatar: string }) => {
    const blob = await fetch(avatar).then(resp => resp.blob())
    const file = new File([blob!], `avatar.jpg`)
    const fileList = new DataTransfer()
    fileList.items.add(file)
    const resp = await client.uploadFiles({
      files: fileList.files,
      appendEndpoint: true,
      provider: 'tengxunyun',
      directory: `avatar/${user!.id}`
    })
    if (resp.fileKeys.length) {
      const avatar = resp.fileKeys[0]
      if (await updateMyInfo({ avatar })) {
        return true
      }
    } else {
      message.error('图片上传失败')
    }
  }

  useEffect(() => {
    if (location.pathname === Path.Profile) {
      navigate(Path.ProfileBasic, { replace: true })
    }
  }, [location, navigate])

  return (
    <Row gutter={[24, 24]}>
      <Col xxl={4} xl={6}>
        <Card>
          <div className="text-center">
            <ModalForm<{ avatar: string }>
              title="修改头像"
              trigger={
                <Avatar
                  className="cursor-pointer"
                  src={avatar || undefined}
                  size={80}
                  icon={<UserOutlined />}
                  alt="头像"
                />
              }
              initialValues={user || undefined}
              onFinish={updateMyAvatar}
            >
              <ProForm.Item name="avatar" rules={[{ required: true }]} noStyle>
                <AvatarEditor />
              </ProForm.Item>
            </ModalForm>
            <p className="mt-10 mb-5">{username}</p>
          </div>
          <Divider />
          <Menu
            selectedKeys={[location.pathname]}
            items={[
              {
                key: Path.ProfileBasic,
                label: '基本信息',
                onClick: () => navigate(Path.ProfileBasic)
              },
              {
                key: Path.ProfileSecurity,
                label: '账号安全',
                onClick: () => navigate(Path.ProfileSecurity)
              }
            ]}
          />
        </Card>
      </Col>
      <Col xxl={20} xl={18}>
        <Outlet />
      </Col>
    </Row>
  )
}

export default ProfileLayout
