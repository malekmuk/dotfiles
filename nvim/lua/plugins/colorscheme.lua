-- github theme palettes and specs
-- local palettes = {
--     all = {
--         red = {
--             base = "#ff3333",
--             bright = "#ff3333",
--         },
--     },
-- }
--
-- local myred = "#ff3333"
-- local specs = {
--     github_dark_default = {
--         syntax = {
--             keyword = myred,
--             operator = myred,
--             builtin0 = myred, -- built in variable
--             builtin1 = myred, -- built in type
--             builtin2 = myred, -- built in const
--         },
--     },
-- }

local mocha = require("catppuccin.palettes").get_palette("mocha")

return {
    -- { "martinsione/darkplus.nvim" },

    -- {
    --     "projekt0n/github-nvim-theme",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("github-theme").setup({
    --             -- options = {
    --             --     styles = {
    --             --         keywords = "bold",
    --             --     },
    --             -- },
    --             -- palettes = palettes,
    --             specs = specs,
    --         })
    --     end,
    -- },

    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        require("catppuccin").setup({
            no_italic = true, -- Force no italic
            color_overrides = {
                mocha = {
                    base = mocha.crust,
                },
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        }),
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-mocha",
        },
    },
}
