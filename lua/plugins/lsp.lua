function show_diagnostics(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  opts = opts or {['lnum'] = line_nr}

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end

  return diagnostic_message
end

function print_diagnostics(opts, bufnr, line_nr, client_id)
  diagnostic_message = show_diagnostics(opts, bufnr, line_nr, client_id)
  if not diagnostic_message then return end

  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

function show_severity_level(value)
  if value == vim.diagnostic.severity.ERROR then return "ERROR" end
  if value == vim.diagnostic.severity.WARN  then return "WARN"  end
  if value == vim.diagnostic.severity.INFO  then return "INFO"  end
  if value == vim.diagnostic.severity.HINT  then return "HINT"  end

  error("*** Unreachable ***")
end

function show_count_of_severities(opts, bufnr, line_nr, client_id)
  local initial_msg = "| "
  local msg = initial_msg

  count_of_errors = 0
  for level, severity in pairs(vim.diagnostic.count(bufnr, opts)) do
    if level == vim.diagnostic.severity.ERROR then
      count_of_errors = level
    end
    msg = msg .. show_severity_level(level) .. ": " .. severity .. " | "
  end

  if msg == initial_msg then
    return "", count_of_errors
  else
    return msg, count_of_errors
  end
end

function print_count_of_severities(opts, bufnr, line_nr, client_id)
  msg, count_of_errors = show_count_of_severities(opts, bufnr, line_nr, client_id)
  if msg == "" then return msg, count_of_errors end

  vim.api.nvim_echo({{msg, "None"}}, false, {})

  return msg, count_of_errors
end

function hyokkori()
  local msg, count_of_errors = print_count_of_severities()

  if msg == "" then
    vim.cmd [[Trouble diagnostics close]]
  elseif count_of_errors > 0 then
    vim.cmd [[Trouble diagnostics open]]
  else
    -- Nop
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
     'hrsh7th/nvim-cmp',
     'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        completion = {
          autocomplete = false,
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "cmdline" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        experimental = {
          ghost_text = false,
        },
      }

      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup {}

      -- Setup for Golang
      lspconfig.gopls.setup {}

      lspconfig.ocamllsp.setup {}

      -- Setup for Lua
      -- lspconfig.lua_ls.setup {}

      lspconfig.zls.setup {}

      -- Setup for Rust
      lspconfig.rust_analyzer.setup {}

      -- Setup for Java(Type)Script and CSS
      local is_deno_project = function()
        local deno_files = { 'deno.json', 'deno.jsonc', 'deno.lock' }

        for _, filepath in ipairs(deno_files) do
          filepath = table.concat({ vim.fn.getcwd(), filepath }, '/')

          if vim.uv.fs_stat(filepath) ~= nil then return true end
        end

        return false
      end

      -- `npm install -g typescript typescript-language-server`
      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
      lspconfig.denols.setup {
        settings = {
          enable = is_deno_project(),
        },
      }
      lspconfig.ts_ls.setup {
        settings = {
          enable = not is_deno_project(),
        },
      }
      lspconfig.eslint.setup {
        settings = {
          enable = not is_deno_project(),
        },
      }

      -- `npm i -g vscode-langservers-extracted`
      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
      lspconfig.cssls.setup {}

      -- `npm install -g cssmodules-language-server`
      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssmodules_ls
      lspconfig.cssmodules_ls.setup {}

      -- `npm install -g @tailwindcss/language-server`
      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tailwindcss
      lspconfig.tailwindcss.setup {}

      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#purescriptls
      lspconfig.purescriptls.setup {}

      -- Setup Global diagnostic config
      vim.diagnostic.config {
        virtual_text = false,
        signs = false,
        update_in_insert = false,
        underline = false,
        severity_sort = false,
      }

      -- FIXME:echoじゃなくてprompt?みたいになっちゃう
      -- キー入力待ちしたくない
      -- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      --   callback = hyokkori
      -- })

      -- Keymaps
      vim.keymap.set('n', '<S-b>', hyokkori)
      vim.keymap.set('n', ']o', vim.diagnostic.open_float)
      vim.keymap.set('n', ']s', print_count_of_severities)
      vim.keymap.set('n', ']]', vim.diagnostic.goto_next)
      vim.keymap.set('n', '[[', vim.diagnostic.goto_prev)
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references)
      vim.keymap.set('n', 'gf', vim.lsp.buf.format)
      vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover)
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }, 
}

