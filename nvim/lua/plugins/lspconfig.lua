return {
    {
        "neovim/nvim-lspconfig",

        opts = {
            inlay_hints = {
                enabled = false,
            },
            servers = {
                clangd = {},
                rust_analyzer = {},
                gopls = {},
            },
        },
    },
}
