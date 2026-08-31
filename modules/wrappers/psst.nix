{
  perSystem = {pkgs, ...}: {
    packages.psst-unwrapped = pkgs.rustPlatform.buildRustPackage rec {
      pname = "psst";
      version = "0.2.0";

      src = pkgs.fetchFromGitHub {
        owner = "phisch";
        repo = "psst";
        rev = "v${version}";
        hash = "sha256-yZ0oHKQ4VEZRXxNCVFIumKMT/wIfGt+o/gwubk8u4sU=";
      };

      cargoHash = "sha256-H1mmA9x8iXib18+7JJt+AB1SEogbkmGA7HzX0AytXOE=";

      nativeBuildInputs = with pkgs; [pkg-config makeWrapper];
      buildInputs = with pkgs; [
        openssl.dev
        wayland
        vulkan-loader
        libxkbcommon
        fontconfig
        systemdLibs
      ];

      buildPhase = ''
        runHook preBuild
        cargo build --release --workspace
        runHook postBuild
      '';

      installPhase = ''
               runHook preInstall
               mkdir -p $out/bin

        for file in target/release/psst-*; do
          if [ -f "$file" ] && [ -x "$file" ]; then
            cp "$file" $out/bin/
          fi
        done
               # Install default theme
               mkdir -p $out/share/psst
               cp crates/theme/src/default-theme.kdl $out/share/psst/default-theme.kdl
               runHook postInstall
      '';

      postFixup = ''
               libPath="${pkgs.lib.makeLibraryPath buildInputs}"
        for bin in $out/bin/*; do
          wrapProgram "$bin" --set LD_LIBRARY_PATH "$libPath"
        done
      '';

      meta = with pkgs.lib; {
        description = "Beautiful (and themeable), unified UI for pinentry, GNOME keyring-prompter and polkit-agent";
        homepage = "https://github.com/phisch/psst";
        license = licenses.mpl20;
        platforms = platforms.linux;
        maintainers = [];
      };
    };
  };
}
