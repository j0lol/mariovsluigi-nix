{
  description = "REST API for any Postgres database";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "postgrest-${version}";

        version = "1.7.1.0-beta";

		src = pkgs.fetchurl {
		  # Remember `rec`!
		  url = "https://github.com/ipodtouch0218/NSMB-MarioVsLuigi/releases/download/v${version}/MarioVsLuigi-Linux-v${version}.zip";
		  sha256 = "";
		};

      };
  };
}