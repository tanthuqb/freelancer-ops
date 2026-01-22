import nextjsConfig from './packages/eslint-config/nextjs.js';
import reactLibraryConfig from './packages/eslint-config/react-library.js';

export default [
  {
    ignores: ['**/node_modules/**', '**/dist/**', '**/build/**', '**/.next/**', '**/out/**'],
  },
  ...nextjsConfig.map((config) => ({
    ...config,
    files: config.files ?? ['apps/web/**/*.{js,jsx,ts,tsx}'],
  })),
  ...reactLibraryConfig.map((config) => ({
    ...config,
    files: config.files ?? ['packages/ui/**/*.{js,jsx,ts,tsx}', 'apps/mobile/**/*.{js,jsx,ts,tsx}'],
  })),
];
