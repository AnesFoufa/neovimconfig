# Neovim Configuration

A modern, feature-rich Neovim configuration optimized for polyglot development with strong support for web development, systems programming, and functional languages.

## Features

- **Multi-language Support**: TypeScript/JavaScript, Python, Rust, Go, Haskell, OCaml, Elixir, C/C++, and more
- **Intelligent Autocompletion**: LSP-powered completion with snippets and multiple sources
- **Advanced Search**: Fuzzy file finding and live grep with Telescope
- **Modern Syntax Highlighting**: Tree-sitter based parsing for 25+ languages
- **Professional File Management**: Feature-rich file explorer with Git integration
- **Code Navigation**: LSP-integrated go-to-definition, references, and diagnostics
- **Automatic Tool Management**: Mason handles LSP server installation and updates

## Prerequisites

- **Neovim**: Version 0.8+ required
- **Git**: For plugin management and repository operations
- **Node.js**: Required for TypeScript/JavaScript LSP servers
- **Ripgrep**: For fast text searching (install via `brew install ripgrep`)
- **A Nerd Font**: For proper icon display in file explorer and completion menu

## Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Wait for plugins to install**: Lazy.nvim will automatically download and install all plugins on first launch.

5. **Install language servers**: Mason will automatically install configured LSP servers when you first open supported file types.

## Project Structure

```
~/.config/nvim/
├── init.lua                          # Entry point
├── lazy-lock.json                    # Plugin version lockfile
├── lua/foufa/
│   ├── core/
│   │   ├── init.lua                  # Core module loader
│   │   ├── keymaps.lua               # Global keymaps
│   │   └── options.lua               # Neovim options
│   ├── lazy.lua                      # Plugin manager setup
│   └── plugins/
│       ├── init.lua                  # Empty plugin file
│       ├── colorscheme.lua           # Theme configuration
│       ├── telescope.lua             # Fuzzy finder
│       ├── nvim-cmp.lua             # Autocompletion
│       ├── nvim-tree.lua            # File explorer
│       ├── nvim-treesitter.lua      # Syntax highlighting
│       ├── diagflow.nvim            # Diagnostic display
│       ├── haskell-tools.lua        # Haskell support
│       ├── markdown-preview.lua     # Markdown preview
│       ├── plenary.lua              # Lua utilities
│       ├── sclametals.lua           # Scala metals
│       └── lsp/
│           ├── lspconfig.lua        # LSP server configurations
│           ├── mason.lua            # LSP installer
│           └── none-ls.lua          # Additional formatters/linters
└── spell/                           # Custom spelling dictionaries
```

## Key Bindings

### Global
- **Leader Key**: `<Space>`

### File Operations
- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Toggle explorer focused on current file
- `<leader>ec` - Collapse file explorer
- `<leader>er` - Refresh file explorer

### Search and Navigation
- `<leader>ff` - Find files
- `<leader>fr` - Find recent files
- `<leader>fs` - Live grep (search in files)
- `<leader>fc` - Find string under cursor

### LSP Features
- `gd` - Go to definition
- `gi` - Go to implementation
- `gR` - Show references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>D` - Show buffer diagnostics
- `<leader>d` - Show line diagnostics
- `<leader>rs` - Restart LSP

### Code Completion
- `<C-Space>` - Trigger completion
- `<C-e>` - Close completion menu
- `<Enter>` - Confirm selection

### Treesitter Navigation
- `<C-Space>` - Incremental selection
- `<Backspace>` - Shrink selection
- `]f` / `[f` - Next/previous function
- `]c` / `[c` - Next/previous class

## Language Support

### Web Development
- **TypeScript/JavaScript**: Full LSP support with ts_ls
- **HTML/CSS**: Complete markup and styling support
- **TailwindCSS**: Utility-first CSS framework support
- **GraphQL**: Schema and query support
- **Emmet**: HTML/CSS abbreviation expansion

### Systems Programming
- **Rust**: Complete development environment with rust-analyzer
- **C/C++**: Modern C/C++ support via clangd
- **Go**: Full Go development support

### Functional Programming
- **Haskell**: Advanced tooling via haskell-tools.nvim
- **OCaml**: Native OCaml development support
- **Elixir**: Full support via Lexical language server

### Scripting & Others
- **Python**: Complete Python development with pyright
- **Lua**: Enhanced Lua support for Neovim configuration
- **Bash**: Shell scripting support
- **Prisma**: Database schema support

## Customization

### Adding New Language Support

1. Add the LSP server to the ensure_installed list in `lua/foufa/plugins/lsp/mason.lua`
2. Configure the server in `lua/foufa/plugins/lsp/lspconfig.lua`
3. Add the language parser to `lua/foufa/plugins/nvim-treesitter.lua`

### Changing the Colorscheme

Edit `lua/foufa/plugins/colorscheme.lua` and modify the `vim.cmd.colorscheme()` call.

### Adding Custom Keymaps

Add your keymaps to `lua/foufa/core/keymaps.lua`.

## Plugin Management

This configuration uses [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management:

- **Update plugins**: `:Lazy update`
- **View plugin status**: `:Lazy`
- **Clean unused plugins**: `:Lazy clean`

## Language Server Management

Uses [Mason.nvim](https://github.com/williamboman/mason.nvim) for automatic LSP server management:

- **View installed servers**: `:Mason`
- **Install server manually**: `:MasonInstall <server_name>`
- **Update all tools**: `:MasonUpdate`

## Troubleshooting

### Plugins Not Loading
- Run `:Lazy sync` to sync plugin installations
- Check `:checkhealth` for system issues

### LSP Not Working
- Verify language server installation with `:Mason`
- Check LSP status with `:LspInfo`
- Restart LSP with `<leader>rs`

### Performance Issues
- Check startup time with `nvim --startuptime startup.log`
- Consider disabling unused languages in Treesitter configuration

## Contributing

This is a personal configuration, but feel free to fork and adapt it to your needs. Key areas for customization:

1. **Language Support**: Add/remove languages as needed
2. **Keybindings**: Modify to match your workflow
3. **Plugins**: Add functionality or replace existing plugins
4. **Theme**: Switch colorschemes or customize the current one

---

*This configuration is optimized for modern development workflows with a focus on language diversity and developer experience.*