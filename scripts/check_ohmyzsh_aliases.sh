#!/bin/bash

# Oh My Zsh Plugin Alias Checker
# This script checks installed oh-my-zsh plugins and displays their aliases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}%s${NC}\n" "$2"
}

print_header() {
    echo ""
    echo "=================================="
    print_color $BLUE "$1"
    echo "=================================="
}

# Function to extract aliases from a plugin file
extract_aliases() {
    local plugin_file="$1"
    local plugin_name="$2"

    if [[ ! -f "$plugin_file" ]]; then
        return 1
    fi

    # Extract alias definitions (handle different formats)
    local aliases=$(grep -E "^[[:space:]]*alias[[:space:]]+" "$plugin_file" 2>/dev/null | \
                   sed 's/^[[:space:]]*alias[[:space:]]\+//' | \
                   sed 's/[[:space:]]*#.*//' | \
                   sort -u)

    if [[ -n "$aliases" ]]; then
        print_color $CYAN "📦 $plugin_name Plugin Aliases:"
        while IFS= read -r alias_line; do
            if [[ -n "$alias_line" ]]; then
                local alias_name=$(echo "$alias_line" | cut -d'=' -f1)
                local alias_cmd=$(echo "$alias_line" | cut -d'=' -f2- | sed 's/^["'\'']//' | sed 's/["'\'']$//')
                printf "  %-15s → %s\n" "$alias_name" "$alias_cmd"
            fi
        done <<< "$aliases"
        echo ""
        return 0
    fi

    return 1
}

# Function to extract functions from a plugin file
extract_functions() {
    local plugin_file="$1"
    local plugin_name="$2"

    if [[ ! -f "$plugin_file" ]]; then
        return 1
    fi

    # Extract function definitions
    local functions=$(grep -E "^[[:space:]]*function[[:space:]]+[a-zA-Z_][a-zA-Z0-9_]*|^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(\)" "$plugin_file" 2>/dev/null | \
                     sed 's/^[[:space:]]*//' | \
                     sed 's/function[[:space:]]\+//' | \
                     sed 's/[[:space:]]*().*//' | \
                     sed 's/[[:space:]]*{.*//' | \
                     sort -u)

    if [[ -n "$functions" ]]; then
        print_color $MAGENTA "🔧 $plugin_name Plugin Functions:"
        while IFS= read -r func_name; do
            if [[ -n "$func_name" && "$func_name" != "_"* ]]; then
                printf "  %s\n" "$func_name"
            fi
        done <<< "$functions"
        echo ""
        return 0
    fi

    return 1
}

# Function to get plugin description
get_plugin_description() {
    local plugin_name="$1"

    case "$plugin_name" in
        "git")
            echo "Git aliases and functions for common git operations"
            ;;
        "npm")
            echo "NPM aliases and completion"
            ;;
        "eza")
            echo "Modern replacement for ls with color and icons"
            ;;
        "sudo")
            echo "Press ESC twice to add sudo to previous command"
            ;;
        "extract")
            echo "Universal archive extractor (tar, zip, gz, etc.)"
            ;;
        "history")
            echo "Enhanced history commands and search"
            ;;
        "docker")
            echo "Docker aliases and completion"
            ;;
        "kubectl")
            echo "Kubernetes kubectl aliases and completion"
            ;;
        "brew")
            echo "Homebrew aliases and functions"
            ;;
        "node")
            echo "Node.js aliases and functions"
            ;;
        "yarn")
            echo "Yarn package manager aliases"
            ;;
        *)
            echo "Oh My Zsh plugin for $plugin_name"
            ;;
    esac
}

# Function to check if oh-my-zsh is installed
check_ohmyzsh() {
    if [[ -z "$ZSH" ]]; then
        if [[ -d "$HOME/.oh-my-zsh" ]]; then
            export ZSH="$HOME/.oh-my-zsh"
        else
            print_color $RED "❌ Oh My Zsh not found!"
            echo "Please install Oh My Zsh first: https://ohmyz.sh/"
            exit 1
        fi
    fi

    if [[ ! -d "$ZSH" ]]; then
        print_color $RED "❌ Oh My Zsh directory not found at: $ZSH"
        exit 1
    fi

    print_color $GREEN "✅ Oh My Zsh found at: $ZSH"
}

# Function to get enabled plugins from .zshrc
get_enabled_plugins() {
    local zshrc_file="$HOME/.zshrc"

    if [[ ! -f "$zshrc_file" ]]; then
        print_color $YELLOW "⚠️  .zshrc not found, checking default plugins"
        echo "git"
        return
    fi

    # Extract plugins from .zshrc (handle multiline plugin definitions)
    local plugins_section=$(sed -n '/^plugins=(/,/)$/p' "$zshrc_file" | \
                           sed 's/plugins=(//' | \
                           sed 's/)$//' | \
                           grep -v '^#' | \
                           tr '\n' ' ' | \
                           tr -s ' ')

    echo "$plugins_section" | tr ' ' '\n' | grep -v '^$' | sort -u
}

