/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
  env: {
    production: {
      plugins: ['react-native-paper/babel'],
    },
  },
  plugins: [
    [
      'module-resolver',
      {
        alias: {
          '@': './src',
        },
        extensions: ['.js', '.json'],
        root: ['./src'],
      },
    ],
    'inline-dotenv',
    'react-native-reanimated/plugin', 
  ],
  presets: ['module:@react-native/babel-preset'],
};
