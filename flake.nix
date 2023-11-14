{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    master.url = github:NixOS/nixpkgs/master;
    hm.url = github:nix-community/home-manager/release-23.05;
    mpdrp.url = path:/home/lychee/g/mpdrp;

    hm.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {self, nixpkgs, master, hm, mpdrp }@attrs: let
    overlays = (final: prev: {
      unstable = import master { system = prev.system; config.allowUnfree = true; };
    });
    lib = (import ./lib attrs);
  in {
    nixosConfigurations = (lib.systems [
      {
        hostname = "hearth";
        system = "x86_64-linux";
        overlays = [
          mpdrp.overlays."x86_64-linux".default
          overlays
        ];
        headless = false;
        modules = [
          ./hosts/hearth.nix
          { home-manager.users.lychee = ./home/lychee; }
        ];
      }
    ]);
    # Formatter!
    formatter = lib.eachSystem (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt );
    # Templates
    templates = (import ./templates attrs);
  };
}
