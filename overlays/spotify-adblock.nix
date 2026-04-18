final: prev:
let spotify-adblock = final.rustPlatform.buildRustPackage rec {
    pname = "spotify-adblock";
    
    src = final.fetchFromGitHub {
        owner = "abba23";
        repo = "spotify-adblock";

        rev = "813d3451c53126bf1941baaf8dd37f1152c3f412";

        hash = "sha256-nwiX2wCZBKRTNPhmrurWQWISQdxgomdNwcIKG2kSQsE=";
    };

    version = "unstable-${builtins.substring 0 8 src.rev}";

    cargoHash = "sha256-oGpe+kBf6kBboyx/YfbQBt1vvjtXd1n2pOH6FNcbF8M=";
};
in {
    spotify = prev.spotify.overrideAttrs (old: {
      preFixup = (old.preFixup or "") + ''
        ln -s ${spotify-adblock}/lib/libspotifyadblock.so \
          $out/share/spotify/libspotifyadblock.so
      '';

    postInstall = (old.postInstall or "") + ''
        mkdir -p $out/bin
        makeWrapper $out/bin/spotify $out/bin/spotify-adblock \
            --set LD_PRELOAD $out/share/spotify/libspotifyadblock.so

        mkdir -p $out/share/applications
        cat > $out/share/applications/spotify-adblock.desktop <<EOF
        [Desktop Entry]
        Name=Spotify (Adblock)
        GenericName=Music Player
        Comment=Spotify with spotify-adblock
        Exec=$out/bin/spotify-adblock %U
        Terminal=false
        Type=Application
        Icon=spotify-client
        Categories=Audio;Music;Player;AudioVideo;
        StartupWMClass=spotify
        MimeType=x-scheme-handler/spotify;
        EOF
    '';
    });
}