-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        -- Install parsers + query files for all languages you use.
        -- This is a no-op for already-installed parsers.
        -- Runs asynchronously in the background.
        require("nvim-treesitter").install({
            "bash",
            "c",
            "cpp",
            "css",
            "dart",
            "go",
            "html",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "rust",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        })

        -- Enable treesitter-based syntax highlighting for all supported buffers.
        -- This is the official method from the nvim-treesitter README (main branch).
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
