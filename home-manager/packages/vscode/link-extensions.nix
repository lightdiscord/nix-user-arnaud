let
	dependencies = {
		nixpkgs = import ../../../dependencies/nixpkgs.nix { };
	};

	inherit (dependencies.nixpkgs.vscode-utils) extensionFromVscodeMarketplace;
	inherit (dependencies.nixpkgs.lib) foldr mkMerge;

	extensions = import ./list-extensions.nix;

	extensionFilename = { publisher, name, version, ... }:
		".vscode/extensions/${publisher}.${name}-${version}";

	mapExtension = extension: {
		home.file.${extensionFilename extension}.source =
			extensionFromVscodeMarketplace extension;
	};
in mkMerge (map mapExtension extensions)
