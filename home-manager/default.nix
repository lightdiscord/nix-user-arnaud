{ config, ... }:

let
	dependencies = {
		nixpkgs = import ../dependencies/nixpkgs.nix { };
		awesome = import ../dependencies/awesome.nix;
	};

	informations = import ../informations.nix;

	inherit (dependencies) nixpkgs;
in {
	imports = [
		dependencies.awesome.home-manager
		./packages/vscode/link-extensions.nix
	];

	home.packages = import ./packages { inherit config; };
	xsession.windowManager.awesome.enable = config.xsession.enable;
	services.compton.enable = config.xsession.enable;

	nixpkgs.config.allowUnfree = true;
	manual.manpages.enable = true;

	services.gnome-keyring = {
		enable = true;
		components = ["secrets" "pkcs11" "ssh"];
	};

	services.redshift = {
		# TODO: Location based on machine location or using system time.
		latitude = "43.643116";
		longitude = "6.875682";

		inherit (config.xsession) enable;
	};

	programs.git = {
		enable = true;
		userEmail = informations.email;
		userName = informations.nickname;

		signing = {
			signByDefault = true;
			key = informations.keys.gpg;
		};

		# TODO: Use the code package here or simply use the EDITOR variable.
		extraConfig = ''
			[core]
			editor=code --wait
		'';
	};

	services.gpg-agent = {
		enable = true;
		enableSshSupport = true;
		defaultCacheTtl = 60;
	};

	gtk = {
		enable = true;

		theme = {
			package = nixpkgs.arc-theme;
			name = "Arc-Dark";
		};

		iconTheme = {
			package = nixpkgs.papirus-icon-theme;
			name = "Papirus";
		};
	};

	qt = {
		enable = true;
		useGtkTheme = true;
	};
}
