# Husk Language Support for Neovim

Syntax highlighting for the Husk programming language in Neovim.

## Installation

### Using a Plugin Manager

#### vim-plug

```vim
Plug 'fcoury/husk.nvim', { 'rtp': 'nvim' }
```

#### packer.nvim

```lua
use { 'fcoury/husk.nvim', rtp = 'nvim' }
```

#### lazy.nvim

```lua
{
  'fcoury/husk.nvim',
  config = function()
    vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/lazy/husk.nvim/nvim')
  end
}
```

### Manual Installation

1. Clone this repository
2. Copy the contents of the `nvim` directory to your Neovim configuration:

```bash
cp -r nvim/* ~/.config/nvim/
```

Or if you prefer to keep it separate:

```bash
mkdir -p ~/.local/share/nvim/site/pack/husk/start/husk-vim
cp -r nvim/* ~/.local/share/nvim/site/pack/husk/start/husk-vim/
```

## Features

- Syntax highlighting for:
  - Keywords (`let`, `fn`, `struct`, `enum`, `if`, `match`, `for`, `while`, `use`, etc.)
  - Types (`int`, `float`, `bool`, `string`)
  - Comments (line and block)
  - Strings and numbers
  - Functions and methods
  - Operators
  - Use statements with `local::` support
- File type detection for `.husk` and `.hk` files
- Automatic indentation
- Comment formatting support
- **Format on save** (requires `huskc` in PATH)

## Usage

The plugin will automatically activate for files with `.husk` or `.hk` extensions.

## Format on Save

Files are automatically formatted with `huskc fmt` when saved. This requires `huskc` to be installed and available in your PATH.

### Disable Format on Save

To disable auto-formatting, add this to your Neovim config:

```vim
let g:husk_format_on_save = 0
```

Or in Lua:

```lua
vim.g.husk_format_on_save = 0
```

### Manual Formatting

You can manually format the current file with the `:HuskFmt` command.
