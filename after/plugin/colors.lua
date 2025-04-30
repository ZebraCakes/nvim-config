function ColorMyPencils(color)
    color = color or "tokyonight-storm"
    vim.cmd[[colorscheme tokyonight-storm]]

    --color = color or "koehler"
    --vim.cmd[[colorscheme koehler]]

    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
end

ColorMyPencils()
