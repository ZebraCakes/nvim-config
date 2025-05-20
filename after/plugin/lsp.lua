--[[local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.configure('lua_ls',{
    cmd = { 'lua-language-server' },
    settings = {
        pylsp = {
            plugins = {
                mccabe = {enabled = false },
                pycodestyle = {
                    enabled = true,
                    ignore = "E501,E202,W504,W503,E201,E251,E275,C901"
                },
                flake8 = {
                    enabled = true,
                    ignore = "E501,E202,W504,W503,E201,E251,E275,C901"
                },
            },
        },
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})]]

--[[local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
]]
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'clangd', 'lua_ls', 'pylsp', 'zls', 'ols', 'marksman'},
    --[[handlers = {
        lsp_zero.default_setup,
    },
    ]]
})

vim.lsp.config.clangd = {
    cmd = { 'clangd', '--background-index' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp'},
}

vim.lsp.config.pylsp = {
    cmd = { 'pylsp' },
    plugins = {
        mccabe = { enabled = false },
        pycodestyle = {
            enabled = true,
            ignore = "E501,E202,W504,W503,E201,E251,E275,C901"
        },
        flake8 = {
            enabled = true,
            ignore = "E501,E202,W504,W503,E201,E251,E275,C901"
        },
    },
    filetypes = { 'py' },
}

vim.lsp.config.lua_ls = {
    runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
    },
    diagnostics = {
        globals = { 'vim' },
    },
    filetypes = { 'lua' },
}

vim.lsp.enable('clangd')
vim.lsp.enable('pylsp')
vim.lsp.enable('lua_ls')
