let
    expression = builtins.tryEval <neovim>;
    fallback = builtins.fetchGit {
        url = "git@github.com:LightDiscord/Vim-files.git";
        rev = "106d5556524a0074c6b0646c24a1ea9400b2e4c1";
    };
in import (if expression.success then expression.value else fallback)
