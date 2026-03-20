# Neovim Configuration

A Neovim configuration tailored for professional Python, web, shell, SQL, Docker, and Kubernetes work with LSP, Treesitter, Telescope, Mason, and a reduced language footprint.

## Features

- **Focused Language Support**: JavaScript/TypeScript, Python, HTML/CSS, shell, SQL, Docker, and Kubernetes YAML
- **Intelligent Autocompletion**: LSP-powered completion with snippets and multiple sources
- **Advanced Search**: Fuzzy file finding and live grep with Telescope
- **Modern Syntax Highlighting**: Tree-sitter based parsing for the included Python and web stack
- **Professional File Management**: Feature-rich file explorer with Git integration
- **Code Navigation**: LSP-integrated go-to-definition, references, and diagnostics
- **Automatic Tool Management**: Mason handles LSP server installation and updates

## Prerequisites

- **Neovim**: modern release with built-in LSP support
- **Git**: for plugin management and repository operations
- **Node.js**: required for TypeScript/JavaScript-related tooling
- **Ripgrep**: used by Telescope for live grep
- **A Nerd Font**: for file explorer and completion icons

Optional but useful:

- **fd**: improves Telescope file-finding
- **shellcheck**: enables better Bash diagnostics
- Python tooling for your preferred formatter/linter workflow
- Shell tooling if you want `bashls`, `shellcheck`, and `shfmt` to run successfully

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

5. **Install language servers**: Mason manages the configured servers. Open `:Mason` to inspect or install anything missing.

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
│       ├── markdown-preview.lua     # Markdown preview
│       ├── plenary.lua              # Lua utilities
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
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gt` - Go to type definition
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
- **JavaScript/TypeScript**: Full LSP support with `ts_ls`
- **HTML/CSS**: Complete markup and styling support
- **Emmet**: HTML/CSS abbreviation expansion

### Python
- **Python**: LSP support with `pyright`, formatting with `black`, and import sorting with `isort`

### Infrastructure And Shell
- **Bash/Zsh**: Shell support via `bashls`, `shellcheck`, and `shfmt`
- **SQL**: Query and schema editing support via `sqlls`
- **Docker**: Dockerfile support via `dockerls`
- **Kubernetes**: YAML support via `yamlls` with Kubernetes manifest schema matching

### Config Maintenance
- **Lua**: Minimal editor-config support for maintaining this Neovim setup itself

## Formatting

- `none-ls` handles configured external formatters such as `stylua`, `black`, `isort`, `prettier`, and `shfmt`

## Notes

- LSP keymaps are attached buffer-locally when a server connects, so commands like `<leader>ca` and `<leader>rn` require an active LSP client in the current buffer.
- This branch intentionally removes language tooling outside Python and the core web stack.

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
- Check `:messages` and `~/.local/state/nvim/lsp.log` for server startup failures

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

*This configuration is optimized for Python and web development with a deliberately smaller tooling surface.*
