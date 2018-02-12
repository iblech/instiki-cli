# Should be placed at $NIXPKGS/pkgs/applications/misc/instiki-cli/default.nix
{ stdenv, fetchFromGitHub, nodejs, perl, diffutils, perlPackages, makeWrapper }:

stdenv.mkDerivation rec {
  name = "instiki-cli-${version}";
  version = "0.1";

  src = /home/iblech/instiki-cli;  # XXX

  buildInputs = [ makeWrapper perl perlPackages.HTMLParser perlPackages.LWP perlPackages.FileSlurp perlPackages.LWPProtocolHttps ];

  installPhase = ''
    mkdir -p $out/bin
    cp instiki-cli $out/bin
    wrapProgram $out/bin/instiki-cli \
      --prefix PATH : "${stdenv.lib.makeBinPath [ nodejs perl ]}" \
      --prefix PERL5LIB : $PERL5LIB
  '';

  meta = with stdenv.lib; {
    description = "Edit Instiki wikis from the command line";
    longDescription = ''
    '';
    homepage = https://github.com/iblech/instiki-cli;
    license = stdenv.lib.licenses.gpl3Plus;
    platforms = stdenv.lib.platforms.all;
    maintainers = [ maintainers.iblech ];
  };
}
