import { Suspense } from 'react'
import { useRoutes } from 'react-router'

import routes from '~react-pages'

import FullScreenLoading from '../FullScreenLoading'

console.log(routes)

const AppRoutes = () => {
  return <Suspense fallback={<FullScreenLoading />}>{useRoutes(routes)}</Suspense>
}

export default AppRoutes
