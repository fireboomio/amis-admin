import type { MenuDataItem } from '@ant-design/pro-components'
import { DrawerForm } from '@ant-design/pro-components'
import { useRequest } from 'ahooks'
import { Spin } from 'antd'
import type { DataNode, TreeProps } from 'antd/es/tree'
import DirectoryTree from 'antd/es/tree/DirectoryTree'
import type { MutableRefObject } from 'react'
import { useEffect, useState } from 'react'

import { client } from '@/api'
import type { api__listPublicResponseData_data } from '@/api/models'
import { useDisclosure } from '@/hooks'

export type BindAPIAction = {
  open: () => void
}

const BindAPI = ({
  actionRef,
  onClose,
  selectedApis
}: {
  selectedApis?: ''
  onClose?: (paths: string[]) => void
  actionRef?: MutableRefObject<BindAPIAction | undefined>
}) => {
  const [opened, { close, open, set }] = useDisclosure()
  const request = useRequest(
    async () => {
      const { data } = await client.query({
        operationName: 'api/listPublic'
      })
      return data?.data ?? []
    },
    {
      cacheKey: 'api/listPublic'
    }
  )

  const [selectedPaths, setSelectedPaths] = useState<string[]>([])

  async function bindAPI() {
    onClose && onClose(selectedPaths)
    return true
  }

  useEffect(() => {
    if (actionRef && !actionRef.current) {
      actionRef.current = {
        open
      }
    }
  }, [actionRef, open])

  interface TreeNode {
    key: string
    title: string
    children: Record<string, TreeNode>
  }

  function createTreeData(paths: api__listPublicResponseData_data[]): MenuDataItem[] {
    const treeMap: Record<string, TreeNode> = {}

    paths.forEach(item => {
      const pathParts = item.path.split('/')
      let currentLevel = treeMap

      pathParts.forEach((part, index) => {
        const key = pathParts.slice(0, index + 1).join('/')
        if (!currentLevel[part]) {
          currentLevel[part] = {
            title: part,
            key: key,
            children: {}
          }
        }
        currentLevel = currentLevel[part].children
      })
    })

    const convertToTreeArray = (nodeMap: Record<string, TreeNode>): MenuDataItem[] => {
      return Object.values(nodeMap).map(node => ({
        key: node.key,
        title: node.title,
        children:
          node.children && Object.keys(node.children).length > 0
            ? convertToTreeArray(node.children)
            : [],
        isLeaf: node.children && Object.keys(node.children).length > 0 ? false : true
      }))
    }

    return convertToTreeArray(treeMap)
  }

  const onApiCheck: TreeProps['onCheck'] = (checkedKeys, info) => {
    console.log('onCheck', checkedKeys, info)
    setSelectedPaths(checkedKeys as string[])
  }

  if (request.loading) {
    return (
      <div className="w-full h-full flex items-center justify-center">
        <Spin></Spin>
      </div>
    )
  }
  return (
    <DrawerForm
      open={opened}
      title="绑定接口"
      onOpenChange={v => {
        set(v)
        if (!v) {
          onClose?.(selectedPaths)
        }
      }}
      onFinish={bindAPI}
    >
      <div>
        <DirectoryTree
          checkable
          defaultExpandAll
          treeData={createTreeData(request.data ?? []) as DataNode[]}
          onCheck={onApiCheck}
          checkedKeys={selectedPaths}
        />
      </div>
    </DrawerForm>
  )
}

export default BindAPI