# Function to analyze current .zshrc aliases
analyze_zshrc_aliases() {
    local zshrc_file="$HOME/.zshrc"

    if [[ ! -f "$zshrc_file" ]]; then
        return
    fi

    print_header "Current .zshrc Aliases"

    local current_aliases=$(grep -E "^[[:space:]]*alias[[:space:]]+" "$zshrc_file" 2>/dev/null | \
                           sed 's/^[[:space:]]*alias[[:space:]]\+//' | \
                           sort)

    if [[ -n "$current_aliases" ]]; then
        print_color $YELLOW "🔍 Your current aliases:"
        while IFS= read -r alias_line; do
            if [[ -n "$alias_line" ]]; then
                local alias_name=$(echo "$alias_line" | cut -d'=' -f1)
                local alias_cmd=$(echo "$alias_line" | cut -d'=' -f2- | sed 's/^["'\'']//' | sed 's/["'\'']$//')
                printf "  %-20s → %s\n" "$alias_name" "$alias_cmd"
            fi
        done <<< "$current_aliases"
    else
        print_color $YELLOW "No aliases found in .zshrc"
    fi
}

# Function to find duplicate aliases
find_duplicate_aliases() {
    local zshrc_file="$HOME/.zshrc"

    if [[ ! -f "$zshrc_file" ]]; then
        return
    fi

    print_header "Duplicate Alias Analysis"

    local current_aliases=$(grep -E "^[[:space:]]*alias[[:space:]]+" "$zshrc_file" 2>/dev/null | \
                           sed 's/^[[:space:]]*alias[[:space:]]\+//' | \
                           cut -d'=' -f1 | \
                           sort)

    local duplicates_found=false

    # Check each enabled plugin for conflicting aliases
    while IFS= read -r plugin; do
        if [[ -n "$plugin" ]]; then
            local plugin_file="$ZSH/plugins/$plugin/$plugin.plugin.zsh"
            if [[ -f "$plugin_file" ]]; then
                local plugin_aliases=$(grep -E "^[[:space:]]*alias[[:space:]]+" "$plugin_file" 2>/dev/null | \
                                     sed 's/^[[:space:]]*alias[[:space:]]\+//' | \
                                     cut -d'=' -f1 | \
                                     sort)

                # Find common aliases
                local common_aliases=$(comm -12 <(echo "$current_aliases") <(echo "$plugin_aliases"))

                if [[ -n "$common_aliases" ]]; then
                    if [[ "$duplicates_found" == "false" ]]; then
                        print_color $RED "⚠️  Potential duplicate aliases found:"
                        duplicates_found=true
                    fi

                    print_color $YELLOW "  Plugin: $plugin"
                    while IFS= read -r duplicate; do
                        if [[ -n "$duplicate" ]]; then
                            # Get the definitions
                            local zshrc_def=$(grep "alias $duplicate=" "$zshrc_file" | head -1 | cut -d'=' -f2-)
                            local plugin_def=$(grep "alias $duplicate=" "$plugin_file" | head -1 | cut -d'=' -f2-)

                            printf "    📍 %-15s: .zshrc=%s | plugin=%s\n" "$duplicate" "$zshrc_def" "$plugin_def"
                        fi
                    done <<< "$common_aliases"
                    echo ""
                fi
            fi
        fi
    done <<< "$(get_enabled_plugins)"

    if [[ "$duplicates_found" == "false" ]]; then
        print_color $GREEN "✅ No duplicate aliases found!"
    fi
}

# Function to show plugin usage examples
show_plugin_examples() {
    local plugin="$1"

    case "$plugin" in
        "git")
            echo "  Examples: ga (git add), gc (git commit), gst (git status), gp (git push)"
            ;;
        "npm")
            echo "  Examples: npmg (npm -g), npmS (npm -S), npmD (npm -D)"
            ;;
        "sudo")
            echo "  Usage: Press ESC ESC to add sudo to the previous command"
            ;;
        "extract")
            echo "  Usage: extract <archive_file> (supports .tar, .zip, .gz, .bz2, etc.)"
            ;;
        "history")
            echo "  Examples: h (history), hs (history search), hsi (history search case insensitive)"
            ;;
    esac
}

