# 🎯 vxVim Key Bindings

Complete reference for all key bindings in vxVim configuration.

## Leader Key: `<Space>`

### 📁 File & Buffer Management
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>e` | `:NvimTreeToggle` | Toggle file explorer |
| `<Leader>q` | `:q` | Quit buffer |
| `<Leader>n` | `:set number!` | Toggle line numbers |
| `<Leader>ww` | `:w` | Save buffer |
| `<Leader>wa` | `:wa` | Save all buffers |
| `<Leader>wq` | `:wq` | Save and quit |

### 🔍 Search & Find (Telescope)
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>ff` | `find_files` | Find files |
| `<Leader>fg` | `live_grep` | Search text in files |
| `<Leader>fb` | `buffers` | Find open buffers |
| `<Leader>fr` | `oldfiles` | Find recent files |
| `<Leader>fe` | `help_tags` | Find help documentation |
| `<Leader>fc` | `git_commits` | Find Git commits |
| `<Leader>fh` | `:nohlsearch` | Clear search highlight |

### 🔧 Code & LSP
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>ca` | `code_action` | Show code actions |
| `<Leader>cl` | `diagnostic.open_float` | Show diagnostics |
| `gd` | `definition` | Go to definition |
| `gr` | `references` | Show references |
| `gy` | `type_definition` | Go to type definition |
| `gl` | `diagnostic.open_float` | Show line diagnostics |

### 🔄 Refactoring
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>rr` | `:%s//g` | Replace in file |
| `<Leader>rp` | `Spectre` | Advanced find & replace |

### 💬 Comments
| Key | Action | Description |
|-----|--------|-------------|
| `<C-i>` | `Comment.toggle` | Toggle line comment |
| `<Leader>ac` | `comment-box` | Create comment box |
| `]t` | `todo-comments.jump_next` | Next TODO comment |
| `[t` | `todo-comments.jump_prev` | Previous TODO comment |

### 🖥️ Terminal
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>tf` | `ToggleTerm float` | Floating terminal |
| `<Leader>th` | `ToggleTerm horizontal` | Horizontal terminal |
| `<Leader>tv` | `ToggleTerm vertical` | Vertical terminal |
| `jk` (in terminal) | Exit terminal mode | Back to normal mode |

### 🐛 Debugging
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>dd` | `dapui.toggle` | Toggle debugger UI |
| `<Leader>db` | `dap.toggle_breakpoint` | Toggle breakpoint |
| `<Leader>dc` | `dap.set_breakpoint` | Conditional breakpoint |
| `<Leader>d<space>` | `dap.continue` | Continue debugging |
| `<Leader>dl` | `dap.step_into` | Step into |
| `<Leader>dj` | `dap.step_over` | Step over |
| `<Leader>dk` | `dap.step_out` | Step out |
| `<Leader>de` | `dap.terminate` | Terminate session |
| `<Leader>dr` | `dap.run_last` | Run last configuration |

### 🌿 Git
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>gd` | `DiffviewOpen` | File history |
| `<Leader>gS` | `DiffviewOpen` | Git status |

### 💾 Sessions
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>psl` | `SessionManager load_session` | Load session |
| `<Leader>psL` | `SessionManager load_last_session` | Load last session |
| `<Leader>pss` | `SessionManager save_current_session` | Save session |
| `<Leader>psm` | `SessionManager available_commands` | Session commands |

### 📐 Splits
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>sh` | `:split` | Horizontal split |
| `<Leader>sv` | `:vsplit` | Vertical split |

## Dashboard Keys

| Key | Action | Description |
|-----|--------|-------------|
| `f` | `Telescope find_files` | Find files |
| `w` | `Telescope live_grep` | Find word |
| `h` | `Telescope oldfiles` | Recent files |
| `l` | `SessionManager load_last_session` | Load last session |
| `p` | `Lazy` | Manage plugins |
| `u` | `VxVimUpdate` | Update core |
| `<Esc>` | `exit` | Exit Neovim |

## Basic Navigation & Editing

### Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `jk` | `<ESC>` | Exit insert mode |
| `H` | `^` | Go to line start |
| `L` | `g_` | Go to line end |
| `<C-h/j/k/l>` | Window navigation | Move between windows |
| `<Tab>` | `BufferLineCycleNext` | Next buffer |
| `<S-Tab>` | `BufferLineCyclePrev` | Previous buffer |

### Editing Improvements
| Key | Action | Description |
|-----|--------|-------------|
| `v` + `p` | Paste without yank | Paste over selection without copying |
| `x` / `X` | Delete without yank | Delete character without copying |
| `v` + `K` | Move selection up | Move selected lines up |
| `v` + `J` | Move selection down | Move selected lines down |
| `v` + `<` / `>` | Indent left/right | Indent selection and keep selected |

### TreeSitter Selection
| Key | Action | Description |
|-----|--------|-------------|
| `gnn` | Init selection | Start incremental selection |
| `grn` | Node incremental | Expand selection to next node |
| `grm` | Node decremental | Shrink selection to previous node |
| `grc` | Scope incremental | Expand selection to next scope |

### Folding
| Key | Action | Description |
|-----|--------|-------------|
| `zR` | `ufo.openAllFolds` | Open all folds |
| `zM` | `ufo.closeAllFolds` | Close all folds |
| `zr` | `ufo.openFoldsExceptKinds` | Open folds (except some) |

### System Integration
| Key | Action | Description |
|-----|--------|-------------|
| `gx` | Open link | Open URL under cursor in browser |

## Which-Key Groups

vxVim uses which-key to organize bindings into logical groups:

- `<leader>c` - 🔧 Code/LSP
- `<leader>d` - 🐛 Debug
- `<leader>f` - 🔍 Find/Search
- `<leader>g` - 🌿 Git
- `<leader>p` - 💾 Sessions
- `<leader>r` - 🔄 Refactor
- `<leader>s` - 📐 Splits
- `<leader>t` - 🖥️ Terminal
- `<leader>w` - 📁 Buffer
- `<leader>a` - 💬 Actions

## Terminal Mode Bindings

When in terminal mode, these additional bindings are available:

| Key | Action | Description |
|-----|--------|-------------|
| `<Esc>` | `<C-\><C-n>` | Exit terminal mode |
| `<C-h>` | `<C-\><C-n><C-W>h` | Move to left window |
| `<C-j>` | `<C-\><C-n><C-W>j` | Move to bottom window |
| `<C-k>` | `<C-\><C-n><C-W>k` | Move to top window |
| `<C-l>` | `<C-\><C-n><C-W>l` | Move to right window |

## Tips

- **Which-Key**: Press `<Leader>` and wait to see available options
- **Telescope**: Most search functions support live preview
- **LSP**: Hover over symbols to see documentation
- **Terminal**: Use `jk` or `<Esc>` to exit terminal mode
- **Comments**: `<C-i>` works in both normal and visual mode
- **Debugging**: Set breakpoints before starting debug session
- **Git**: Use `<Leader>gd` to see file history with diff view 