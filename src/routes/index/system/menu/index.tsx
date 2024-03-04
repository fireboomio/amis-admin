import {
  DeleteOutlined,
  EditOutlined,
  LayoutOutlined,
  LineHeightOutlined,
  PlusOutlined
} from '@ant-design/icons'
import type { ActionType, ProColumns } from '@ant-design/pro-components'
import {
  DrawerForm,
  ProForm,
  ProFormDependency,
  ProFormDigit,
  ProFormRadio,
  ProFormText,
  ProFormTreeSelect,
  ProTable
} from '@ant-design/pro-components'
import type { SchemaObject } from 'amis'
import { Button, Drawer, Form, message, Modal } from 'antd'
import { Fragment, useRef, useState } from 'react'
import type { RouteObject } from 'react-router'

import { client } from '@/api'
import type { menu__findManyResponseData_data } from '@/api/models'
import IconSelect from '@/components/AdminIcons/IconSelect'
import SVGIcon from '@/components/AdminIcons/SVGIcon'
import AMISStudio from '@/components/AMISStudio'
import { useDisclosure } from '@/hooks'
import timeFormat from '@/utils/timeFormat'
import { handleTree } from '@/utils/tree'
import routes from '~react-pages'

import type { BindAPIAction } from './components/BindAPI'
import BindAPI from './components/BindAPI'

type MenuItem = menu__findManyResponseData_data

enum ModalType {
  add = 'add',
  edit = 'edit'
}

enum MenuType {
  DIRECTORY = 'M', // 目录
  MENU = 'C', // 菜单
  BUTTON = 'F' // 按钮
}
enum MenuTypeText {
  M = '目录', // 目录
  C = '菜单', // 菜单
  F = '按钮' // 按钮
}

type FormValues = {
  label: string
  type: string
  icon: string
  path: string
  sort: number
  permission: string
  // api_id: string
  parent: {
    label: string
    value: number | null
  }
}

const createInitialValues: FormValues = {
  parent: {
    label: '主目录',
    value: null
  },
  label: '',
  type: '',
  icon: '',
  path: '',
  sort: 1,
  permission: ''
}

