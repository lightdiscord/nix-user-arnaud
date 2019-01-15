{
    rustSupport ? false,
	...
}:

let
    dependencies = {
        nixpkgs = import ../../../dependencies/nixpkgs.nix { };
    };

    inherit (dependencies.nixpkgs) vscode-with-extensions vscode-utils lib;

	extensions' = import ./extensions.nix;
	extensions = with extensions'; [
		bbenoist.nix
		vscodevim.vim
		pkief.material-icon-theme
		editorconfig.editorconfig
	] ++ lib.optionals rustSupport [
		bungcip.better-toml
		rust-lang.rust
		vadimcn.vscode-lldb
	];
in vscode-with-extensions.override {
	vscodeExtensions = vscode-utils.extensionsFromVscodeMarketplace extensions;
}
