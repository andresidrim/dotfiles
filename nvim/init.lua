-- ═══════════════════════════════════════════════════════════════
--  OPTIONS
-- ═══════════════════════════════════════════════════════════════

local opt          = vim.opt
local wo           = vim.wo

opt.number         = true
opt.relativenumber = true
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.expandtab      = true

opt.clipboard      = "unnamedplus"
opt.mouse          = ""
opt.wrap           = true
opt.linebreak      = true
opt.breakindent    = true

opt.autoindent     = true
opt.smartindent    = true

opt.ignorecase     = true
opt.smartcase      = true

opt.scrolloff      = 10
opt.cursorline     = true
opt.hlsearch       = true

opt.swapfile       = false
opt.undofile       = true
opt.writebackup    = false

opt.termguicolors  = true
opt.numberwidth    = 4
opt.fileencoding   = "utf-8"
opt.winborder      = "rounded"

wo.signcolumn      = "yes"

-- ═══════════════════════════════════════════════════════════════
--  PLUGINS
-- ═══════════════════════════════════════════════════════════════

vim.pack.add({
    { src = "https://github.com/mplusp/pack-manager.nvim" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/seblyng/roslyn.nvim" },

    -- UI / Navigation
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/nvim-mini/mini.icons" },

    -- Editing
    { src = "https://github.com/m4xshen/autoclose.nvim" },
    { src = "https://github.com/nvim-mini/mini.completion" },

    -- Treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },

    -- Filetypes
    { src = "https://github.com/stykhomyrov/vim-glsl" },
})

-- ═══════════════════════════════════════════════════════════════
--  COLORS
-- ═══════════════════════════════════════════════════════════════

vim.cmd("colorscheme sunset")

vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })


-- v  Other themes  v

-- # Rose Pine Config # --
-- require("rose-pine").setup({
--     variant = "main",
-- 	disable_italics = true,
--
-- 	styles = {
-- 		bold = false,
--         transparency = true,
-- 	},
-- })
-- vim.cmd("colorscheme rose-pine")

-- # Gruvbox Material Config # --
-- vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_foreground = "material" -- This is a comment
-- vim.g.gruvbox_material_disable_italic_comment = 1
-- vim.g.gruvbox_material_enable_bold = 0
-- vim.g.gruvbox_material_enable_italic = 0
-- vim.g.gruvbox_material_transparent_background = 2
-- vim.cmd("colorscheme gruvbox-material")

-- # Bamboo Config # --
-- require("bamboo").setup({
--     style = "vulgaris",
--     transparent = true,
--
--     code_style = {
--         comments = { italic = false },
--         conditionals = { italic = false },
--         namespaces = { italic = false },
--         parameters = { italic = false },
--     },
--
--     lualine = {
--         transparent = true,
--     }
--  })
-- vim.cmd("colorscheme bamboo")

-- # Tokyo Night Config # --
-- require("tokyonight").setup({
--     style = "moon",
--     transparent = true,
--
--     styles = {
--         comments = { italic = false },
--         keywords = { italic = false },
--     }
-- })
-- vim.cmd("colorscheme tokyonight")

-- # Catppuccin Config # --
-- require("catppuccin").setup({
--     flavour = "mocha",
--     transparent_background = true,
--     styles = {
--         comments = { },
--         conditionals = { }
--     }
-- })
-- vim.cmd("colorscheme catppuccin")

-- # Calvera Dark Config # --
-- vim.g.calvera_italic_comments = false
-- vim.g.calvera_italic_keywords = false
-- vim.g.calvera_italic_functions = false
-- vim.g.calvera_italic_variables = false
-- vim.g.calvera_italic_strings = false
-- vim.g.calvera_transparent_bg = true
-- vim.g.calvera_custom_colors = {
--     green = "#fcc076",
-- }
-- vim.cmd("colorscheme calvera")

-- ═══════════════════════════════════════════════════════════════
--  PLUGIN SETUP
-- ═══════════════════════════════════════════════════════════════

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})

require("mason-lspconfig").setup()

require("roslyn").setup()

require("oil").setup({
    view_options = { show_hidden = true },
    columns = {},
})

require("mini.icons").setup()

require("mini.pick").setup({
    mappings = {
        move_down = "<C-j>",
        move_up   = "<C-k>",
    }
})

require("mini.completion").setup({
    mappings = { force_twostep = '<C-g>' },
    set_vim_settings = true,
})

-- Completion behavior
opt.completeopt = { "menu", "menuone", "noinsert" }
opt.completeopt:remove("noselect")

-- Tab navigation in popup menu
local function imap_expr(lhs, rhs)
    vim.keymap.set("i", lhs, rhs, { expr = true })
end

imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

require("autoclose").setup()

require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    },
})

