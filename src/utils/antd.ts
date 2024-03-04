export function replaceAntSearchFormValues<T extends Record<string, any>>(
  v: T,
  ignorePageSizeParams = true
) {
  return Object.keys(v).reduce<T>((acc, cur) => {
    if (v[cur] !== '' && v[cur] !== null) {
      if (!ignorePageSizeParams || !['current', 'pageSize'].includes(cur)) {
        return {
          ...acc,
          [cur]: v[cur]
        }
      }
    }
    return acc
  }, {} as T)
}
