#!/bin/bash

# Quick Alias Reminder Script
# Shows the most commonly used oh-my-zsh aliases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

print_color() {
    printf "${1}%s${NC}\n" "$2"
}

print_header() {
    echo ""
    print_color $BLUE "═══════════════════════════════════════"
    print_color $BLUE "  $1"
    print_color $BLUE "═══════════════════════════════════════"
}

show_git_aliases() {
    print_header "🚀 MOST USED GIT ALIASES"

    echo "Basic Operations:"
    printf "  %-8s → %-25s %s\n" "gst" "git status" "Check status"
    printf "  %-8s → %-25s %s\n" "ga ." "git add ." "Add all files"
    printf "  %-8s → %-25s %s\n" "gaa" "git add --all" "Add all files"
    printf "  %-8s → %-25s %s\n" "gcmsg" "git commit -m" "Commit with message"
    printf "  %-8s → %-25s %s\n" "gca" "git commit -a" "Commit all changes"

    echo ""
    echo "Push/Pull/Fetch:"
    printf "  %-8s → %-25s %s\n" "gp" "git push" "Push to remote"
    printf "  %-8s → %-25s %s\n" "gl" "git pull" "Pull from remote"
    printf "  %-8s → %-25s %s\n" "gf" "git fetch" "Fetch from remote"
    printf "  %-8s → %-25s %s\n" "gpsup" "git push -u origin branch" "Push & set upstream"

    echo ""
    echo "Branches:"
    printf "  %-8s → %-25s %s\n" "gb" "git branch" "List branches"
    printf "  %-8s → %-25s %s\n" "gco" "git checkout" "Switch branch/file"
    printf "  %-8s → %-25s %s\n" "gcb" "git checkout -b" "Create & switch branch"
    printf "  %-8s → %-25s %s\n" "gbd" "git branch -d" "Delete branch"

    echo ""
    echo "Logs & Diffs:"
    printf "  %-8s → %-25s %s\n" "glog" "git log --graph" "Pretty log"
    printf "  %-8s → %-25s %s\n" "glo" "git log --oneline" "Simple log"
    printf "  %-8s → %-25s %s\n" "gd" "git diff" "Show changes"
    printf "  %-8s → %-25s %s\n" "gdca" "git diff --cached" "Show staged changes"
}

show_npm_aliases() {
    print_header "📦 NPM ALIASES"

    printf "  %-8s → %-25s %s\n" "npmS" "npm install -S" "Install & save"
    printf "  %-8s → %-25s %s\n" "npmD" "npm install -D" "Install dev dependency"
    printf "  %-8s → %-25s %s\n" "npmg" "npm install -g" "Global install"
    printf "  %-8s → %-25s %s\n" "npmrd" "npm run dev" "Run dev script"
    printf "  %-8s → %-25s %s\n" "npmrb" "npm run build" "Run build script"
    printf "  %-8s → %-25s %s\n" "npmt" "npm test" "Run tests"
    printf "  %-8s → %-25s %s\n" "npmst" "npm start" "Start application"
    printf "  %-8s → %-25s %s\n" "npmO" "npm outdated" "Check outdated packages"
}

show_utility_aliases() {
    print_header "🛠️  UTILITY ALIASES"

    echo "History:"
    printf "  %-12s → %-25s %s\n" "h" "history" "Show command history"
    printf "  %-12s → %-25s %s\n" "hs <term>" "history | grep" "Search history"
    printf "  %-12s → %-25s %s\n" "hsi <term>" "history | grep -i" "Search (case insensitive)"

    echo ""
    echo "Archive Extraction:"
    printf "  %-12s → %-25s %s\n" "extract <file>" "extract function" "Extract any archive"
    printf "  %-12s → %-25s %s\n" "x <file>" "extract function" "Short extract alias"

    echo ""
    echo "Sudo:"
    printf "  %-12s → %-25s %s\n" "ESC ESC" "add sudo to prev cmd" "Add sudo to last command"
}

