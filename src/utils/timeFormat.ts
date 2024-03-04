export default function timeFormat(timeString: string): string {
  // 将时间字符串转换为 Date 对象
  var date = new Date(timeString)

  // 获取本地时间的各个部分
  var year = date.getFullYear()
  var month = date.getMonth() + 1 // 月份是从 0 开始的
  var day = date.getDate()
  var hours = date.getHours()
  var minutes = date.getMinutes()
  var seconds = date.getSeconds()

  // 格式化输出，确保每个部分都是两位数字
  function pad(number: number) {
    return number < 10 ? '0' + number : number
  }

  // 组合成最终的本地时间字符串
  var localTimeString =
    year +
    '-' +
    pad(month) +
    '-' +
    pad(day) +
    ' ' +
    pad(hours) +
    ':' +
    pad(minutes) +
    ':' +
    pad(seconds)

  return localTimeString
}