-- ═══════════════════════════════════════════════════════════════
--  TREESITTER
-- ═══════════════════════════════════════════════════════════════

require("nvim-treesitter.configs").setup({
    auto_install     = true,
    sync_install     = true,

    ensure_installed = {
        "lua", "javascript", "typescript", "tsx",
        "html", "css",
        "c", "cpp", "go",
    },

    highlight        = { enable = true },
    indent           = { enable = true },

    ignore_install   = {},
    modules          = {}
})

-- ═══════════════════════════════════════════════════════════════
--  KEYBINDINGS
-- ═══════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════
--  LEADER
-- ═══════════════════════════════════════════════════════════════

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable space default behavior
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = true, silent = true }

-- ═══════════════════════════════════════════════════════════════
--  GENERAL
-- ═══════════════════════════════════════════════════════════════

-- Reload config
vim.keymap.set("n", "<leader>so", ":so<CR>", opts)

-- Disable <C-q>
vim.keymap.set("n", "<C-q>", "", { silent = true })

-- Signature help
vim.keymap.set({ "n", "i" }, "<C-k>", function()
    vim.lsp.buf.signature_help()
end, { silent = true })

-- Delete without yanking
vim.keymap.set("n", "x", '"_x', opts)

-- Better scrolling (keep cursor centered)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without overwriting register
vim.keymap.set("v", "p", '"_dP', opts)

-- Escape shortcuts
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("t", "<C-c>", "<C-\\><C-n>")


-- ═══════════════════════════════════════════════════════════════
--  LSP
-- ═══════════════════════════════════════════════════════════════

-- Format
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

-- Code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code actions",
})

-- Diagnostics navigation
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

-- Diagnostics UI
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Floating diagnostic",
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
    desc = "Diagnostics list",
})


-- ═══════════════════════════════════════════════════════════════
--  FILE / SEARCH
-- ═══════════════════════════════════════════════════════════════

-- Oil file explorer
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", {
    desc = "Open Oil",
})

-- Restart Neovim
vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>", {
    desc = "Restart Neovim",
})

-- Find files (rg)
vim.keymap.set("n", "<leader>sf", function()
    require("mini.pick").builtin.cli({
        command = {
            "rg",
            "--files",
            "--hidden",
            "--glob", "!.git",
        },
    })
end)

-- Live grep
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<CR>")


vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
})

