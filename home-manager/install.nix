{ config, ... }:

let
	dependencies = {
		home-manager = import ../dependencies/home-manager.nix { };
		nixpkgs = import ../dependencies/nixpkgs.nix { };
	};
in with dependencies.nixpkgs.lib; {
	imports = [
		(dependencies.home-manager).nixos
	];

	home-manager.users.arnaud = mkMerge [
		({
			xsession.enable = config.services.xserver.enable;
			home.keyboard.layout = config.i18n.consoleKeyMap;
		})

		(import ./default.nix)
	];
}
