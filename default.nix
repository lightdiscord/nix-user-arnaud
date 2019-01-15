{
	config,
	isAdmin ? true,
	...
}:

let
	dependencies = {
		nixpkgs = import ./dependencies/nixpkgs.nix { };
	};

	inherit (dependencies.nixpkgs) lib;

	informations = import ./informations.nix;

	groupExists = builtins.hasAttr config.users.groups;
	addIfExists = group: lib.optional (groupExists group) group;
in with lib; {
	isNormalUser = true;
	createHome = true;
	description = informations.nickname;
	hashedPassword = import ./hashed-password.nix;
	openssh.authorizedKeys.keys = [ informations.keys.ssh ];
	shell = dependencies.nixpkgs.fish;

	# TODO: Find a better way to add groups and add all of them.
	# ["wheel" "networkmanager" "audio" "git" "docker" "vboxusers" "scanner" "lp" "dialout"]

	extraGroups = []
		++ optionals isAdmin ["wheel"]
		++ optional (groupExists "dialout" && isAdmin) "dialout"
		++ addIfExists "lp"
		++ addIfExists "git"
		++ addIfExists "docker";
}
