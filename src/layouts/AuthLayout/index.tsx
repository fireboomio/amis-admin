import type { ReactNode } from 'react'
import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'

import CheckedIcon from '@/assets/checked.svg?react'
import FBLogo from '@/assets/fb-logo.png'
import { Path } from '@/constants'
import { useAuth } from '@/store/auth'

import IconDatabase from './assets/database.png'
import IconGithub from './assets/github.png'
import IconSDK from './assets/sdk.png'
import IconVSCode from './assets/vscode.png'

export default function AuthLayout({ children }: { children?: ReactNode }) {
  const navigate = useNavigate()
  const {
    computed: { logged },
    ready
  } = useAuth()

  useEffect(() => {
    if (ready && logged) {
      navigate(Path.Home, { replace: true })
    }
  }, [])

  return (
    <div className="w-screen h-screen flex overflow-x-hidden">
      <div
        className="relative w-1/3 max-w-[576px] p-6 flex flex-col items-center justify-center"
        style={{
          backgroundImage: `linear-gradient(133deg, rgb(255, 238, 238), rgb(255, 185, 185))`
        }}
      >
        <div className="flex flex-col items-start justify-center">
          <a
            href="https://fireboom.cloud?"
            target="_blank"
            className="absolute left-8 top-5"
            rel="noreferrer"
          >
            <img src={FBLogo} className="h-6" alt="logo" />
          </a>
          <p className="m-0 text-[28px] text-center font-medium">
            <span className="text-[#ff4d60]">前端</span>
            变全栈，
            <span className="text-[#ff4d60]">后端</span>
            不搬砖
          </p>
          <hr
            className="h-1px mt-6 mb-5 w-[331px] border-none"
            style={{
              backgroundImage:
                'linear-gradient(270deg, rgb(238, 95, 107) 40%, rgb(241, 139, 199)) rgb(51, 51, 51)'
            }}
          />
          <div className="flex items-center h-9 text-sm">
            <CheckedIcon className="mr-2 text-blue-700 w-3.5" />
            支持连接自定义数据库和三方数据源
          </div>
          <div className="flex items-center h-9 text-sm">
            <CheckedIcon className="mr-2 text-blue-700 w-3.5" />
            多语言兼容, 支持主流编程语言
          </div>
          <div className="flex items-center h-9 text-sm">
            <CheckedIcon className="mr-2 text-blue-700 w-3.5" />
            可视化操作面板, 简单易学
          </div>
          <div className="mt-[3vh] flex gap-4">
            <FeatureCard
              icon={IconDatabase}
              text="数据库建模"
              desc="内置数据库建模功能，技术小白也能驾驭。"
            />
            <FeatureCard
              icon={IconGithub}
              text="GitHub集成"
              desc="不断地将生成的应用程序推送到你的GitHub存储库，实现版本管理。"
            />
          </div>
          <div className="mt-4 flex gap-4">
            <FeatureCard
              icon={IconSDK}
              text="SDK生成"
              desc="生成带有自动登录功能的客户端SDK方便前后端对接接口。"
            />
            <FeatureCard
              icon={IconVSCode}
              text="VSCODE"
              desc="提供vscode插件，方便高端玩家使用更深功能。"
            />
          </div>
        </div>
      </div>
      <div className="bg-white flex-1 flex flex-col items-center justify-center">{children}</div>
    </div>
  )
}

function FeatureCard({ icon, text, desc }: { icon: string; text: string; desc: string }) {
  return (
    <div
      className="flex-1 w-[158px] h-[192px] flex-shrink-0 min-w-0 flex flex-col items-start p-4 rounded shadow transition hover:shadow-lg cursor-pointer"
      style={{
        background: 'linear-gradient(136deg, rgba(255, 242, 242, 0.63), rgb(254, 206, 211))'
      }}
    >
      <img src={icon} className="w-6 h-6" alt="ico" />
      <p className="my-2 text-lg text-[#ff4d60] font-semibold">{text}</p>
      <p className="text-sm text-gray-500">{desc}</p>
    </div>
  )
}
