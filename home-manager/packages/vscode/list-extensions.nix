let
	dependencies = {
		nixpkgs = import ../../../dependencies/nixpkgs.nix { };
	};

	inherit (dependencies.nixpkgs.lib) mapAttrsRecursiveCond collect;
	inherit (builtins) elemAt;

	extensions = import ./extensions.nix;

	mapCondition = (set: !(set ? version && set ? sha256));

	mapRecursive = mapAttrsRecursiveCond mapCondition (path: value: value // {
		publisher = elemAt path 0;
		name = elemAt path 1;
	});

	collect' = collect (x: x ? name && x ? publisher && x ? version && x ? sha256);
in collect' (mapRecursive extensions)
