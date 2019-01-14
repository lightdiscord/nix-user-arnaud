{ ... }:

let
    dependencies = {
        nixpkgs = import ./dependencies/nixpkgs.nix { };
    };

    informations = import ./informations.nix;
in {
    isNormalUser = true;
    createHome = true;
    description = informations.nickname;
    hashedPassword = import ./hashed-password.nix;
    openssh.authorizedKeys.keys = [ informations.keys.ssh ];
    shell = dependencies.nixpkgs.fish;
}