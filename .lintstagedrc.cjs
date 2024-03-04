/**
 * @link https://www.npmjs.com/package/lint-staged
 */
module.exports = {
  '*.{js,jsx,ts,tsx}': ['oxlint --fix --quiet'],
  '*.{css,less,styl,scss,sass}': ['stylelint --fix --quiet'],
  '*.{md|txt|yaml|yml|html}': ['prettier --write']
}
