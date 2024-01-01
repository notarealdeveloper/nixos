{
  description = "Hello again, world";

  outputs = { self, nixpkgs }: 

    let 
      build_for = system:

        let 
          pkgs = import nixpkgs { inherit system; };
        in

        pkgs.stdenv.mkDerivation {
          name = "hello-again";
          src = self;
          buildInputs = [ pkgs.gcc pkgs.which ];
          buildPhase = "make build";
          installPhase = "make install";
        };
    in

    {
      packages.aarch64-darwin.default = build_for "aarch64-darwin";
      packages.x86_64-linux.default = build_for "x86_64-linux";
    };
}
