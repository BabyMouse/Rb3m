# Init for VSCode editor
# ref: https://github.com/PowerShell/PowerShell
# ref: https://docs.microsoft.com/en-us/powershell/scripting/how-to-use-docs?view=powershell-7
#
# run `npm init` to create `package.json`.
if(-not(Test-Path package.json)) { npm init --yes }
npm install prettier --save-dev --save-exact
npm install eslint eslint-config-prettier eslint-plugin-prettier --save-dev