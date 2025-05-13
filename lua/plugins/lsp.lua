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
  if value == vim.diagnostic.severity.WARN  then return "WARN" end
  if value == vim.diagnostic.severity.INFO  then return "INFO" end
  if value == vim.diagnostic.severity.HINT  then return "HINT" end

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

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
     'hrsh7th/nvim-cmp',
     'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require("cmp").setup{}

      local lspconfig = require("lspconfig")

      -- Setup for Golang
      lspconfig.gopls.setup {}

      -- Setup for Lua
      -- lspconfig.lua_ls.setup {}

      -- Setup Global diagnostic config
      vim.diagnostic.config {
        virtual_text = false,
        signs = false,
        update_in_insert = false,
        under_line = false,
        severity_sort = false,
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          local msg, count_of_errors = print_count_of_severities()

          if msg == "" then
            vim.cmd [[Trouble diagnostics close]]
          elseif count_of_errors > 0 then
            vim.cmd [[Trouble diagnostics open]]
          else
            -- Nop
          end
        end
      })

      vim.keymap.set('n', ']o', vim.diagnostic.open_float)
      vim.keymap.set('n', ']s', print_count_of_severities)
      vim.keymap.set('n', ']]', vim.diagnostic.goto_next)
      vim.keymap.set('n', '[[', vim.diagnostic.goto_prev)
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
  } 
}

