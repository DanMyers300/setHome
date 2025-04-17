{
  description = "Dev shell for Minecraft Fabric modding (with Zulu JDK and all Linux deps)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      hardware.opengl.enable = true;
      zulu = pkgs.zulu21;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          zulu
          pkgs.mesa
          pkgs.libGL
          pkgs.xorg.libX11
          pkgs.xorg.libXrandr
          pkgs.xorg.libXinerama
          pkgs.xorg.libXcursor
          pkgs.xorg.libXi
          pkgs.xorg.xauth
          pkgs.udev
          pkgs.glxinfo
        ];

        shellHook = ''
          echo "Java version: $(java -version 2>&1 | head -n 1)"
        '';
      };
    };
}

