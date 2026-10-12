import { defineConfig, presetWind3, presetIcons } from 'unocss';

export default defineConfig({
  configFile: __filename,
  content: {
    pipeline: {
      include: [/.{html,dart}$/]
    }
  },
  presets: [
    presetWind3({
      dark: {
        dark: '.amp-dark-mode',  // Not an amp project but still
        light: ':not(.amp-dark-mode)'
      }
    }),
    presetIcons({
      scale: 1.2,
      cdn: 'https://esm.sh/'
    })
  ],
  shortcuts: {
    'navbar': 'h-[72px] bg-white/80 dark:bg-surface-900/80 backdrop-blur-xl border-b border-surface-200/50 dark:border-surface-800/50 fixed top-0 w-full z-50 flex items-center px-4 transition-all duration-300',
    'nav-container': 'w-full max-w-7xl mx-auto flex items-center justify-between',
    'nav-left': 'flex items-center gap-3',
    'logo': 'no-underline flex items-center gap-2.5 text-surface-900 dark:text-white font-extrabold text-xl tracking-tight',
    'logo-box': 'w-9 h-9 rounded-xl flex items-center justify-center shadow-lg shadow-primary-500/20',
    'logo-text': 'text-lg font-bold capitalize text-surface-900 dark:text-white tracking-tight',
    'desktop-links': 'hidden lg:flex items-center gap-1',
    'nav-item': 'no-underline text-surface-600 dark:text-surface-400 text-sm font-medium px-4 py-2 rounded-lg hover:bg-surface-100/80 dark:hover:bg-surface-800/80 hover:text-primary-600 dark:hover:text-primary-400 transition-all duration-200',
    'nav-item-active': 'no-underline text-primary-600 dark:text-primary-400 text-sm font-bold px-4 py-2 rounded-lg bg-primary-50 dark:bg-primary-900/20',
    'actions-group': 'flex items-center gap-2',
    'icon-btn': 'bg-transparent border-none w-10 h-10 rounded-xl cursor-pointer flex items-center justify-center text-surface-500 dark:text-surface-400 hover:bg-surface-100 dark:hover:bg-surface-800 hover:text-primary-600 dark:hover:text-primary-400 transition-all duration-200 active:scale-90',
    'btn-primary': 'bg-gradient-to-r from-primary-500 to-primary-600 hover:from-primary-600 hover:to-primary-700 text-white font-semibold rounded-xl px-6 py-3 transition-all duration-200 inline-flex items-center justify-center gap-2 cursor-pointer no-underline border-none shadow-lg shadow-primary-500/25 hover:shadow-xl hover:shadow-primary-500/30 active:scale-[0.97] hover:-translate-y-0.5',
    'btn-secondary': 'bg-white dark:bg-surface-800 hover:bg-surface-50 dark:hover:bg-surface-700 text-surface-700 dark:text-surface-200 font-semibold rounded-xl px-6 py-3 transition-all duration-200 inline-flex items-center justify-center gap-2 cursor-pointer no-underline border border-surface-200 dark:border-surface-700 shadow-sm hover:shadow-md active:scale-[0.97] hover:-translate-y-0.5',
    'btn-accent': 'bg-gradient-to-r from-accent-500 to-accent-600 hover:from-accent-600 hover:to-accent-700 text-white font-semibold rounded-xl px-6 py-3 transition-all duration-200 inline-flex items-center justify-center gap-2 cursor-pointer no-underline border-none shadow-lg shadow-accent-500/25 hover:shadow-xl hover:shadow-accent-500/30 active:scale-[0.97] hover:-translate-y-0.5',
    'btn-ghost': 'bg-transparent hover:bg-surface-100 dark:hover:bg-surface-800 text-surface-600 dark:text-surface-300 font-semibold rounded-xl px-4 py-2 transition-all duration-200 inline-flex items-center justify-center gap-2 cursor-pointer no-underline',
    'card': 'bg-white/80 dark:bg-surface-900/80 backdrop-blur-sm rounded-2xl border border-surface-200/60 dark:border-surface-800/60 shadow-sm shadow-surface-200/50 dark:shadow-none hover:shadow-lg hover:shadow-surface-200/60 dark:hover:shadow-none transition-all duration-300 overflow-hidden hover:-translate-y-1',
    'card-body': 'p-6 flex flex-col gap-4',
    'glass-card': 'bg-white/40 dark:bg-surface-800/40 backdrop-blur-xl rounded-2xl border border-white/20 dark:border-surface-700/30 shadow-xl',
    'section-container': 'w-full max-w-7xl mx-auto px-6 lg:px-8',
    'section-header': 'text-center max-w-2xl mx-auto mb-16',
    'section-badge': 'inline-flex items-center gap-2 text-primary-600 dark:text-primary-400 text-xs font-bold uppercase tracking-[0.2em] mb-4',
    'section-title': 'text-3xl sm:text-4xl lg:text-5xl font-extrabold text-surface-900 dark:text-white leading-tight mb-4',
    'section-desc': 'text-lg text-surface-600 dark:text-surface-400 leading-relaxed',
    'footer': 'bg-surface-50 dark:bg-surface-950 border-t border-surface-200/60 dark:border-surface-800/60 py-12 px-6',
    'hero': 'min-h-[100vh] flex items-center justify-center text-center px-6 relative overflow-hidden',
    'hero-title': 'text-4xl sm:text-5xl lg:text-7xl font-extrabold text-surface-900 dark:text-white leading-[1.1] tracking-tight',
    'hero-subtitle': 'text-lg sm:text-xl text-surface-600 dark:text-surface-400 mt-6 max-w-2xl mx-auto leading-relaxed',
    'gradient-text': 'bg-gradient-to-r from-primary-500 via-accent-500 to-primary-500 bg-clip-text text-transparent',
    'animate-float': 'animation-float duration-6s ease-in-out infinite',
    'animate-fade-in': 'animation-fadeIn duration-700ms ease-out forwards',
    'animate-slide-up': 'animation-slideUp duration-700ms ease-out forwards',
  },
  theme: {
    colors: {
      primary: {
        50: '#f0f9ff',
        100: '#e0f2fe',
        200: '#bae6fd',
        300: '#7dd3fc',
        400: '#38bdf8',
        500: '#0284c7', // Antinna Sky Primary
        600: '#0284c7',
        700: '#0369a1',
        800: '#075985',
        900: '#0c4a6e',
      },
      accent: {
        50: '#fff7ed',
        100: '#ffedd5',
        200: '#fed7aa',
        300: '#fdba74',
        400: '#fb923c',
        500: '#f97316', // Vibrant Orange
        600: '#ea580c',
        700: '#c2410c',
      },
      surface: {
        50: '#f8fafc',
        100: '#f1f5f9',
        200: '#e2e8f0',
        300: '#cbd5e1',
        400: '#94a3b8',
        500: '#64748b',
        600: '#475569',
        700: '#334155',
        800: '#1e293b',
        900: '#0f172a',
        950: '#020617',
      }
    },
    keyframes: {
      float: '{0%, 100% { transform: translateY(0px) } 50% { transform: translateY(-20px) }}',
      fadeIn: '{from { opacity: 0 } to { opacity: 1 }}',
      slideUp: '{from { opacity: 0; transform: translateY(30px) } to { opacity: 1; transform: translateY(0) }}',
      slideDown: '{from { opacity: 0; transform: translateY(-20px) } to { opacity: 1; transform: translateY(0) }}',
      pulse: '{0%, 100% { opacity: 1 } 50% { opacity: 0.5 }}',
      spin: '{from { transform: rotate(0deg) } to { transform: rotate(360deg) }}',
      gradientShift: '{0% { background-position: 0% 50% } 50% { background-position: 100% 50% } 100% { background-position: 0% 50% }}',
    },
    animations: {
      float: 'float 6s ease-in-out infinite',
      fadeIn: 'fadeIn 0.7s ease-out forwards',
      slideUp: 'slideUp 0.7s ease-out forwards',
      slideDown: 'slideDown 0.5s ease-out forwards',
      pulse: 'pulse 2s ease-in-out infinite',
      spin: 'spin 1s linear infinite',
      gradientShift: 'gradientShift 8s ease infinite',
    },
  }
});