# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io). Portable between macOS, Ubuntu, and WSL2 Ubuntu.

## Bootstrap

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply hovissimo
```

This installs chezmoi to `~/.local/bin`, clones this repo, and applies it to `$HOME`. You'll need `~/.local/bin` on your `PATH`.

After apply: switch login shell to zsh (`chsh -s $(which zsh)`).

## Ubuntu / WSL2: install dependencies

Most of the config assumes these binaries exist. Anything missing is guarded with `command -v` checks, so a partial install won't break your shell.

### Required (zsh + vim baseline)

```sh
sudo apt update
sudo apt install -y \
  zsh \
  vim \
  git \
  curl \
  ca-certificates \
  build-essential \
  ripgrep \
  uuid-runtime \
  fzf
```

- `ripgrep` → `:grep` in vim
- `uuid-runtime` → `<leader>uu` in vim
- `fzf` → vim fuzzy finder + zsh fzf-git integration

### GitHub CLI (used by gitconfig credential helper)

```sh
(type -p wget >/dev/null || sudo apt install wget -y) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
gh auth login
```

### starship (prompt)

```sh
curl -sS https://starship.rs/install.sh | sh
```

### direnv

```sh
sudo apt install -y direnv
```

### asdf (version manager)

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
```

`~/.zshrc` already sets `ASDF_DATA_DIR` and adds shims to `PATH`. Plugins/installs go in your `.tool-versions` per-project (which is `.chezmoiignore`d intentionally).

### Node / npm

Install via asdf rather than apt (apt's node is usually old):

```sh
asdf plugin add nodejs
asdf install nodejs lts
asdf global nodejs lts
```

`~/.zshrc` sets `npm_config_prefix=$HOME/.local/npm-packages` so global installs don't need root.

### Docker

Docker Engine on Ubuntu: [official docs](https://docs.docker.com/engine/install/ubuntu/). On WSL2, prefer Docker Desktop on Windows with WSL integration enabled.

### Optional but referenced

```sh
sudo apt install -y \
  ffmpeg \
  terraform \
  kubectl
```

### Vim plugins (vim-plug)

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
```

### Elixir LSP (optional)

[expert](https://github.com/elixir-tools/expert) goes at `~/.local/bin/expert`. The vimrc references it with `expand('~/.local/bin/expert')` so it works on any OS.

### Codeium (vim AI completion)

First time you open vim, run `:Codeium Auth` and follow the browser flow.

## WSL2-specific

- Mount your Windows user dir as needed via `/mnt/c/Users/<you>/`.
- For SSH keys backed by 1Password Windows, set:
  ```sh
  export SSH_AUTH_SOCK=$HOME/.1password/agent.sock
  ```
  in a `~/.zshrc_local` (or directly in `~/.zshrc_instinct` if work-tied), and run `npiperelay` + a socat bridge — see [1Password docs](https://developer.1password.com/docs/ssh/agent/compatibility/#windows).
- Install a Nerd Font in Windows Terminal / kitty for starship glyphs.

## Local-only files (not in this repo)

The following are `.chezmoiignore`d. Don't put secrets or company IP in version control.

| File | Purpose |
|---|---|
| `~/.zshrc_instinct` | Instinct work env (Jira/GitHub package tokens, DB URLs, Datadog key). Source from 1Password when possible. |
| `~/.tool-versions` | asdf per-host pins |
| `~/.zprofile` | login-shell env, per-host |
| `~/.sqlfluff`, `~/.yarnrc` | tool-managed |
| `~/.anthropic_api_key`, `~/.jira_api_token`, `~/.gh_access_token` | secret files — prefer `op read` injection |
| `~/.claude.json*` | Claude CLI state |

## macOS notes (for reference)

```sh
brew install chezmoi git vim ripgrep fzf starship direnv gh asdf node ffmpeg terraform kubectl
```

`.zshrc` already wraps Mac-only paths (1Password SSH agent, Zig keg-only, Docker Desktop completions) in an `OSTYPE` guard so they're silently skipped on Linux.
