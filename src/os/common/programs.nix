{ config, pkgs, ... }: {
  programs = {
    bash = {
      interactiveShellInit = ''
        # Bind up and down arrow keys for history search
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'

        fastfetch --load-config neofetch
      '';
      promptInit = ''
        reset="\e[0m"
        green="\e[32m"
        red="\e[31m"
        cyan="\e[36m"
        grey="\e[37m"

        function exit_status {
          if [ $? -eq 0 ]; then
            echo "$green :)$reset"
          else
            echo "$red !!! $? !!!$reset"
          fi
        }

        function short_path {
          local path=$PWD
          local -a parts
          IFS="/" read -r -a parts <<< "$path"
          if [ "''${#parts[@]}" -gt 4 ]; then
            echo "/.../''${parts[-3]}/''${parts[-2]}/''${parts[-1]}"
          else
            echo "$path"
          fi
        }

        function git_branch {
          git branch 2>/dev/null | grep '*' | sed 's/* //'
        }

        function git_status {
          if git rev-parse --is-inside-work-tree &> /dev/null; then
            if git diff --quiet 2> /dev/null >&2; then
              echo "\n$grey working on$green clean$cyan $(git_branch)$reset"
            else
              echo "\n$grey working on$red dirty$cyan $(git_branch)$reset"
            fi
          fi
        }

        export PROMPT_COMMAND='PS1="\n$(exit_status) [\t]\n$grey at$cyan $(short_path)$grey as$cyan \u$grey in$cyan \h$(git_status)\n$grey > $reset"'
      '';
    };

    # Systemwide git configuration
    git = {
      enable = true;
      config = {
        core.fsmonitor = true;
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
