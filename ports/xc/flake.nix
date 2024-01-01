{
  description = "Nix flake template for bash";

  inputs.nixpkgs.url = "nixpkgs/nixos-21.05";  # adjust the channel as needed

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.xc = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "xc";
      src = self;
      buildInputs = [ nixpkgs.legacyPackages.x86_64-linux.xclip ];
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        cp xc $out/bin
      '';
    };

    packages.x86_64-darwin.xc = nixpkgs.legacyPackages.x86_64-darwin.stdenv.mkDerivation {
      name = "xc";
      src = self;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        cp xc $out/bin
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.xc;
    defaultPackage.x86_64-darwin = self.packages.x86_64-darwin.xc;
  };
}
