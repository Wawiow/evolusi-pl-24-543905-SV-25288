import eslint from '@eslint/js'
import vue from 'eslint-plugin-vue'
import globals from 'globals'

export default [
  {
    ignores: ['dist/**'],
  },

  eslint.configs.recommended,
  ...vue.configs['flat/recommended'],

  {
    files: ['**/*.{js,vue}'],
    languageOptions: {
      globals: globals.browser,
    },
    rules: {
      'vue/multi-word-component-names': 'off',
    },
  },
]