show_custom_aliases() {
    print_header "🎯 YOUR CUSTOM ALIASES"

    echo "Git (Custom):"
    printf "  %-12s → %-30s %s\n" "ph" "git push" "Short push"
    printf "  %-12s → %-30s %s\n" "pl" "git pull" "Short pull"
    printf "  %-12s → %-30s %s\n" "sts" "git status" "Shortest status"
    printf "  %-12s → %-30s %s\n" "commit" "git cz c" "Commitizen commit"
    printf "  %-12s → %-30s %s\n" "fetch" "git fetch --all" "Fetch all remotes"
    printf "  %-12s → %-30s %s\n" "lg" "lazygit" "LazyGit TUI"
    printf "  %-12s → %-30s %s\n" "greset" "git reset --hard HEAD" "Hard reset"

    echo ""
    echo "Development:"
    printf "  %-12s → %-30s %s\n" "rundev" "npm run dev" "Start dev server"
    printf "  %-12s → %-30s %s\n" "cd" "z" "Smart directory jump"
    printf "  %-12s → %-30s %s\n" "refresh" "source ~/.zshrc" "Reload shell config"

    echo ""
    echo "FZF Enhanced:"
    printf "  %-12s → %-30s %s\n" "branch" "git branch | fzf | xargs git co" "Interactive branch switch"
    printf "  %-12s → %-30s %s\n" "tag" "git tag | fzf | xargs git co" "Interactive tag switch"
}

show_workflow_examples() {
    print_header "🔄 COMMON WORKFLOWS"

    print_color $YELLOW "Git Feature Branch Workflow:"
    echo "  1. gst                    # Check status"
    echo "  2. gcb feature/new-thing  # Create feature branch"
    echo "  3. ga .                   # Add changes"
    echo "  4. gcmsg 'Add feature'    # Commit with message"
    echo "  5. gpsup                  # Push and set upstream"
    echo "  6. gco main               # Switch back to main"
    echo "  7. gl                     # Pull latest"

    echo ""
    print_color $YELLOW "NPM Development Workflow:"
    echo "  1. npmS lodash           # Install dependency"
    echo "  2. npmD @types/lodash    # Install dev dependency"
    echo "  3. npmrd                 # Start dev server"
    echo "  4. npmt                  # Run tests"
    echo "  5. npmrb                 # Build for production"

    echo ""
    print_color $YELLOW "Quick Git Status Check:"
    echo "  gst && glog -5           # Status + last 5 commits"
}

show_tips() {
    print_header "💡 PRO TIPS"

    print_color $GREEN "• Use tab completion with all aliases"
    print_color $GREEN "• Combine aliases: gaa && gcmsg 'Quick commit'"
    print_color $GREEN "• Use glog for visual branch history"
    print_color $GREEN "• ESC ESC works with any previous command"
    print_color $GREEN "• Extract works with .tar, .zip, .gz, .rar, .7z"
    print_color $GREEN "• Use hs <term> to quickly find old commands"
}

# Main function
main() {
    case "${1:-}" in
        git|g)
            show_git_aliases
            ;;
        npm|n)
            show_npm_aliases
            ;;
        util|u)
            show_utility_aliases
            ;;
        custom|c)
            show_custom_aliases
            ;;
        workflow|w)
            show_workflow_examples
            ;;
        tips|t)
            show_tips
            ;;
        --help|-h|help)
            print_color $BLUE "Alias Reminder Usage:"
            echo "  $(basename $0)           Show all aliases"
            echo "  $(basename $0) git       Show git aliases only"
            echo "  $(basename $0) npm       Show npm aliases only"
            echo "  $(basename $0) util      Show utility aliases only"
            echo "  $(basename $0) custom    Show your custom aliases"
            echo "  $(basename $0) workflow  Show common workflows"
            echo "  $(basename $0) tips      Show pro tips"
            ;;
        *)
            print_color $CYAN "Oh My Zsh Alias Quick Reference"
            print_color $CYAN "Run with: aliases [git|npm|util|custom|workflow|tips]"

            show_git_aliases
            show_npm_aliases
            show_utility_aliases
            show_custom_aliases
            show_workflow_examples
            show_tips

            echo ""
            print_color $MAGENTA "💾 Full cheatsheet: ~/ohmyzsh_cheatsheet.md"
            print_color $MAGENTA "🔍 Plugin analyzer: ./check_ohmyzsh_aliases.sh"
            ;;
    esac
}

# Execute main with all arguments
main "$@"
