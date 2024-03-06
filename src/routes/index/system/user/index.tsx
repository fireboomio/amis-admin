import { PlusOutlined, UserOutlined } from '@ant-design/icons'
import type { ActionType, ProColumns } from '@ant-design/pro-components'
import {
  DrawerForm,
  ModalForm,
  ProForm,
  ProFormCheckbox,
  ProFormText,
  ProTable
} from '@ant-design/pro-components'
import { Avatar, Button, Checkbox, Col, Form, message, Popconfirm, Row, Table } from 'antd'
import { useEffect, useRef, useState } from 'react'

import { client } from '@/api'
import type {
  admin_admin_role_userCreateManyInput,
  user__findManyResponseData_data
} from '@/api/models'
import AvatarEditor from '@/components/AvatarEditor'
import { replaceAntSearchFormValues } from '@/utils'
import timeFormat from '@/utils/timeFormat'

const UserPage = () => {
  const columns: ProColumns<user__findManyResponseData_data>[] = [
    {
      title: 'id',
      dataIndex: 'id',
      search: false
    },
    {
      title: '用户id',
      dataIndex: 'userId',
      width: 200,
      ellipsis: true,
      search: false
    },
    {
      title: '头像',
      dataIndex: 'avatar',
      valueType: 'avatar',
      search: false
    },
    {
      title: '创建时间',
      dataIndex: 'createdAt',
      search: false,
      width: 180,
      render: (_, record) => <div>{timeFormat(record.createdAt ?? '')}</div>
    },
    {
      title: '用户名',
      dataIndex: 'name'
    },
    {
      title: '手机号',
      dataIndex: 'phone'
    },
    {
      title: '微信UnionId',
      dataIndex: 'wxUnionid',
      search: false,
      ellipsis: true
    },
    {
      title: 'roles',
      dataIndex: 'roles',
      search: false,
      render: (_, record) => (
        <div>
          {record.roles.map(role => (
            <p key={role.name}>{role.name}</p>
          ))}
        </div>
      )
    },
    {
      title: '操作',
      valueType: 'option',
      key: 'option',
      fixed: 'right',
      render: (_, record) => [
        <Button
          key="editable"
          size="small"
          onClick={() => {
            record.password = ''
            drawerForm.setFieldsValue(record)
            setDrawerOpen(true)
            setIsEdit(true)
            setSelectedUserId(record.userId)
            setAvatar(record.avatar)
          }}
        >
          编辑
        </Button>,
        <Popconfirm
          key="deletePopConfirm"
          title="删除用户"
          description="确定删除此用户吗？"
          onConfirm={async () => {
            const { error } = await client.mutate({
              operationName: 'user/deleteMany',
              input: {
                userIds: [record.userId!]
              }
            })
            if (!error) {
              message.success('删除用户成功')
              actionRef.current?.reload()
            } else {
              message.error('删除用户失败')
            }
          }}
          okText="确定"
          cancelText="取消"
        >
          <Button size="small">删除</Button>
        </Popconfirm>,
        <Button
          key="bind"
          size="small"
          onClick={() => {
            getRolesByUserId(record.userId ?? '')
            setBindDrawerOpen(true)
            setSelectedUserId(record.userId)
          }}
        >
          绑定角色
        </Button>,
        <DrawerForm
          key="editPasswordDrawer"
          title="修改密码"
          resize={{
            onResize() {
              console.log('resize!')
            },
            maxWidth: window.innerWidth * 0.8,
            minWidth: 300
          }}
          trigger={
            <Button
              key="editPassword"
              size="small"
              onClick={() => {
                setSelectedUserId(record.userId)
              }}
            >
              修改密码
            </Button>
          }
          onFinish={async values => {
            const { error } = await client.mutate({
              operationName: 'user/casdoor/updateUser',
              input: {
                password: values.password,
                userId: selectedUserId
              }
            })
            if (!error) {
              message.success('修改用户密码成功')
              return true
            } else {
              message.error('修改用户密码失败')
            }
          }}
        >
          <ProFormText
            rules={[
              {
                required: true,
                message: '请输入密码'
              }
            ]}
            name="password"
            width="md"
            label="密码"
            placeholder="请输入密码"
          />
        </DrawerForm>
      ]
    }
  ]

  const [drawerOpen, setDrawerOpen] = useState(false)
  const [bindDrawerOpen, setBindDrawerOpen] = useState(false)
  const [drawerForm] = Form.useForm()
  const [bindDrawerForm] = Form.useForm()
  const [isEdit, setIsEdit] = useState(false)
  const [selectedIds, setSelectedIds] = useState<string[]>([])
  const [allRoles, setAllRoles] = useState<
    { label: string; value: string; code: string }[] | undefined
  >()
  const [selectedRoles, setSelectedRoles] = useState<string[] | undefined>()
  const [selectedUserId, setSelectedUserId] = useState<string | undefined>()
  const actionRef = useRef<ActionType>()
  const [avatar, setAvatar] = useState<string | undefined>()

  const getAllRoles = async () => {
    const { error, data } = await client.query({
      operationName: 'role/findMany'
    })
    if (!error) {
      const temp = data?.data.map(item => ({
        label: item.name,
        value: item.id.toString(),
        code: item.code
      }))
      setAllRoles(temp)
    } else {
      message.error('获取用户失败')
    }
  }

  useEffect(() => {
    getAllRoles()
  }, [])

  const getRolesByUserId = async (userId: string) => {
    const { error, data } = await client.query({
      operationName: 'user/findUnique',
      input: {
        userId
      }
    })
    if (!error) {
      console.log(data?.data?.roles, 'getRolesByUserId')
      setSelectedRoles(data?.data?.roles)
    } else {
      message.error('获取用户信息失败')
    }
  }

  const onBindRoleChange = (v: string) => {
    console.log(`checked = ${v}`)
    if (selectedRoles?.includes(v)) {
      setSelectedRoles([...selectedRoles.filter(role => role != v)])
    } else {
      setSelectedRoles([...selectedRoles!, v])
    }
  }

  const updateUserAvatar = async ({ avatar }: { avatar: string }) => {
    const blob = await fetch(avatar).then(resp => resp.blob())
    const file = new File([blob!], `avatar.jpg`)
    const fileList = new DataTransfer()
    fileList.items.add(file)
    const resp = await client.uploadFiles({
      files: fileList.files,
      appendEndpoint: true,
      provider: 'tengxunyun',
      directory: `avatar/${selectedUserId}`
    })
    if (resp.fileKeys.length) {
      const avatar = resp.fileKeys[0]
      setAvatar(avatar)
      return true
    } else {
      message.error('图片上传失败')
    }
  }

  return (
    <div>
      <ProTable
        columns={columns}
        rowKey="id"
        actionRef={actionRef}
        scroll={{ x: 'max-content' }}
        rowSelection={{
          selections: [Table.SELECTION_ALL, Table.SELECTION_INVERT],
          onChange(_, selectedRows) {
            console.log(selectedRows)
            setSelectedIds(selectedRows.map(item => item.userId!))
          }
        }}
        request={async params => {
          const { error, data } = await client.query({
            operationName: 'user/findMany',
            input: {
              skip: (params.current! - 1) * params.pageSize!,
              take: params.pageSize,
              ...replaceAntSearchFormValues(params)
            }
          })
          return {
            total: error ? 0 : data!.total,
            data: error ? [] : data!.data!,
            success: true
          }
        }}
        toolBarRender={() => [
          <DrawerForm
            key="drawerform"
            open={drawerOpen}
            form={drawerForm}
            title={isEdit ? '编辑' : '新增'}
            resize={{
              onResize() {
                console.log('resize!')
              },
              maxWidth: window.innerWidth * 0.8,
              minWidth: 300
            }}
            trigger={
              <Button type="primary">
                <PlusOutlined />
                新增
              </Button>
            }
            autoFocusFirstInput
            drawerProps={{
              destroyOnClose: true
            }}
            submitTimeout={2000}
            onFinish={async values => {
              console.log(values.name)
              if (isEdit) {
                const { error } = await client.mutate({
                  operationName: 'user/casdoor/updateUser',
                  input: {
                    name: values.name,
                    phone: values.phone,
                    avatar: avatar,
                    userId: selectedUserId
                  }
                })
                if (!error) {
                  message.success('编辑用户成功')
                } else {
                  message.error('编辑用户失败')
                }
              } else {
                const { error } = await client.mutate({
                  operationName: 'user/casdoor/addUser',
                  input: {
                    countryCode: values.countryCode,
                    name: values.name,
                    password: values.password,
                    passwordType: values.passwordType,
                    phone: values.phone,
                    avatar: avatar
                  }
                })
                if (!error) {
                  message.success('新增用户成功')
                } else {
                  message.error('新增用户失败')
                }
              }
              actionRef.current?.reload()
              // 不返回不会关闭弹框
              return true
            }}
            onOpenChange={async v => {
              console.log(v)
              if (!v) {
                setDrawerOpen(false)
                if (isEdit) {
                  setIsEdit(false)
                }
              }
            }}
          >
            <ProForm.Group>
              <ProFormText
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
                name="phone"
                width="md"
                label="手机号"
                tooltip="11位手机号"
                placeholder="请输入手机号"
              />
              <ProFormText
                rules={[
                  {
                    required: true
                  }
                ]}
                width="md"
                name="name"
                label="用户名称"
                placeholder="请输入用户名称"
              />
              <ModalForm<{ avatar: string }>
                title="修改头像"
                trigger={
                  <Avatar
                    className="cursor-pointer"
                    src={avatar}
                    size={80}
                    icon={<UserOutlined />}
                    alt="头像"
                  />
                }
                // initialValues={user || undefined}
                onFinish={updateUserAvatar}
              >
                <ProForm.Item name="avatar" rules={[{ required: true }]} noStyle>
                  <AvatarEditor />
                </ProForm.Item>
              </ModalForm>
            </ProForm.Group>
          </DrawerForm>,
          <DrawerForm
            key="bindDrawer"
            title="绑定角色"
            open={bindDrawerOpen}
            form={bindDrawerForm}
            autoFocusFirstInput
            onOpenChange={v => {
              if (v) {
                console.log('open')
              } else {
                setBindDrawerOpen(false)
              }
            }}
            onFinish={async v => {
              const roles = allRoles
                ?.filter(role => selectedRoles?.includes(role.code))
                ?.map(role2 => role2.value)
              console.log(roles, 'roles')
              const inputData = roles?.map((item: string) => ({
                userId: selectedUserId,
                roleId: parseInt(item)
              }))
              const { error } = await client.mutate({
                operationName: 'role/user/updateMany',
                input: {
                  userId: selectedUserId,
                  data: inputData! as admin_admin_role_userCreateManyInput[]
                }
              })
              if (!error) {
                message.success('绑定角色成功')
                actionRef.current?.reload()
              } else {
                message.error('绑定角色失败')
              }
              return true
            }}
          >
            <ProFormCheckbox.Group name="roles" label="" layout="horizontal">
              <Row>
                {allRoles?.map(item => (
                  <Col span={24} key={item.value}>
                    <Checkbox
                      value={item.value}
                      checked={selectedRoles?.some(role => role === item.code)}
                      onChange={() => onBindRoleChange(item.code)}
                    >
                      {item.label + ' : ' + item.code}
                    </Checkbox>
                  </Col>
                ))}
              </Row>
            </ProFormCheckbox.Group>
          </DrawerForm>,
          <Popconfirm
            key="deletePopConfirm"
            title="删除用户"
            description="确定删除此用户吗？"
            onConfirm={async () => {
              const { error } = await client.mutate({
                operationName: 'user/deleteMany',
                input: {
                  userIds: selectedIds
                }
              })
              if (!error) {
                message.success('删除用户成功')
                actionRef.current?.reload()
              } else {
                message.error('删除角色失败')
              }
            }}
            okText="确定"
            cancelText="取消"
          >
            <Button disabled={selectedIds.length === 0}>删除</Button>
          </Popconfirm>
        ]}
      ></ProTable>
    </div>
  )
}

export default UserPage
