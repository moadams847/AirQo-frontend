const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './src/pages/**/*.{js,jsx}',
    './src/common/components/**/*.{js,jsx}',
    './node_modules/react-tailwindcss-datepicker/dist/index.esm.js',
  ],
  theme: {
    extend: {
      gridTemplateColumns: {
        pageWidth: '1fr minmax(0, 1088px) 1fr',
      },
      fontFamily: {
        sans: ['Inter', ...defaultTheme.fontFamily.sans],
      },
      // Follow https://tailwindcss.com/docs/customizing-colors to customise colors
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        blue: '#135DFF',
        'light-blue': '#135DFF14',
        'sidebar-blue': '#135DFF0A',
        'dark-blue': '#0F4ACC',
        'light-text': '#6D7175',
        'baby-blue': '#F5F8FF',
        grey: {
          100: '#363A4414',
          150: '#0000000F',
          300: '#6D7175',
          // 150: '#363A4429',
          // 100: '#363A4414',
        },
        skeleton: '#F9F9F9',
        black: {
          600: '#202223',
        },
        // which black is which?
        black: {
          600: '#353E52',
        },
        green: {
          50: '#C6FFE4',
          550: '#0CE87E',
        },
        orange: {
          450: '#FE9E35',
        },
      },
    },
    container: {
      padding: {
        DEFAULT: '1rem',
        sm: '2rem',
        lg: '4rem',
        xl: '5rem',
        '2xl': '6rem',
      },
    },
  },
  plugins: [require('@tailwindcss/typography'), require('daisyui'), require('flowbite/plugin')],
  daisyui: {
    themes: [
      // Platform themes extending default daisy themes (can be further adapted)
      // https://daisyui.com/docs/themes/
      {
        light: {
          ...require('daisyui/src/colors/themes')['[data-theme=light]'],
          primary: '#53b4f4',
          accent: '#ed1164',
          'base-200': '#ebf0f9', // off-white
          'base-300': '#e2faff', // off-blue
        },
      },
      // {
      //   dark: {
      //     ...require('daisyui/src/colors/themes')['[data-theme=light]'],
      //     primary: '#53b4f4',
      //     accent: '#ed1164',
      //     'base-200': '#ebf0f9', // off-white
      //     'base-300': '#e2faff', // off-blue
      //   },
      // },
    ],
  },
};
