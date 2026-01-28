# Oh My Zsh Plugin Alias Cheat Sheet

This is your personal reference for oh-my-zsh plugin aliases and functions. Keep this handy for quick reference!

## 📋 Your Enabled Plugins

- **git** - Git aliases and functions for common git operations
- **npm** - NPM aliases and completion
- **eza** - Modern replacement for ls with color and icons
- **sudo** - Press ESC twice to add sudo to previous command
- **extract** - Universal archive extractor (tar, zip, gz, etc.)
- **history** - Enhanced history commands and search

---

## 🔧 Git Plugin (Most Important!)

### Basic Operations
| Alias | Command | Description |
|-------|---------|-------------|
| `g` | `git` | Git shortcut |
| `gst` | `git status` | Check status |
| `ga` | `git add` | Add files |
| `gaa` | `git add --all` | Add all files |
| `gc` | `git commit --verbose` | Commit with verbose |
| `gcmsg` | `git commit --message` | Commit with message |
| `gca` | `git commit --verbose --all` | Commit all with verbose |
| `gcam` | `git commit --all --message` | Commit all with message |

### Checkout & Branches
| Alias | Command | Description |
|-------|---------|-------------|
| `gco` | `git checkout` | Checkout branch/file |
| `gcb` | `git checkout -b` | Create and checkout branch |
| `gb` | `git branch` | List branches |
| `gba` | `git branch --all` | List all branches |
| `gbd` | `git branch --delete` | Delete branch |
| `gbD` | `git branch --delete --force` | Force delete branch |

### Push/Pull/Fetch
| Alias | Command | Description |
|-------|---------|-------------|
| `gp` | `git push` | Push to remote |
| `gl` | `git pull` | Pull from remote |
| `gf` | `git fetch` | Fetch from remote |
| `gfo` | `git fetch origin` | Fetch from origin |
| `ggpush` | `git push origin $(current_branch)` | Push current branch |
| `ggpull` | `git pull origin $(current_branch)` | Pull current branch |

### Logs & History
| Alias | Command | Description |
|-------|---------|-------------|
| `glog` | `git log --oneline --decorate --graph` | Pretty log |
| `gloga` | `git log --oneline --decorate --graph --all` | Pretty log all |
| `glo` | `git log --oneline --decorate` | Simple log |
| `glol` | Pretty log with relative dates | Fancy log |
| `glola` | Pretty log with relative dates (all) | Fancy log all |

### Diff & Show
| Alias | Command | Description |
|-------|---------|-------------|
| `gd` | `git diff` | Show changes |
| `gdca` | `git diff --cached` | Show staged changes |
| `gds` | `git diff --staged` | Show staged changes |
| `gsh` | `git show` | Show commit |

### Stash
| Alias | Command | Description |
|-------|---------|-------------|
| `gstl` | `git stash list` | List stashes |
| `gstp` | `git stash pop` | Pop latest stash |
| `gstd` | `git stash drop` | Drop stash |
| `gstc` | `git stash clear` | Clear all stashes |

### Reset & Clean
| Alias | Command | Description |
|-------|---------|-------------|
| `grh` | `git reset` | Reset to commit |
| `grhh` | `git reset --hard` | Hard reset |
| `grhs` | `git reset --soft` | Soft reset |
| `gclean` | `git clean --interactive -d` | Interactive clean |

---

## 📦 NPM Plugin

| Alias | Command | Description |
|-------|---------|-------------|
| `npmg` | `npm i -g` | Global install |
| `npmS` | `npm i -S` | Save dependency |
| `npmD` | `npm i -D` | Save dev dependency |
| `npmR` | `npm run` | Run script |
| `npmrd` | `npm run dev` | Run dev script |
| `npmrb` | `npm run build` | Run build script |
| `npmst` | `npm start` | Start script |
| `npmt` | `npm test` | Test script |
| `npmL` | `npm list` | List packages |
| `npmL0` | `npm ls --depth=0` | List top-level packages |
| `npmO` | `npm outdated` | Show outdated packages |
| `npmU` | `npm update` | Update packages |

---

## 📚 History Plugin

| Alias | Command | Description |
|-------|---------|-------------|
| `h` | `history` | Show history |
| `hl` | `history \| less` | History with paging |
| `hs` | `history \| grep` | Search history |
| `hsi` | `history \| grep -i` | Search history (case insensitive) |

---

## 🗂️ Extract Plugin

| Command | Description |
|---------|-------------|
| `extract <file>` | Extract any archive |
| `x <file>` | Short alias for extract |

**Supports:** .tar, .tar.gz, .tar.bz2, .zip, .rar, .7z, .gz, .bz2, and more!

---

## 🛡️ Sudo Plugin

**Usage:** Press `ESC ESC` to add `sudo` to the previous command

Example:
1. Type: `systemctl restart nginx`
2. Press Enter (command fails due to permissions)
3. Press `ESC ESC`
4. Command becomes: `sudo systemctl restart nginx`

---

## 🎨 Eza Plugin

The eza plugin automatically configures modern `ls` replacement with colors and icons.
Your aliases remain the same (`ls`, `ll`, `la`) but get enhanced visuals.

---

## 💡 Pro Tips

### Git Workflow Examples
```bash
# Quick status check
gst

# Add and commit
ga .
gcmsg "feat: add new feature"

# Create feature branch
gcb feature/new-feature

# Push new branch
gpsup  # pushes and sets upstream

# Quick log check
glog

# Switch back to main and pull
gco main
gl
```

### NPM Workflow Examples
```bash
# Install dependencies
npmS lodash
npmD @types/node

# Run scripts
npmrd  # npm run dev
npmrb  # npm run build
npmt   # npm test

# Check for updates
npmO   # see outdated packages
npmU   # update packages
```

### History Search
```bash
# Search for git commands in history
hs git

# Case insensitive search
hsi docker
```

---

## 🔄 Replaced Aliases in Your .zshrc

These aliases were removed because oh-my-zsh provides better equivalents:

| Removed | Oh-My-Zsh Equivalent | Notes |
|---------|---------------------|-------|
| `push` | `gp` | Shorter and consistent |
| `pull` | `gl` | Shorter and consistent |
| `status` | `gst` | Shorter and consistent |
| `chk` | `gco` | Standard git plugin alias |
| `chkb` | `gcb` | Standard git plugin alias |

**Kept custom aliases:**
- `ph` - Your personal short push alias
- `pl` - Your personal short pull alias  
- `sts` - Even shorter than `gst`
- `commit` - Commitizen specific
- `fetch` - With `--all` flag
- `lg` - LazyGit launcher

---

## 📖 Quick Reference Card

**Most Used Git:**
- `gst` → status
- `ga .` → add all
- `gcmsg "message"` → commit
- `gp` → push
- `gl` → pull
- `gco branch` → checkout
- `gcb branch` → create branch

**Most Used NPM:**
- `npmS package` → install & save
- `npmD package` → install dev dependency
- `npmrd` → run dev
- `npmrb` → run build

**Quick Utils:**
- `h` → history
- `hs term` → search history
- `extract file.zip` → extract archive
- `ESC ESC` → add sudo to last command

---

*Generated by your oh-my-zsh alias checker script*
*Run `./check_ohmyzsh_aliases.sh` to regenerate or check for updates*