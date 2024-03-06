const { spawn, execSync } = require('child_process')
const { resolve } = require('node:path')
const { stat } = require('node:fs/promises')

const oidcBinPath = resolve(__dirname, '../oidc/oidc')
const fireboomBinPath = resolve(__dirname, '../backend/fireboom')

async function isUpdateValid(buildTimeUrl, localBinPath) {
  try {
    const binStat = await stat(localBinPath)
    const buildTime = await fetch(buildTimeUrl).then(resp => resp.text())
    console.log('mtime', binStat.mtime, 'build time', buildTime)
    // 本地文件更新时间小于build时间10s以上（防止机器时间误差），则认为不需要更新
    return binStat.mtime - new Date(buildTime.trim()) < -1000 * 10
  } catch (error) {
    console.error(error)
    return true
  }
}

async function isOidcNeedUpdate() {
  return isUpdateValid('https://yudai-bin.fireboom.io/build-env/build_time', oidcBinPath)
}

async function isFireboomNeedUpdate() {
  return isUpdateValid(
    'https://fb-bin.oss-cn-hangzhou.aliyuncs.com/test/build_time',
    fireboomBinPath
  )
}

function start() {
  // oidc server
  const oidc = spawn('./oidc', {
    cwd: resolve(__dirname, '../oidc'),
    env: {
      YUDAI_DB_URL: process.env.YUDAI_DB_URL || 'mysql://root:123456@tcp(localhost:3306)/oidc?charset=utf8mb4&parseTime=True&loc=Local'
    }
  })

  oidc.stdout.pipe(process.stdout)
  oidc.stderr.pipe(process.stderr)

  // 第一个进程执行fireboom
  const fb = spawn('./fireboom', ['dev'], {
    cwd: resolve(__dirname, '../backend')
  })

  fb.stdout.pipe(process.stdout)
  fb.stderr.pipe(process.stderr)

  // 第二个进程执行go程序
  const hook = spawn('bash', ['scripts/run-dev.sh'], {
    cwd: resolve(__dirname, '../backend/custom-go')
  })

  hook.stdout.pipe(process.stdout)
  hook.stderr.pipe(process.stderr)
}

;(async () => {
  if (await isOidcNeedUpdate()) {
    console.log('检测到 oidc 需要更新')
    execSync('bash update.sh', {
      stdio: ['pipe', 1, 2],
      cwd: resolve(__dirname, '../oidc')
    })
  }
  if (await isFireboomNeedUpdate()) {
    console.log('检测到 Fireboom 需要更新')
    execSync('bash update.sh', {
      stdio: ['pipe', 1, 2],
      cwd: resolve(__dirname, '../backend')
    })
  }
  start()
})()
