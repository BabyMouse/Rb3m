/**
 ** Prettier - Code formatter: esbenp.prettier-vscode
 * ref: https://prettier.io/docs/en/configuration.html
 * ref: https://prettier.io/docs/en/options.html
 */
module.exports = {
  overrides: [
    {
      files: ['*.html'],
      options: {
        printWidth: 180,
        tabWidth: 2,
        //Print semicolons at the ends of statements.
        semi: true,
        //Print trailing commas wherever possible when multi-line.
        //(A single - line array, for example, never gets trailing commas.)
        trailingComma: 'none',
        bracketSpacing: false,
        singleQuote: true,
        jsxBracketSameLine: true,
        htmlWhitespaceSensitivity: 'strict'
      }
    },
    {
      files: ['*.css'],
      options: {
        printWidth: 180,
        tabWidth: 2,
        bracketSpacing: true,
        singleQuote: true
      }
    },
    {
      files: ['*.js', 'javascript', '.prettierrc.js'],
      options: {
        //parser: 'flow',
        printWidth: 180,
        tabWidth: 2,
        semi: true,
        trailingComma: 'none',
        bracketSpacing: true,
        singleQuote: true,
        endOfLine: 'crlf'
      }
    },
    {
      files: ['*.json', 'jonc', '*.code-workspace', '.eslintrc', '.markdownlintrc'],
      options: {
        printWidth: 150,
        tabWidth: 2,
        trailingComma: 'none',
        singleQuote: true
      }
    },
    {
      files: ['*.md'],
      options: {
        proseWrap: 'never'
        //htmlWhitespaceSensitivity: 'strict'
        //endOfLine: 'crlf'
      }
    }
  ]
};
