# nvim-config

Configuración de Neovim para **TypeScript (Angular, NestJS)**, **Go** y **Rust**. Funciona en Windows, macOS y Linux.

- Requiere **Neovim ≥ 0.12** (usa `vim.pack`, `vim.lsp.config` y `vim.lsp.enable`).
- LSP: `ts_ls`, `angularls`, `eslint`, `html`, `cssls`, `jsonls`, `yamlls`, `gopls`, `rust_analyzer`, `taplo`, `lua_ls` (Mason los instala solos).
- Formato al guardar con `conform.nvim`: prettier (web), goimports + gofmt (Go), rustfmt (Rust), stylua (Lua).
- Treesitter (rama `main`), fzf-lua, gitsigns, mini.files, lazygit (floaterm), Copilot.

## Estructura

```
init.lua        opciones, keymaps, plugins
lua/dev.lua     LSP, treesitter y formato
ftdetect/ queries/ syntax/   soporte SAP CDS (opcional)
nvim-pack-lock.json          versiones fijadas de los plugins
```

## Instalación

### 1. Instalar Neovim (≥ 0.12)

Comprueba la versión con `nvim --version`. Si es menor que 0.12, esta config no arranca.

#### Windows

```powershell
winget install Neovim.Neovim
```

Alternativas: `scoop install neovim` o `choco install neovim`. También puedes bajar el `.msi` o el `.zip` de <https://github.com/neovim/neovim/releases/latest>. Reabre la terminal para que `nvim` aparezca en el `PATH`.

#### macOS

```sh
brew install neovim
```

Sin Homebrew, baja `nvim-macos-arm64.tar.gz` (Apple Silicon) o `nvim-macos-x86_64.tar.gz` (Intel) desde la página de releases. Si macOS bloquea el binario, ejecuta `xattr -c ./nvim-macos-*.tar.gz` antes de descomprimir.

#### Linux

Los repositorios de las distribuciones suelen traer versiones antiguas (Ubuntu y Debian casi siempre). El método más fiable es el tarball oficial, que sirve en cualquier distro:

```sh
# x86_64 (en ARM usa nvim-linux-arm64.tar.gz)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc   # o ~/.zshrc
```

Otras opciones:

| Distro / método | Comando | Nota |
|---|---|---|
| Arch / Manjaro | `sudo pacman -S neovim` | siempre reciente |
| Fedora | `sudo dnf install neovim` | comprueba la versión |
| openSUSE Tumbleweed | `sudo zypper install neovim` | |
| Snap | `sudo snap install nvim --classic` | reciente |
| Homebrew en Linux | `brew install neovim` | reciente |
| AppImage | `nvim-linux-x86_64.appimage` de la página de releases; `chmod u+x` y ejecútalo | sin FUSE: `--appimage-extract` |

#### WSL

WSL es Linux: instala Neovim con el método de Linux, dentro de la distro. Guarda los proyectos en el disco de Linux (`~/proyectos`), no en `/mnt/c`, porque ahí git, los LSP y `node_modules` van mucho más lentos.

```sh
# portapapeles compartido con Windows
sudo apt install wl-clipboard   # o instala win32yank: https://github.com/equalsraf/win32yank
```

Desde Windows puedes abrir esos archivos en `\\wsl$\Ubuntu\home\<usuario>\proyectos`.

### 2. Clonar la config

| SO | Destino | Comando |
|---|---|---|
| Linux / macOS | `~/.config/nvim` | `git clone https://github.com/parraSebastian91/nvim-config.git ~/.config/nvim` |
| Windows (PowerShell) | `%LOCALAPPDATA%\nvim` | `git clone https://github.com/parraSebastian91/nvim-config.git $env:LOCALAPPDATA\nvim` |

Si ya tienes una config, muévela antes a otra carpeta.

### 3. Dependencias

**Comunes:** git, Node.js (LTS, con npm), un compilador de C, `tree-sitter-cli`, `fzf`, `ripgrep`, `fd`, `lazygit`.
**Lenguajes:** Go (`go`) y Rust (`rustup`, que trae `cargo`, `rustfmt` y `clippy`).
**Opcionales:** `zoxide` (`<leader>fz`), `ast-grep` (`<leader>fa`).

#### macOS (Homebrew)

```sh
brew install git node fzf ripgrep fd lazygit tree-sitter-cli go rustup zoxide ast-grep
rustup-init            # instala la toolchain de Rust
xcode-select --install # compilador C, si no lo tienes
```

