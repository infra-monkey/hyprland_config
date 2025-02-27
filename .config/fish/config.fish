if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting
    set -U fish_prompt_pwd_dir_length 0
    fish_add_path -a /home/monkey/.local/go/bin
    fish_ssh_agent
end
