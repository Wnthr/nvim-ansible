local M = {}

-- Function to define fold expressions for Ansible YAML
function M.setup_folding()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml.ansible",
    callback = function()
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.WnthrAnsibleFold()"
    end,
  })

  _G.WnthrAnsibleFold = function()
    local line = vim.fn.getline(vim.v.lnum)
    local stripped = vim.fn.matchstr(line, [[^\s*\zs- name:]])
    if stripped ~= "" then
      return ">" .. vim.fn.indent(vim.v.lnum)
    end
    return "=" .. vim.fn.indent(vim.v.lnum)
  end
end

return M