const MenuPage = () => {
  const [modalOpen, setModalOpen] = useState<boolean>(false)
  const [modalType, setModalType] = useState<ModalType>(ModalType.add)
  const [list, setList] = useState<MenuItem[]>([])
  const [studioOpened, { close, open }] = useDisclosure()
  const [editingMenu, setEditingMenu] = useState<MenuItem | null>(null)
  const [form] = Form.useForm<FormValues>()
  const actionRef = useRef<ActionType>()
  const bindButtonAPIRef = useRef<BindAPIAction>()
  const [selectedPaths, setSelectedPaths] = useState<string[]>([])

  const [treeData, setTreeData] = useState([
    {
      id: 0,
      label: '主目录',
      // api_id: '',
      icon: '',
      level: 0,
      parentId: null,
      path: '/',
      permission: '',
      sort: 1,
      children: []
    }
  ])

  // 展开行可控
  const [expKeys, setExpKeys] = useState<number[]>([])
  const openOrCloseAll = () => {
    expKeys.length === treeData[0].children.length
      ? setExpKeys([])
      : setExpKeys(treeData[0].children.map(i => (i as MenuItem).id))
  }

  const saveSchema = async (_schema?: SchemaObject) => {
    const schema = _schema ? JSON.stringify(_schema).replace(/\\n/g, 'n') : ''
    const { error } = await client.mutate({
      operationName: 'menu/updateOne',
      input: {
        id: editingMenu!.id,
        schema
      }
    })
    if (!error) {
      message.success('保存成功')
      actionRef.current?.reload()
    }
  }

  const handleSubmit = async (values: FormValues) => {
    let isExist =
      modalType === ModalType.add
        ? list.some(item => item.label === values.label)
        : list.some(item => item.id !== editingMenu!.id && item.label === values.label)

    if (isExist) {
      return message.warning('该菜单已存在, 请勿重复添加')
    }

    const { error, data } =
      modalType === ModalType.add ? await handleCreate(values) : await handleUpdate(values)

    if (error) {
      message.error('提交失败')
      return false
    } else if (data) {
      setModalOpen(false)
      message.success('提交成功')
      form.resetFields()
      if (actionRef.current) {
        actionRef.current.reload()
      }
    }
    location.reload()
    return true
  }

  const handleCreate = async (values: FormValues) => {
    const { parent, ...fields } = values
    const parentMenu = list.find(item => item.id === parent.value)
    const { error, data } = await client.mutate({
      operationName: 'menu/createOne',
      input: {
        ...fields,
        parentId: parent.value,
        level: parentMenu ? parentMenu.level + 1 : 1
      }
    })
    return {
      error,
      data
    }
  }

  const handleUpdate = async (values: FormValues) => {
    const { parent, ...fields } = values
    const { error, data } = await client.mutate({
      operationName: 'menu/updateOne',
      input: {
        id: editingMenu!.id,
        ...fields,
        parentId: parent?.value ?? null
      }
    })
    return {
      error,
      data
    }
  }

  const columns: ProColumns<MenuItem>[] = [
    {
      title: '菜单名称',
      dataIndex: 'label',
      search: false
    },
    {
      title: '菜单类型',
      dataIndex: 'type',
      valueEnum: MenuTypeText,
      search: false
    },
    {
      title: '图标',
      dataIndex: 'icon',
      search: false,
      width: 64,
      renderText(text) {
        if (text) {
          return <SVGIcon className="w-6 h-6" url={text} />
        }
        return null
      }
    },
    {
      title: '排序',
      dataIndex: 'sort',
      search: false
    },
    {
      title: '权限标识',
      dataIndex: 'permission',
      search: false
    },
    {
      title: '路径',
      dataIndex: 'path',
      search: false
    },
    {
      title: '是否菜单显示',
      dataIndex: 'visibleInMenu',
      render: (_, reccord) => {
        return <div>{reccord.visibleInMenu ? '是' : '否'}</div>
      }
    },
    {
      title: '创建时间',
      dataIndex: 'createdAt',
      search: false,
      render: (_, record) => <div>{timeFormat(record.createdAt)}</div>
    },
    {
      title: '操作',
      valueType: 'option',
      key: 'option',
      fixed: 'right',
      render: (text, record, _, action) => {
        const ret = [
          <Button
            key="editable"
            size="small"
            icon={<EditOutlined />}
            onClick={() => {
              form.setFieldsValue({
                ...record,
                parent: {
                  ...(!record.parentId && {
                    label: '主目录'
                  }),
                  value: record.parentId ?? null
                }
              })
              setEditingMenu(record)
              setModalType(ModalType.edit)
              setModalOpen(true)
            }}
          >
            修改
          </Button>,
          record.type === 'F' ? null : (
            <Button
              key="add"
              size="small"
              icon={<PlusOutlined />}
              onClick={() => {
                form.setFieldsValue({
                  ...createInitialValues,
                  parent: {
                    label: record.label,
                    value: record.id
                  }
                })
                setEditingMenu(record)
                setModalOpen(true)
                setModalType(ModalType.add)
              }}
            >
              新增
            </Button>
          ),
          <Button
            key="delete"
            size="small"
            icon={<DeleteOutlined />}
            onClick={() => {
              if (list.some(item => item.parentId === record.id)) {
                message.warning('无法删除父菜单')
                return
              }
              Modal.confirm({
                title: '提示',
                content: '确认删除已选中的数据项?',
                okText: '确认',
                cancelText: '取消',
                onOk: async function () {
                  const { error } = await client.mutate({
                    operationName: 'menu/deleteMany',
                    input: {
                      ids: [record.id]
                    }
                  })
                  if (!error) {
                    message.success('删除成功')
                    action?.reload()
                    location.reload()
                  }
                }
              })
            }}
          >
            删除
          </Button>
        ]
        if (
          !list.some(item => item.parentId === record.id) &&
          record.type !== 'F' &&
          !isPathInData(record?.path ?? '', processRoutes(routes))
        ) {
          ret.splice(
            2,
            0,
            <Button
              key="design"
              size="small"
              icon={<LayoutOutlined />}
              onClick={() => {
                setEditingMenu(record)
                open()
              }}
            >
              设计
            </Button>
          )
        }
        return ret
      }
    }
  ]

  function isPathInData(pathToCheck: string, data: RouteObject[]): boolean {
    for (const item of data) {
      // 检查当前层级的path
      if (item.path === pathToCheck) {
        return true
      }

      // 递归检查子路径
      if (item.children && isPathInData(pathToCheck, item.children)) {
        return true
      }
    }
    return false
  }

  function processRoutes(routes: RouteObject[], parentPath: string = ''): RouteObject[] {
    return routes.map(route => {
      // 拼接父路径和当前路径
      const fullPath = `${parentPath}/${route.path}`.replace(/\/\//g, '/')

      // 处理子路径
      const children = route.children ? processRoutes(route.children, fullPath) : []

      // 返回新的路由对象
      return { ...route, path: fullPath, children }
    }) as RouteObject[]
  }

  return (
    <Fragment>
      <ProTable
        columns={columns}
        rowKey="id"
        search={false}
        options={false}
        pagination={false}
        actionRef={actionRef}
        scroll={{ x: 'max-content' }}
        expandable={{
          expandedRowKeys: expKeys, // 设置展开的行
          onExpand: (expanded, record) => {
            const newExp: any = expanded
              ? [...expKeys, record.id]
              : expKeys.filter(i => i !== record.id)
            setExpKeys(newExp)
          }
        }}
        request={async (params, sort, filter) => {
          const { error, data } = await client.query({
            operationName: 'menu/findMany',
            input: {
              take: 999999
            }
          })
          const list = data!.data ?? []
          const newData = [...treeData]
          newData[0].children = handleTree(list)
          setTreeData(newData)
          setList(list)
          return {
            total: error ? 0 : data!.total,
            data: error ? [] : newData[0].children,
            success: true
          }
        }}
        toolBarRender={() => [
          <Button
            key="add"
            type="primary"
            onClick={() => {
              form.setFieldsValue({ ...createInitialValues })
              setEditingMenu(null)
              setModalOpen(true)
              setModalType(ModalType.add)
            }}
          >
            <PlusOutlined />
            新增
          </Button>,
          <Button
            style={{ backgroundColor: 'gray' }}
            key="button"
            icon={<LineHeightOutlined />}
            type="primary"
            onClick={() => {
              openOrCloseAll()
            }}
          >
            展开/折叠
          </Button>
        ]}
      />
      <DrawerForm<FormValues>
        title={modalType === ModalType.add ? '新增菜单' : '编辑菜单'}
        form={form}
        open={modalOpen}
        resize={{
          minWidth: 400
        }}
        autoFocusFirstInput
        drawerProps={{
          destroyOnClose: true
        }}
        submitTimeout={2000}
        onOpenChange={visible => {
          // 关闭弹窗
          if (!visible) {
            form.resetFields()
            setModalOpen(false)
          }
        }}
        onFinish={values => handleSubmit(values)}
      >
        <ProForm.Group>
          <ProFormTreeSelect
            name="parent"
            label="上级菜单"
            placeholder="请选择"
            width={330}
            secondary
            allowClear={false}
            // tree-select args
            fieldProps={{
              // suffixIcon: null,
              filterTreeNode: true,
              showSearch: true,
              popupMatchSelectWidth: false,
              labelInValue: true,
              autoClearSearchValue: true,
              treeNodeFilterProp: 'label',
              fieldNames: {
                label: 'label',
                value: 'id'
              },
              treeData: treeData
            }}
          />
        </ProForm.Group>
        <ProForm.Group>
          <ProFormText
            required
            width="md"
            name="label"
            label="菜单名称"
            placeholder="请输入菜单名称"
            rules={[
              {
                required: true,
                message: '请输入菜单名称!'
              }
            ]}
          />
        </ProForm.Group>
        <ProFormRadio.Group
          name="type"
          label="菜单类型"
          options={[
            {
              label: '目录',
              value: MenuType.DIRECTORY
            },
            {
              label: '菜单',
              value: MenuType.MENU
            },
            {
              label: '按钮',
              value: MenuType.BUTTON
            }
          ]}
        />
        <ProFormDependency name={['type', 'icon']}>
          {({ type, icon }) => {
            if (type === MenuType.BUTTON) return null
            return (
              <>
                <ProForm.Group>
                  <IconSelect
                    value={form.getFieldValue('icon')}
                    onChange={item => form.setFieldsValue({ icon: item })}
                  />
                </ProForm.Group>
                <ProForm.Group>
                  <ProFormText
                    width="md"
                    name="path"
                    label="组件路径"
                    placeholder="/system  (目录以/开头)"
                  />
                </ProForm.Group>
              </>
            )
          }}
        </ProFormDependency>
        <ProForm.Group>
          <ProFormDigit width="md" label="排序" name="sort" min={0} fieldProps={{ precision: 0 }} />
        </ProForm.Group>
        <ProFormDependency name={['type']}>
          {({ type }) => {
            if (type === MenuType.DIRECTORY) return null
            return (
              <ProForm.Group>
                <ProFormText
                  width="md"
                  label="权限标识"
                  name="permission"
                  placeholder="请输入权限标识"
                />
              </ProForm.Group>
            )
          }}
        </ProFormDependency>
        <ProFormDependency name={['type']}>
          {({ type }) => {
            if (type !== MenuType.BUTTON) {
              return (
                <ProFormRadio.Group
                  label="是否在菜单中显示"
                  name="visibleInMenu"
                  options={[
                    { label: '是', value: true },
                    { label: '否', value: false }
                  ]}
                  radioType="radio"
                />
              )
            }
            return null
          }}
        </ProFormDependency>
        <ProFormDependency name={['type']}>
          {({ type }) => {
            if (type === MenuType.BUTTON) {
              return (
                <div>
                  <Button onClick={() => bindButtonAPIRef.current?.open()}>绑定API</Button>
                  {selectedPaths && selectedPaths.map(item => <p key={item}>{item}</p>)}
                </div>
              )
            }
          }}
        </ProFormDependency>
      </DrawerForm>
      <Drawer open={studioOpened} width="100vw" closable={false} classNames={{ body: '!p-0' }}>
        {studioOpened && (
          <AMISStudio schema={editingMenu?.schema} onExit={close} onSave={saveSchema} />
        )}
      </Drawer>
      {
        <BindAPI
          actionRef={bindButtonAPIRef}
          onClose={paths => {
            console.log(paths)
            setSelectedPaths(paths)
          }}
        />
      }
    </Fragment>
  )
}

export default MenuPage
