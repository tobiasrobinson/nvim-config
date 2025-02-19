return {
    { "nvim-lua/plenary.nvim" },
    -- File explore
    -- nvim-tree.lua - A file explorer tree for neovim written in lua
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            opt = true
        },
        opts = function()
            require("plugins.configs.tree")
        end,
    }
}