---@brief
---
--- https://github.com/dotnet/roslyn
--
-- To install the server, compile from source or download as nuget package.
-- Go to `https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.<platform>/overview`
-- replace `<platform>` with one of the following `linux-x64`, `osx-x64`, `win-x64`, `neutral` (for more info on the download location see https://github.com/dotnet/roslyn/issues/71474#issuecomment-2177303207).
-- Download and extract it (nuget's are zip files).
-- - if you chose `neutral` nuget version, then you have to change the `cmd` like so:
--   ```lua
--   cmd = {
--     'dotnet',
--     '<my_folder>/Microsoft.CodeAnalysis.LanguageServer.dll',
--     '--logLevel', -- this property is required by the server
--     'Information',
--     '--extensionLogDirectory', -- this property is required by the server
--     fs.joinpath(uv.os_tmpdir(), 'roslyn_ls/logs'),
--     '--stdio',
--   },
--   ```
--   where `<my_folder>` has to be the folder you extracted the nuget package to.
-- - for all other platforms put the extracted folder to neovim's PATH (`vim.env.PATH`)

local uv = vim.uv
local fs = vim.fs

local group = vim.api.nvim_create_augroup('lspconfig.roslyn_ls', { clear = true })

---@param client vim.lsp.Client
---@param target string
local function on_init_sln(client, target)
    vim.notify('Initializing: ' .. target, vim.log.levels.TRACE, { title = 'roslyn_ls' })
    ---@diagnostic disable-next-line: param-type-mismatch
    client:notify('solution/open', {
        solution = vim.uri_from_fname(target),
    })
end

---@param client vim.lsp.Client
---@param project_files string[]
local function on_init_project(client, project_files)
    vim.notify('Initializing: projects', vim.log.levels.TRACE, { title = 'roslyn_ls' })
    ---@diagnostic disable-next-line: param-type-mismatch
    client:notify('project/open', {
        projects = vim.tbl_map(function(file)
            return vim.uri_from_fname(file)
        end, project_files),
    })
end

---@param client vim.lsp.Client
local function refresh_diagnostics(client)
    for buf, _ in pairs(vim.lsp.get_client_by_id(client.id).attached_buffers) do
        if vim.api.nvim_buf_is_loaded(buf) then
            client:request(
                vim.lsp.protocol.Methods.textDocument_diagnostic,
                { textDocument = vim.lsp.util.make_text_document_params(buf) },
                nil,
                buf
            )
        end
    end
end

local function roslyn_handlers()
    return {
        ['workspace/projectInitializationComplete'] = function(_, _, ctx)
            vim.notify('Roslyn project initialization complete', vim.log.levels.INFO, { title = 'roslyn_ls' })
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            refresh_diagnostics(client)
            return vim.NIL
        end,
        ['workspace/_roslyn_projectNeedsRestore'] = function(_, result, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

            ---@diagnostic disable-next-line: param-type-mismatch
            client:request('workspace/_roslyn_restore', result, function(err, response)
                if err then
                    vim.notify(err.message, vim.log.levels.ERROR, { title = 'roslyn_ls' })
                end
                if response then
                    for _, v in ipairs(response) do
                        vim.notify(v.message, vim.log.levels.INFO, { title = 'roslyn_ls' })
                    end
                end
            end)

            return vim.NIL
        end,
        ['razor/provideDynamicFileInfo'] = function(_, _, _)
            vim.notify(
                'Razor is not supported.\nPlease use https://github.com/tris203/rzls.nvim',
                vim.log.levels.WARN,
                { title = 'roslyn_ls' }
            )
            return vim.NIL
        end,
    }
end

---@type vim.lsp.Config
return {
    name = 'roslyn_ls',
    offset_encoding = 'utf-8',
    cmd = {
        'roslyn',
        '--logLevel',
        'Information',
        '--extensionLogDirectory',
        fs.joinpath(uv.os_tmpdir(), 'roslyn_ls/logs'),
        '--stdio',
    },
    filetypes = { 'cs' },
    handlers = roslyn_handlers(),

    commands = {
        ['roslyn.client.completionComplexEdit'] = function(command, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            local args = command.arguments or {}
            local uri, edit = args[1], args[2]

            ---@diagnostic disable: undefined-field
            if uri and edit and edit.newText and edit.range then
                local workspace_edit = {
                    changes = {
                        [uri.uri] = {
                            {
                                range = edit.range,
                                newText = edit.newText,
                            },
                        },
                    },
                }
                vim.lsp.util.apply_workspace_edit(workspace_edit, client.offset_encoding)
                ---@diagnostic enable: undefined-field
            else
                vim.notify('roslyn_ls: completionComplexEdit args not understood: ' .. vim.inspect(args),
                    vim.log.levels.WARN)
            end
        end,
    },

    root_dir = function(bufnr, cb)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        -- don't try to find sln or csproj for files from libraries
        -- outside of the project
        if not bufname:match('^' .. fs.joinpath('/tmp/MetadataAsSource/')) then
            -- try find solutions root first
            local root_dir = fs.root(bufnr, function(fname, _)
                return fname:match('%.sln[x]?$') ~= nil
            end)

            if not root_dir then
                -- try find projects root
                root_dir = fs.root(bufnr, function(fname, _)
                    return fname:match('%.csproj$') ~= nil
                end)
            end

            if root_dir then
                cb(root_dir)
            end
        else
            -- Decompiled code (example: "/tmp/MetadataAsSource/f2bfba/DecompilationMetadataAsSourceFileProvider/d5782a/Console.cs")
            local prev_buf = vim.fn.bufnr('#')
            local client = vim.lsp.get_clients({
                name = 'roslyn_ls',
                bufnr = prev_buf ~= 1 and prev_buf or nil,
            })[1]
            if client then
                cb(client.config.root_dir)
            end
        end
    end,
    on_init = {
        function(client)
            local root_dir = client.config.root_dir

            -- try load first solution we find
            for entry, type in fs.dir(root_dir) do
                if type == 'file' and (vim.endswith(entry, '.sln') or vim.endswith(entry, '.slnx')) then
                    on_init_sln(client, fs.joinpath(root_dir, entry))
                    return
                end
            end

            -- if no solution is found load project
            for entry, type in fs.dir(root_dir) do
                if type == 'file' and vim.endswith(entry, '.csproj') then
                    on_init_project(client, { fs.joinpath(root_dir, entry) })
                end
            end
        end,
    },

    on_attach = function(client, bufnr)
        -- avoid duplicate autocmds for same buffer
        if vim.api.nvim_get_autocmds({ buffer = bufnr, group = group })[1] then
            return
        end

        vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
            group = group,
            buffer = bufnr,
            callback = function()
                refresh_diagnostics(client)
            end,
            desc = 'roslyn_ls: refresh diagnostics',
        })
    end,

    capabilities = {
        -- HACK: Doesn't show any diagnostics if we do not set this to true
        textDocument = {
            diagnostic = {
                dynamicRegistration = true,
            },
        },
    },
    settings = {
        ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
        },
        ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ['csharp|symbol_search'] = {
            dotnet_search_reference_assemblies = true,
        },
        ['csharp|completion'] = {
            dotnet_show_name_completion_suggestions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_provide_regex_completions = true,
        },
        ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
        },
    },
}
