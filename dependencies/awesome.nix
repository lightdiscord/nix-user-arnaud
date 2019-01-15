let
    expression = builtins.tryEval <awesome>;
    fallback = builtins.fetchGit {
        url = "git@github.com:lightdiscord/Awesome.git";
        rev = "958102c1b20b95a7cb3e8b3921c659b8da9bd06d";
    };
in import (if expression.success then expression.value else fallback)
