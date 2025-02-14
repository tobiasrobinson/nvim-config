return {
  'nvim-lualine/lualine.nvim',
 dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require('lualine').setup({
      options = {
        theme = 'ayu_mirage',  -- Set theme to ayu_mirage
        section_separators = {'', ''},
        component_separators = {'', ''},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', 'lsp_progress'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      extensions = {'fugitive'}
    })
  end
}

