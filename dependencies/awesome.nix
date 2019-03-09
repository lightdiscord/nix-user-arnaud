let
	expression = builtins.tryEval <awesome>;
	fallback = builtins.fetchGit {
		url = "git@github.com:lightdiscord/Awesome.git";
		rev = "8258c1523bab3be48bf759c96901037c038117e7";
	};
in import (if expression.success then expression.value else fallback)
