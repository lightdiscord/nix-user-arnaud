let
  expression = builtins.tryEval <home-manager>;
  fallback = builtins.fetchGit {
    url = "git@github.com:rycee/home-manager.git";
    rev = "40b279e3a33fd47b7e65e0303fcb9be621aeb7d3";
  };
in import (if expression.success then expression.value else fallback)
