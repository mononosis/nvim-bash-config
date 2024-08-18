local M = {}

local lspconfig = require('lspconfig')

function M.setup()

  local caps = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities(),
    -- File watching is disabled by default for neovim.
    -- See: https://github.com/neovim/neovim/pull/22405
    { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
  );

  lspconfig.bashls.setup {
    autostart = true,
    on_attach = function(_, bufnr)
      -- Custom on_attach logic
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>t', '<cmd>!bash %<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fl",
        ":!shfmt -i 2 -w %<CR>",
        { noremap = true, silent = true }
      )
    end
    ,
    capabilities = caps,
    cmd = { "bash-language-server", "start" },
    settings = {
      bash = {
        formatting = {
          command = { "shfmt" },
        },
      },
    },
  }
end

return M
