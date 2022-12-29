{
	# thanks https://blog.sekun.net/posts/packaging-prebuilt-binaries-with-nix/

  description = "A standalone 2-10 player remake of the Mario vs Luigi gamemode from New Super Mario Bros DS.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "mariovsluigi-${version}";

        version = "1.7.1.0-beta";

				src = pkgs.fetchurl {
				  # Remember `rec`!
				  url = "https://github.com/ipodtouch0218/NSMB-MarioVsLuigi/releases/download/v${version}/MarioVsLuigi-Linux-v${version}.zip";
				  sha256 = "sha256-rb9vZ3w4BfzygsdOCPLVX87T5tBXk6Aw+ba9I12fhwQ=";
				};

				sourceRoot = ".";

				nativeBuildInputs = [
					unzip
					autoPatchelfHook
				];

				buildInputs = [
					zlib
				];

				installPhase = ''
					ls MarioVsLuigi-Linux/
					mkdir -p $out/{bin,share}/
					cp -r MarioVsLuigi-Linux/linux_Data $out/share
					install -m755 MarioVsLuigi-Linux/UnityPlayer.so $out/share
					install -m755 MarioVsLuigi-Linux/linux.x86_64 $out/share
					echo "cd $out/share/ && steam-run ./linux.x86_64" > $out/bin/mariovsluigi
					chmod 755 $out/bin/mariovsluigi

			    cp $out/share/linux_Data/Resources/UnityPlayer.png $out/share/pixmaps/mariovsluigi.png
				'';

			  desktopItems = [
			    (makeDesktopItem {
			      name = "Mario VS Luigi";
			      icon = "mariovsluigi";
			      exec = "mariovsluigi";
			      genericName = "Mario VS Luigi";
			      desktopName = "Mario VS Luigi";
			      categories = [ "Game" ];
			    })
			  ];

      };
  };
}