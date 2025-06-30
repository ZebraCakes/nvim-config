-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("lazy not found")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
else
    print(vim.fn.stdpath("data"))
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {   'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' } },
    {
        'tpope/vim-fugitive',
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'qpkorr/vim-bufkill'
    },
    {
        'jlanzarotta/bufexplorer'
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {   --- TODO: this needs to use main branch, once you figure out wtf is breaking
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = {'c', 'lua', 'vim', 'vimdoc', 'python', 'html'},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {'nvim-treesitter/nvim-treesitter-context'},
    {'mbbill/undotree'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { -- optional cmp completion source for require statements and module annotations
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
    { -- optional blink completion source for require statements and module annotations
      "saghen/blink.cmp",
      opts = {
        sources = {
          -- add lazydev to your completion providers
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
        },

        fuzzy = { implementation = "lua" },
      },
    },
    --[[{
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        opts = {
            keymap = { preset = 'default' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = {'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
        },

        opts_extend = { "sources.default" },
    },]]
    --{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    --{'neovim/nvim-lspconfig'},
    --{'hrsh7th/cmp-nvim-lsp', dependencies = {'hrsh7th/nvim-cmp'}},
    {'wincent/command-t',
        build = 'cd lua/wincent/commandt/lib && make',
        init = function()
            vim.g.CommandTPreferredImplementation = 'lua'
        end,
        config = function()
            require('wincent.commandt').setup({})
        end,
    },
    {'skywind3000/asyncrun.vim'},
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter'},
        opts = {},
    },
    {
        'github/copilot.vim',
        suggestion = {enabled = false},
        panel = {enabled = false},
        event = 'InsertEnter',
        lazy = false,
        autoStart = true,
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap('i', '<C-n>', 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
            vim.api.nvim_set_keymap('i', '<C-e>', 'copilot#Dismiss()', { silent = true, expr = true, script = true })
            vim.api.nvim_set_keymap('n', '<leader>cpt', ':lua toggle_copilot()<CR>', { noremap = true, silent = true })
        end,
        
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
          { "github/copilot.vim" },            -- or github/copilot.vim
          { "nvim-lua/plenary.nvim" },         -- for curl, log wrapper
          { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
        },
        opts = {
          debug = true, -- Enable debugging
          show_help = true, -- Show help actions
          window = {
            layout = "float",
          },
          auto_follow_cursor = false,    -- Don't follow the cursor after getting response
        },
        config = function(_, opts)
          local chat = require("CopilotChat")
          local select = require("CopilotChat.select")
          -- Use unnamed register for the selection
          opts.selection = select.unnamed

          -- Override the git prompts message
          --[[opts.prompts.Commit = {
            prompt = "Write commit message for the change with commitizen convention",
            selection = select.gitdiff,
          }
          opts.prompts.CommitStaged = {
            prompt = "Write commit message for the change with commitizen convention",
            selection = function(source)
              return select.gitdiff(source, true)
            end,
          }]]

          chat.setup(opts)

          vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
            chat.ask(args.args, { selection = select.visual })
          end, { nargs = "*", range = true })

          -- Inline chat with Copilot
          vim.api.nvim_create_user_command("CopilotChatInline", function(args)
            chat.ask(args.args, {
              selection = select.visual,
              window = {
                layout = "float",
                relative = "cursor",
                width = 1,
                height = 0.4,
                row = 1,
              },
            })
          end, { nargs = "*", range = true })

          -- Restore CopilotChatBuffer
          vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
            chat.ask(args.args, { selection = select.buffer })
          end, { nargs = "*", range = true })
        end,
        event = "VeryLazy",
        keys = {
          -- Show help actions with telescope
          {
            "<leader>cch",
            function()
              local actions = require("CopilotChat.actions")
              require("CopilotChat.integrations.telescope").pick(actions.help_actions())
            end,
            desc = "CopilotChat - Help actions",
          },
          -- Show prompts actions with telescope
          {
            "<leader>ccp",
            function()
              local actions = require("CopilotChat.actions")
              require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            end,
            desc = "CopilotChat - Prompt actions",
          },
          -- Code related commands
          { "<leader>cce", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
          { "<leader>cct", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
          { "<leader>ccr", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
          { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
          { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
          -- Chat with Copilot in visual mode
          {
            "<leader>ccv",
            ":CopilotChatVisual",
            mode = "x",
            desc = "CopilotChat - Open in vertical split",
          },
          {
            "<leader>ccx",
            ":CopilotChatInline<cr>",
            mode = "x",
            desc = "CopilotChat - Inline chat",
          },
          -- Custom input for CopilotChat
          {
            "<leader>cci",
            function()
              local input = vim.fn.input("Ask Copilot: ")
              if input ~= "" then
                vim.cmd("CopilotChat " .. input)
              end
            end,
            desc = "CopilotChat - Ask input",
          },
          -- Generate commit message based on the git diff
          {
            "<leader>ccm",
            "<cmd>CopilotChatCommit<cr>",
            desc = "CopilotChat - Generate commit message for all changes",
          },
          {
            "<leader>ccM",
            "<cmd>CopilotChatCommitStaged<cr>",
            desc = "CopilotChat - Generate commit message for staged changes",
          },
          -- Quick chat with Copilot
          {
            "<leader>ccq",
            function()
              local input = vim.fn.input("Quick Chat: ")
              if input ~= "" then
                vim.cmd("CopilotChatBuffer " .. input)
              end
            end,
            desc = "CopilotChat - Quick chat",
          },
          -- Debug
          { "<leader>ccd", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
          -- Fix the issue with diagnostic
          { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
          -- Clear buffer and chat history
          { "<leader>ccl", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
          -- Toggle Copilot Chat Vsplit
          { "<leader>ccv", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle Vsplit" },
        },
    },
    --[[{
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master"},
        },
        build = "make tiktoken",
        keys = 
        {
            { "<leader>cct", "<cmd>CopilotChatToggle<CR>", desc = "CopilotChat -- Toggle Vsplit" },
        },
    },]]
})

