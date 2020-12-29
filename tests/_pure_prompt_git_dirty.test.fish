source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_git_dirty.fish
source $current_dirname/../functions/_pure_set_color.fish
@mesg (_print_filename $current_filename)


function setup
    _purge_configs
    _disable_colors

    rm -rf /tmp/pure_pure_prompt_git_dirty

    mkdir -p /tmp/pure_pure_prompt_git_dirty
    cd /tmp/pure_pure_prompt_git_dirty

    git init --quiet
    git config --local user.email "you@example.com"
    git config --local user.name "Your Name"
end

function teardown
    rm -rf /tmp/pure_pure_prompt_git_dirty
end


@test "_pure_prompt_git_dirty: untracked files make git repo as dirty" (
    touch file.txt
    set --global pure_symbol_git_dirty '*'

    _pure_prompt_git_dirty
) = '*'

@test "_pure_prompt_git_dirty: staged files mark git repo as dirty" (
    touch file.txt
    git add file.txt
    set --global pure_symbol_git_dirty '*'

    _pure_prompt_git_dirty
) = '*'

@test "_pure_prompt_git_dirty: symbol is colorized" (
    touch file.txt
    set --global pure_symbol_git_dirty '*'
    set --global pure_color_git_dirty brblack

    _pure_prompt_git_dirty
) = (set_color brblack)'*'
