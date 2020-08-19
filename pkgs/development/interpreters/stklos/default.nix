{ stdenv, pkgs, fetchurl }:

stdenv.mkDerivation rec {
  pname = "stklos";
  version = "1.50";

  src = fetchurl {
    url = "http://www.stklos.net/download/${pname}-${version}.tar.gz";
    sha256 = "1lhsk18fi5sc5sg8168zljq1vp0cbv7dkxlmylgnldbbnkbpa5wr";
  };

  buildInputs = with pkgs; [
    boehmgc
    gmp
    libffi
    pcre
  ];

  patchPhase = ''
    rm -fr ffi gc pcre gmp
    substituteInPlace lib/Makefile.in \
      --replace "/bin/rm" "rm"
  '';

  meta = with stdenv.lib; {
    description = "Free R7RS Scheme implementation";
    longDescription = ''
      STklos is a free Scheme system mostly compliant with the languages
      features defined in R7RS small.
    '';
    homepage = "https://stklos.net";
    license = licenses.gpl2;
    maintainers = [ maintainers.dramaturg ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
