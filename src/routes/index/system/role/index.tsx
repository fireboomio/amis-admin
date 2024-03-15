import { PlusOutlined } from '@ant-design/icons'
import type { ActionType, ProColumns } from '@ant-design/pro-components'
import { DrawerForm, ProForm, ProFormText, ProTable } from '@ant-design/pro-components'
import type { TreeProps } from 'antd'
import { Button, Form, message, Popconfirm, Spin, Table, Tree } from 'antd'
import type { DataNode } from 'antd/es/tree'
import { useRef, useState } from 'react'

import { client } from '@/api'
import type { role__findManyResponseData_data } from '@/api/models'
import { useAuth } from '@/store/auth'
import { replaceAntSearchFormValues } from '@/utils'
import timeFormat from '@/utils/timeFormat'

const RolePage = () => {
  const columns: ProColumns<role__findManyResponseData_data>[] = [
    {
      title: 'id',
      dataIndex: 'id',
      search: false
    },
    {
      title: 'code',
      dataIndex: 'code'
    },
    {
      title: 'name',
      dataIndex: 'name',
      search: false
    },
    {
      title: '描述',
      dataIndex: 'description',
      width: 150,
      ellipsis: true,
      search: false
    },
    {
      title: '创建时间',
      dataIndex: 'createdAt',
      width: 180,
      search: false,
      render: (_, record) => <div>{timeFormat(record.createdAt)}</div>
    },
    {
      title: '更新时间',
      dataIndex: 'updatedAt',
      width: 180,
      search: false,
      render: (_, record) => <div>{timeFormat(record.updatedAt)}</div>
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
            drawerForm.setFieldsValue(record)
            setDrawerOpen(true)
            setSelectedRole(record)
            setIsEdit(true)
          }}
        >
          编辑
        </Button>,
        <Button
          key="bind"
          size="small"
          onClick={async () => {
            setBindPermissionDrawerOpen(true)
            setSelectedRole(record)
          }}
        >
          绑定菜单
        </Button>,
        // <Button
        //   key="bindAPI"
        //   size="small"
        //   onClick={async () => {
        //     setSelectedRole(record)
        //     bindRef.current?.open()
        //   }}
        // >
        //   绑定API
        // </Button>,
        <Popconfirm
          key="deletePopConfirm"
          title="删除用户"
          description="确定删除此用户吗？"
          onConfirm={async () => {
            const { error, data } = await client.mutate({
              operationName: 'role/deleteMany',
              input: {
                codes: [record.code]
              }
            })
            if (!error) {
              message.success('删除角色成功')
              actionRef.current?.reload()
            } else {
              message.error('删除角色失败')
            }
          }}
          okText="确定"
          cancelText="取消"
        >
          <Button size="small">删除</Button>
        </Popconfirm>
      ]
    }
  ]

  const [drawerOpen, setDrawerOpen] = useState(false)
  const [bindPermissionDrawerOpen, setBindPermissionDrawerOpen] = useState(false)
  const [drawerForm] = Form.useForm()
  const [bindDrawerForm] = Form.useForm()
  const [isEdit, setIsEdit] = useState(false)
  const [selectedCodes, setSelectedCodes] = useState<string[]>([])
  const actionRef = useRef<ActionType>()
  const [selectedMenus, setSelectedMenus] = useState<string[]>([])
  const [halfCheckedKeys, setHalfCheckedKeys] = useState<string[]>([])
  const [selectedRole, setSelectedRole] = useState<role__findManyResponseData_data>()
  const { getGroupedMenus } = useAuth()
  const [hasRoleInfo, setHasRoleInfo] = useState(false)

  const onMenuCheck: TreeProps['onCheck'] = (checkedKeys, e) => {
    const menus = checkedKeys.checked
    if (e.node.parentId && !selectedMenus.includes(e.node.parentId.toString())) {
      menus.push(e.node.parentId.toString())
    }
    setSelectedMenus(menus as string[])
  }

  const codePattern = /^[a-zA-Z_$][a-zA-Z\d_$]*$/

  return (
    <div>
      <ProTable
        columns={columns}
        rowKey="id"
        actionRef={actionRef}
        scroll={{ x: 'fit-content' }}
        rowSelection={{
          selections: [Table.SELECTION_ALL, Table.SELECTION_INVERT],
          onChange(_, selectedRows) {
            setSelectedCodes(selectedRows.map(item => item.code))
          }
        }}
        request={async params => {
          const { error, data } = await client.query({
            operationName: 'role/findMany',
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
            key="drawerForm"
            open={drawerOpen}
            form={drawerForm}
            title={isEdit ? '编辑角色' : '新增角色'}
            width={400}
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
              if (isEdit) {
                const { error, data } = await client.mutate({
                  operationName: 'role/updateOne',
                  input: {
                    id: selectedRole!.id,
                    code: values.code,
                    name: values.name,
                    description: values.description
                  }
                })
                if (!error) {
                  message.success('更新角色成功')
                  actionRef.current?.reload()
                } else {
                  message.error('更新角色失败')
                }
              } else {
                const { error } = await client.mutate({
                  operationName: 'role/createOne',
                  input: {
                    code: values.code,
                    name: values.name,
                    description: values.description
                  }
                })
                if (!error) {
                  message.success('创建角色成功')
                  actionRef.current?.reload()
                } else {
                  message.error('创建角色失败')
                }
              }
              // 不返回不会关闭弹框
              return true
            }}
            onOpenChange={async v => {
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
                    required: true
                  },
                  {
                    max: 24
                  },
                  {
                    pattern: codePattern,
                    message: '无效的 code'
                  }
                ]}
                name="code"
                width="md"
                label="角色编码"
                tooltip="最长为 24 位"
                placeholder="请输入角色编码"
              />
              <ProFormText
                rules={[
                  {
                    required: true
                  }
                ]}
                width="md"
                name="name"
                label="角色名称"
                placeholder="请输入角色名称"
              />
              <ProFormText
                rules={[
                  {
                    required: true
                  }
                ]}
                width="md"
                name="description"
                label="角色描述"
                placeholder="请输入角色描述"
              />
            </ProForm.Group>
          </DrawerForm>,
          <Popconfirm
            key="deletePopConfirm"
            title="删除用户"
            description="确定删除此用户吗？"
            onConfirm={async () => {
              const { error, data } = await client.mutate({
                operationName: 'role/deleteMany',
                input: {
                  codes: selectedCodes
                }
              })
              if (!error) {
                message.success('删除角色成功')
                actionRef.current?.reload()
              } else {
                message.error('删除角色失败')
              }
            }}
            okText="确定"
            cancelText="取消"
          >
            <Button disabled={selectedCodes.length === 0}>删除</Button>
          </Popconfirm>
        ]}
      ></ProTable>
      <DrawerForm
        key="bindDrawerForm"
        form={bindDrawerForm}
        title="绑定菜单"
        width={400}
        open={bindPermissionDrawerOpen}
        onOpenChange={async v => {
          if (v) {
            setHasRoleInfo(true)
            const { error, data } = await client.query({
              operationName: 'role/findUnique',
              input: {
                id: selectedRole!.id
              }
            })
            if (!error) {
              setSelectedMenus(data?.data?.menus?.map(item => item.id.toString()) ?? [])
              setHasRoleInfo(false)
            } else {
              message.error(`${error}`)
              setHasRoleInfo(false)
            }
          } else {
            setSelectedMenus([])
            setBindPermissionDrawerOpen(false)
          }
        }}
        onFinish={async () => {
          const inputData = [...selectedMenus, ...halfCheckedKeys]?.map((item: string) => ({
            menuId: parseInt(item)
          }))
          const { error } = await client.mutate({
            operationName: 'role/updateOne',
            input: {
              id: selectedRole!.id,
              createManyMenuRole: {
                data: inputData
              },
              deleteManyMenuRoleId: selectedRole!.id
            }
          })
          if (!error) {
            message.success('绑定菜单成功')
          } else {
            message.error('绑定菜单失败')
          }
          return true
        }}
      >
        <Spin spinning={hasRoleInfo}>
          <Tree
            checkable
            checkStrictly={true}
            defaultExpandAll
            treeData={getGroupedMenus(false, 'id', 'key', 'title', true) as DataNode[]}
            onCheck={onMenuCheck}
            checkedKeys={selectedMenus}
          ></Tree>
        </Spin>
      </DrawerForm>
    </div>
  )
}

export default RolePage
