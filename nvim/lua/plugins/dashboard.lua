return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = '󰊄 Archivos recientes', group = '@property', action = 'Telescope oldfiles', key = 'r' },
          { desc = '󰱼 Buscar archivo', group = 'Label', action = 'Telescope find_files', key = 'f' },
          { desc = ' Nuevo archivo', group = 'DiagnosticHint', action = 'ene | startinsert', key = 'n' },
          { desc = '󰒲 Actualizar Plugins', group = 'Number', action = 'Lazy update', key = 'u' },
          { desc = '󰈆 Salir', group = 'Error', action = 'qa', key = 'q' },
        },
        project = { enable = false },
        mru = { limit = 10 },
        header = {
            [[                                                        ]],
            [[  ██████  ██████ ██████ ██████  ██████ ██  ██████       ]],
            [[  ██      ██     ██     ██   ██   ██   ██ ██            ]],
            [[  ██████  ██     ████   ██████    ██   ██ ██            ]],
            [[      ██  ██     ██     ██        ██   ██ ██            ]],
            [[  ██████  ██████ ██████ ██        ██   ██  ██████       ]],
            [[                                                        ]],
            [[             ███    ██ ██    ██ ██ ███    ███           ]],
            [[             ████   ██ ██    ██ ██ ████  ████           ]],
            [[             ██ ██  ██ ██    ██ ██ ██ ████ ██           ]],
            [[             ██  ██ ██  ██  ██  ██ ██  ██  ██           ]],
            [[             ██   ████   ████   ██ ██      ██           ]],
            [[                                                        ]],
            [[                  S C E P T I C N V I M                 ]],
        },
        footer = { "🔥 Tu Neovim, tus reglas. Let's code! 🔥" }
      },
    })
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