#### Ubuntu / Debian

```sh
sudo apt install git curl build-essential unzip fzf ripgrep fd-find golang nodejs npm
# Neovim: instálalo con el tarball oficial (ver paso 1)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
npm install -g tree-sitter-cli
# lazygit: https://github.com/jesseduffield/lazygit#installation
```

En Debian/Ubuntu el binario de `fd` se llama `fdfind`; crea un alias: `ln -s $(which fdfind) ~/.local/bin/fd`.

#### Arch

```sh
sudo pacman -S git base-devel nodejs npm fzf ripgrep fd lazygit tree-sitter-cli go rustup zoxide
rustup default stable
```

#### Windows (winget, en PowerShell)

```powershell
winget install Git.Git OpenJS.NodeJS.LTS junegunn.fzf BurntSushi.ripgrep.MSVC sharkdp.fd JesseDuffield.lazygit GoLang.Go Rustlang.Rustup Microsoft.PowerShell
winget install Microsoft.VisualStudio.2022.BuildTools   # marca "Desktop development with C++" (compilador)
npm install -g tree-sitter-cli
```

- Comprueba los nombres exactos con `winget search <nombre>` si alguno falla.
- Usa **Windows Terminal** con una *Nerd Font*, para los iconos.
- Con `pwsh` instalado, Neovim lo usa como shell. Si no, usa `powershell`.
- Reinicia la terminal después de instalar, para que el `PATH` se actualice.

### 4. Primer arranque

1. Abre `nvim`. `vim.pack` clona los plugins solo (acepta el diálogo con `y`).
2. Mason instala los LSP y las herramientas de formato en segundo plano. Míralo con `:Mason`.
3. Treesitter compila los parsers si `tree-sitter` y el compilador están en el `PATH`.
4. Ejecuta `:checkhealth` para ver qué falta.
5. Para Copilot, ejecuta `:Copilot setup`.

Mason instala `gopls` y `goimports` solo si `go` está en el `PATH`. Para los servidores de Node hace falta `npm`.

## Uso por lenguaje

- **Angular**: los `*.component.html` se detectan como `htmlangular`. `angularls` se activa en proyectos con `@angular/core` en `node_modules`. Ejecuta `npm install` en el proyecto.
- **NestJS**: es TypeScript normal. `ts_ls` y `eslint` funcionan sin configuración extra. Prettier usa el `.prettierrc` del proyecto.
- **Go**: `gopls` con gofumpt, staticcheck e inlay hints. Al guardar corre `goimports` y `gofmt`.
- **Rust**: `rust_analyzer` con clippy. Al guardar corre `rustfmt`.

## Keymaps principales (`<leader>` = espacio)

| Tecla | Acción |
|---|---|
| `<leader><space>` / `<leader>ff` | buscar archivos / live grep |
| `<leader>fs` / `<leader>fS` | símbolos del documento / del workspace |
| `<leader>fx` | diagnósticos del workspace |
| `\` | explorador (mini.files) |
| `gd` / `gi` / `gy` | definición / implementación / tipo |
| `K` / `grr` / `grn` / `gra` / `gO` | hover / referencias / rename / code action / símbolos |
| `]d` / `[d` | siguiente / anterior diagnóstico |
| `<leader>F` o `<leader>fl` | formatear |
| `<leader>ih` | alternar inlay hints |
| `<leader>g` | lazygit |
| `<c-y>` | terminal por directorio |
| `<leader>hs`, `hr`, `hp`, `hb`, `hd` | gitsigns (stage, reset, preview, blame, diff) |
| `]c` / `[c` | siguiente / anterior hunk |
| `<leader>q` | cerrar buffer (forzado) |
| `<leader>p` | actualizar plugins |

## SAP CDS (opcional)

Define estas variables de entorno y se activa el LSP y el parser de CDS:

- `CDS_LSP`: ruta al ejecutable `cds-lsp`.
- `TS_CDS_PATH`: ruta al repo `tree-sitter-cds`.

## Actualizar y respaldar

```sh
# dentro de nvim: <leader>p  (o :lua vim.pack.update())
git add -A && git commit -m "update" && git push
```

`nvim-pack-lock.json` fija las versiones. Cópialo y haz `git pull` en otra máquina para reproducir los mismos plugins.
