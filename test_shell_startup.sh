#!/bin/bash

# Shell Startup Time Testing Script
# This script helps measure and compare shell startup times

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}%s${NC}\n" "$2"
}

print_header() {
    echo "=================================="
    print_color $BLUE "$1"
    echo "=================================="
}

# Function to measure startup time
measure_startup_time() {
    local shell_cmd="$1"
    local description="$2"
    local iterations=5
    local total_time=0

    print_color $YELLOW "Testing: $description"

    for i in $(seq 1 $iterations); do
        # Use time command to measure startup time
        local startup_time=$(TIMEFORMAT='%3R'; { time $shell_cmd -c 'exit' > /dev/null 2>&1; } 2>&1)
        total_time=$(echo "$total_time + $startup_time" | bc -l)
        printf "  Run %d: %s seconds\n" "$i" "$startup_time"
    done

    # Calculate average
    local avg_time=$(echo "scale=4; $total_time / $iterations" | bc -l)
    print_color $GREEN "  Average: $avg_time seconds"
    echo ""

    return 0
}

# Function to profile zsh startup
profile_zsh_startup() {
    print_header "ZSH STARTUP PROFILING"

    # Create a temporary profiled .zshrc
    local temp_zshrc="/tmp/.zshrc_profiled"
    cat > "$temp_zshrc" << 'EOF'
# Enable profiling
zmodload zsh/zprof

# Source the original .zshrc
source ~/.zshrc

# Print profiling results
zprof
EOF

    print_color $YELLOW "Running detailed profiling (this may take a moment)..."
    echo ""

    # Run zsh with the profiled config
    ZDOTDIR=/tmp zsh -c "source $temp_zshrc; exit" 2>/dev/null || true

    # Clean up
    rm -f "$temp_zshrc"
}

# Function to test individual components
test_components() {
    print_header "COMPONENT TESTING"

    # Test basic zsh without any config
    measure_startup_time "zsh --no-rcs" "Basic zsh (no config)"

    # Test with minimal config
    local minimal_config="/tmp/.zshrc_minimal"
    cat > "$minimal_config" << 'EOF'
export skip_global_compinit=1
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh
EOF

    ZDOTDIR=/tmp measure_startup_time "zsh -c 'source $minimal_config; exit'" "Minimal oh-my-zsh config"
    rm -f "$minimal_config"

    # Test current config
    measure_startup_time "zsh" "Current .zshrc configuration"
}

# Function to check for common performance issues
check_performance_issues() {
    print_header "PERFORMANCE ANALYSIS"

    local zshrc_file="$HOME/.zshrc"

    print_color $YELLOW "Checking for potential performance issues..."

    # Check for synchronous eval commands
    if grep -q "eval.*\$(" "$zshrc_file"; then
        print_color $RED "⚠️  Found synchronous eval commands that may slow startup"
        echo "   Consider lazy loading these:"
        grep -n "eval.*\$(" "$zshrc_file" | sed 's/^/   /'
    fi

    # Check for large number of plugins
    local plugin_count=$(grep -o 'plugins=(' "$zshrc_file" -A 20 | grep -E '^\s*[a-zA-Z-]+' | wc -l)
    if [ "$plugin_count" -gt 10 ]; then
        print_color $RED "⚠️  Large number of plugins detected ($plugin_count)"
        echo "   Consider reducing plugins or using lazy loading"
    fi

    # Check for network-dependent operations
    if grep -q "curl\|wget\|git.*remote" "$zshrc_file"; then
        print_color $RED "⚠️  Found potential network-dependent operations"
        echo "   These can cause startup delays on slow connections"
    fi

    # Check for file existence
    local missing_files=0
    while IFS= read -r line; do
        if echo "$line" | grep -q "source.*\[.*-f"; then
            local file_path=$(echo "$line" | sed -n 's/.*source[[:space:]]*\([^[:space:]]*\).*/\1/p' | tr -d '"')
            if [ ! -f "$file_path" ]; then
                if [ $missing_files -eq 0 ]; then
                    print_color $YELLOW "⚠️  Some sourced files don't exist (good - conditional loading):"
                fi
                echo "   $file_path"
                missing_files=$((missing_files + 1))
            fi
        fi
    done < "$zshrc_file"

    echo ""
}

# Function to suggest optimizations
suggest_optimizations() {
    print_header "OPTIMIZATION SUGGESTIONS"

    print_color $BLUE "General Recommendations:"
    echo "• Use lazy loading for heavy tools (nvm, rbenv, etc.)"
    echo "• Reduce the number of oh-my-zsh plugins"
    echo "• Use conditional sourcing for optional files"
    echo "• Move syntax highlighting to the end of .zshrc"
    echo "• Consider using starship or pure prompt instead of oh-my-zsh themes"
    echo "• Use 'skip_global_compinit=1' to speed up completion loading"

    echo ""
    print_color $BLUE "Lazy Loading Template:"
    cat << 'EOF'
# Example lazy loading function
lazy_load_nvm() {
    unset -f nvm node npm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Create wrapper functions
nvm() { lazy_load_nvm; nvm "$@"; }
node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
EOF
}

# Main execution
main() {
    print_header "SHELL STARTUP TIME ANALYSIS"
    echo "This script will measure your shell startup time and identify"
    echo "potential performance issues in your .zshrc configuration."
    echo ""

    # Check if bc is available for calculations
    if ! command -v bc >/dev/null 2>&1; then
        print_color $RED "Error: 'bc' command not found. Please install it first:"
        echo "  brew install bc"
        exit 1
    fi

    # Run tests
    test_components
    check_performance_issues
    suggest_optimizations

    echo ""
    print_color $GREEN "Analysis complete! Consider running the profiling for detailed breakdown:"
    echo "  $0 --profile"
}

# Handle command line arguments
case "${1:-}" in
    --profile|-p)
        profile_zsh_startup
        ;;
    --help|-h)
        echo "Usage: $0 [--profile|--help]"
        echo ""
        echo "Options:"
        echo "  --profile, -p    Run detailed zsh startup profiling"
        echo "  --help, -h       Show this help message"
        ;;
    *)
        main
        ;;
esac
