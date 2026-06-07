# Aztrek's Neovim Config

A modern Neovim 0.12+ configuration with native LSP, Treesitter syntax highlighting, auto-completion, fuzzy finding, format-on-save, and Jupyter notebook support — all managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- **Neovim ≥ 0.12.0** — This config uses the Neovim 0.12 native LSP and Treesitter APIs. Older versions will not work.
- **A terminal with true color support** — [Ghostty](https://ghostty.org/), [Kitty](https://sw.kovidgoyal.net/kitty/), [Alacritty](https://alacritty.org/), or [WezTerm](https://wezfurlong.org/wezterm/) recommended.
- **A [Nerd Font](https://www.nerdfonts.com/)** — Required for icons in the statusline, file explorer, and diagnostics. Install one and set it as your terminal font.

## Installation

### Step 1 — Install System Dependencies

These are the core packages that **must** be installed before opening Neovim.

#### Arch Linux / CachyOS

```bash
sudo pacman -S neovim tree-sitter-cli gcc git curl tar ripgrep fd
```

#### Ubuntu / Debian

```bash
# Neovim 0.12+ is not in default repos — install from the official PPA or download the appimage
# https://github.com/neovim/neovim/releases

sudo apt install gcc git curl tar ripgrep fd-find
```

Then install `tree-sitter-cli` (v0.26.1+):

```bash
# Option A: Using cargo (recommended)
cargo install tree-sitter-cli

# Option B: Download prebuilt binary from GitHub releases
# https://github.com/tree-sitter/tree-sitter/releases
```

#### macOS

```bash
brew install neovim tree-sitter gcc git curl ripgrep fd
```

#### Fedora

```bash
sudo dnf install neovim gcc git curl tar ripgrep fd-find
cargo install tree-sitter-cli
```

### Step 2 — Clone or Copy the Config

```bash
# Back up any existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Place this folder at the Neovim config path
cp -r nvim ~/.config/nvim
```

Or if you're cloning from a git repo:

```bash
git clone <your-repo-url> ~/.config/nvim
```

### Step 3 — Remove Old Plugin Data (Clean Slate)

If you had a previous Neovim setup, clear old plugin and parser data to avoid conflicts:

```bash
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/share/nvim/site/parser
rm -rf ~/.local/share/nvim/site/queries
rm -rf ~/.local/share/nvim/mason
```

### Step 4 — Launch Neovim

```bash
nvim
```

On first launch, **lazy.nvim** will automatically:

1. Bootstrap itself (download the plugin manager).
2. Download and install all plugins.
3. Compile treesitter parsers for 20 languages (bash, c, cpp, css, dart, go, html, javascript, json, lua, make, markdown, markdown\_inline, python, rust, tsx, typescript, vim, vimdoc, yaml).
4. Install LSP servers via Mason (clangd, pylsp, rust\_analyzer, ts\_ls, gopls, lua\_ls).

> **This takes 1–3 minutes on first launch.** Let it finish — you'll see progress messages at the bottom. Once everything is installed, restart Neovim.

### Step 5 — Verify the Setup

Open Neovim and run these health checks:

```vim
:checkhealth nvim-treesitter
:checkhealth mason
:checkhealth lsp
```

Everything should show green ✅ checks. If `tree-sitter-cli` shows as missing, go back to Step 1.

## Optional Dependencies

These are not required for the core editor to work, but specific features depend on them.

### Formatters (for format-on-save)

The config uses [conform.nvim](https://github.com/stevearc/conform.nvim) to auto-format files on save. Install the formatters for the languages you use:

| Language | Formatter | Install Command |
|----------|-----------|----------------|
| Python | `black`, `isort` | `pip install black isort` |
| C/C++ | `clang-format` | Included with `clangd` / `sudo pacman -S clang` |
| Go | `goimports`, `gofmt` | Included with the Go toolchain |
| JS/TS | `prettier` | `npm install -g prettier` |
| Rust | `rustfmt` | Included with `rustup` |
| Lua | `stylua` | `cargo install stylua` |
| Dart | `dart_format` | Included with the Dart SDK |

> If a formatter is missing, the file will still save — it just won't be auto-formatted for that language.

### Dart / Flutter

The Dart LSP (`dartls`) expects the Dart SDK to be installed and `dart` available in your `$PATH`:

```bash
# Arch
sudo pacman -S dart

# macOS
brew install dart-sdk

# Or install via Flutter SDK: https://flutter.dev/docs/get-started/install
```

### Jupyter Notebooks (Molten)

[Molten](https://github.com/benlubas/molten-nvim) provides in-editor Jupyter cell execution. It requires:

```bash
pip install pynvim jupyter_client cairosvg
```

The image rendering backend uses the [Kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/), so you need a terminal that supports it (Ghostty, Kitty, or WezTerm).

After installing, run `:UpdateRemotePlugins` inside Neovim and restart.

### DOSBox + NASM (Assembly Keybinds)

The `<leader>d` and `<leader>r` keybinds for `.asm` files require:

```bash
sudo pacman -S nasm dosbox xdotool
```

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point — loads all config modules
├── lazy-lock.json              # Plugin version lockfile
└── lua/
    ├── config/
    │   ├── options.lua          # Editor settings (tabs, numbers, search, etc.)
    │   ├── keymaps.lua          # All custom keybindings
    │   ├── autocmds.lua         # Autocommands (trailing whitespace removal)
    │   └── lazy.lua             # lazy.nvim plugin manager bootstrap
    └── plugins/
        ├── treesitter.lua       # Syntax highlighting (20 languages)
        ├── lsp.lua              # LSP servers, diagnostics, keybinds
        ├── blink.lua            # Auto-completion engine
        ├── conform.lua          # Format-on-save
        ├── telescope.lua        # Fuzzy finder
        ├── colorscheme.lua      # Themes (Makurai, Tokyo Night, Rosé Pine)
        ├── lualine.lua          # Statusline
        ├── noice.lua            # Enhanced command palette UI
        ├── autopairs.lua        # Auto-close brackets and quotes
        ├── lazydev.lua          # Lua development helpers
        ├── image.lua            # In-terminal image rendering
        └── molten.lua           # Jupyter notebook integration
```

## Keybindings

**Leader key:** `Space`

### General

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>pv` | Normal | Open Netrw file explorer |
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `<C-d>` | Normal | Scroll down (centered) |
| `<C-u>` | Normal | Scroll up (centered) |
| `J` / `K` | Visual | Move selected block down / up |
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Equalize split sizes |
| `<leader>sx` | Normal | Close current split |
| `<C-h/j/k/l>` | Normal | Navigate between splits |

### Telescope (Fuzzy Finder)

| Keybind | Description |
|---------|-------------|
| `<leader>pf` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |

### LSP

| Keybind | Description |
|---------|-------------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gr` | Find references (Telescope) |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format file |
| `gl` | Show diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |

### Molten (Jupyter)

| Keybind | Mode | Description |
|---------|------|-------------|
| `<localleader>mi` | Normal | Initialize Molten kernel |
| `<localleader>e` | Normal | Evaluate operator |
| `<localleader>rl` | Normal | Evaluate current line |
| `<localleader>rc` | Normal | Re-evaluate cell |
| `<localleader>r` | Visual | Evaluate selection |
| `<localleader>os` | Normal | Show output |
| `<localleader>oh` | Normal | Hide output |
| `<localleader>md` | Normal | Delete cell |

### Compile & Run

| Keybind | Description |
|---------|-------------|
| `<leader>r` | Compile and run current `.c` or `.asm` file |
| `<leader>d` | Compile `.asm` and open in DOSBox with AFD debugger |

## Colorscheme

The default colorscheme is **Makurai Dark** with transparency enabled. Two alternatives are also installed:

- `:colorscheme tokyonight-storm` — Tokyo Night
- `:colorscheme rose-pine` — Rosé Pine

## Troubleshooting

### No syntax highlighting

1. Check that `tree-sitter-cli` is installed: `tree-sitter --version`
2. Open Neovim and run `:checkhealth nvim-treesitter`
3. If parsers are missing, run `:TSInstall all` or restart Neovim to trigger auto-install

### LSP not attaching

1. Run `:checkhealth lsp` to see which servers are active
2. Run `:Mason` to verify servers are installed — press `i` to install any missing ones
3. Make sure the language toolchain is installed (e.g., `go` for gopls, `rustup` for rust\_analyzer)

### Icons look broken

Install a [Nerd Font](https://www.nerdfonts.com/) and set it as your terminal's font. Recommended: **JetBrainsMono Nerd Font**.

### Plugin errors on startup

```bash
# Nuclear option: wipe all plugin data and start fresh
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/share/nvim/site
rm -rf ~/.local/share/nvim/mason
nvim
```
