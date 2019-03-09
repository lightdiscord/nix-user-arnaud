{ config }:

let
	dependencies = {
		nixpkgs = import ../../dependencies/nixpkgs.nix { };
		neovim = import ../../dependencies/neovim.nix;
	};

	inherit (dependencies) nixpkgs;

	neovim = nixpkgs.callPackage dependencies.neovim { };

in with nixpkgs.lib; [
	nixpkgs.psmisc
	nixpkgs.tmate
	nixpkgs.gcc
	nixpkgs.gnumake
	# nixpkgs.rustup
	nixpkgs.neomutt
	nixpkgs.htop
	nixpkgs.bat
	nixpkgs.taskwarrior
	nixpkgs.pinentry
	nixpkgs.neomutt
	nixpkgs.protonmail-bridge
	nixpkgs.ponysay
	nixpkgs.upower
	nixpkgs.acpi
	# nixpkgs.exa
	nixpkgs.gnome3.dconf
	neovim
] ++ optionals config.xsession.enable [
	nixpkgs.discord
	nixpkgs.pavucontrol
	nixpkgs.google-chrome
	nixpkgs.feh
	nixpkgs.xsel
	nixpkgs.xclip
	nixpkgs.shutter
	nixpkgs.thunderbird
	nixpkgs.kitty
	nixpkgs.libreoffice
	nixpkgs.arduino
	nixpkgs.dolphin
	nixpkgs.vscode
]