# Main function to check plugins
check_plugins() {
    print_header "Oh My Zsh Plugin Analysis"

    local plugins_found=false

    # Get enabled plugins
    local enabled_plugins=$(get_enabled_plugins)

    print_color $GREEN "📋 Enabled plugins in your .zshrc:"
    while IFS= read -r plugin; do
        if [[ -n "$plugin" ]]; then
            printf "  • %s - %s\n" "$plugin" "$(get_plugin_description "$plugin")"
        fi
    done <<< "$enabled_plugins"

    echo ""

    # Check each plugin
    while IFS= read -r plugin; do
        if [[ -n "$plugin" ]]; then
            local plugin_file="$ZSH/plugins/$plugin/$plugin.plugin.zsh"

            if [[ -f "$plugin_file" ]]; then
                plugins_found=true

                print_header "$plugin Plugin"
                print_color $BLUE "📝 $(get_plugin_description "$plugin")"

                # Extract and display aliases
                if extract_aliases "$plugin_file" "$plugin"; then
                    :
                else
                    print_color $YELLOW "  No aliases found in this plugin"
                fi

                # Extract and display functions
                if extract_functions "$plugin_file" "$plugin"; then
                    :
                fi

                # Show usage examples
                show_plugin_examples "$plugin"

                echo ""
            else
                print_color $RED "❌ Plugin file not found: $plugin_file"
            fi
        fi
    done <<< "$enabled_plugins"

    if [[ "$plugins_found" == "false" ]]; then
        print_color $YELLOW "No valid plugins found or no plugins enabled."
    fi
}

# Function to generate a clean .zshrc without duplicates
generate_clean_zshrc() {
    local zshrc_file="$HOME/.zshrc"
    local backup_file="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

    if [[ ! -f "$zshrc_file" ]]; then
        print_color $RED "❌ .zshrc file not found"
        return 1
    fi

    print_header "Generating Clean .zshrc"

    # Create backup
    cp "$zshrc_file" "$backup_file"
    print_color $GREEN "📁 Backup created: $backup_file"

    # Get all plugin aliases
    local all_plugin_aliases=""
    while IFS= read -r plugin; do
        if [[ -n "$plugin" ]]; then
            local plugin_file="$ZSH/plugins/$plugin/$plugin.plugin.zsh"
            if [[ -f "$plugin_file" ]]; then
                local plugin_aliases=$(grep -E "^[[:space:]]*alias[[:space:]]+" "$plugin_file" 2>/dev/null | \
                                     sed 's/^[[:space:]]*alias[[:space:]]\+//' | \
                                     cut -d'=' -f1)
                all_plugin_aliases="$all_plugin_aliases"$'\n'"$plugin_aliases"
            fi
        fi
    done <<< "$(get_enabled_plugins)"

    # Remove duplicates and create clean .zshrc
    local temp_file=$(mktemp)
    local in_alias=false
    local aliases_to_remove=""

    while IFS= read -r line; do
        if echo "$line" | grep -qE "^[[:space:]]*alias[[:space:]]+"; then
            local alias_name=$(echo "$line" | sed 's/^[[:space:]]*alias[[:space:]]\+//' | cut -d'=' -f1)
            if echo "$all_plugin_aliases" | grep -q "^$alias_name$"; then
                aliases_to_remove="$aliases_to_remove"$'\n'"$alias_name"
                echo "# REMOVED: $line (provided by oh-my-zsh plugin)" >> "$temp_file"
            else
                echo "$line" >> "$temp_file"
            fi
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$zshrc_file"

    # Replace original file
    mv "$temp_file" "$zshrc_file"

    if [[ -n "$(echo "$aliases_to_remove" | grep -v '^$')" ]]; then
        print_color $YELLOW "🗑️  Removed duplicate aliases:"
        echo "$aliases_to_remove" | grep -v '^$' | sed 's/^/  • /'
    else
        print_color $GREEN "✅ No duplicate aliases to remove"
    fi

    print_color $GREEN "✅ Clean .zshrc generated successfully!"
    echo "   Original backed up to: $backup_file"
}

# Main execution
main() {
    check_ohmyzsh

    case "${1:-}" in
        --clean|-c)
            generate_clean_zshrc
            ;;
        --duplicates|-d)
            find_duplicate_aliases
            ;;
        --aliases|-a)
            analyze_zshrc_aliases
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --clean, -c        Generate a clean .zshrc without duplicate aliases"
            echo "  --duplicates, -d   Show duplicate aliases between .zshrc and plugins"
            echo "  --aliases, -a      Show current .zshrc aliases"
            echo "  --help, -h         Show this help message"
            echo ""
            echo "Default: Show all plugin aliases and functions"
            ;;
        *)
            check_plugins
            echo ""
            analyze_zshrc_aliases
            echo ""
            find_duplicate_aliases
            echo ""
            print_color $BLUE "💡 Tips:"
            echo "  • Run '$0 --clean' to remove duplicate aliases"
            echo "  • Run '$0 --duplicates' to see conflicts"
            echo "  • Run '$0 --help' for more options"
            ;;
    esac
}

# Execute main function with all arguments
main "$@"
