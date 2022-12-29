{ pkgs }:

let
  rev = "54c140399bbc3e6a3dce6c9f842727c4128367be";
in
with pkgs;
stdenv.mkDerivation rec {
  pname = "framework-ectool";
  version = "54c1403";

  src = fetchFromGitHub {
    owner = "DHowett";
    repo = "framework-ec";
    rev = rev;
    sha256 = "sha256-2teJFz4zcA+USpbVPXMEIHLdmMLem8ik7YrmrSxr/n0";
  };

  buildInputs = [
    libftdi
    libusb1
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  postPatch = ''
    substituteInPlace util/getversion.sh \
      --replace '/bin/bash' '${bash}/bin/bash'
  '';

  buildPhase = ''
    env \
      out=$TMPDIR \
      REPRODUCIBLE_BUILD=1 \
      VCSID=${version} \
      make V=99 utils-host
  '';

  installPhase = ''
    install -Dm755 $TMPDIR/util/ectool $out/bin/ectool
  '';

  meta = with lib; {
    description = ''
      Embedded Controller coomand-line tool for the Framework Laptop
    '';
    homepage = "https://github.com/DHowett/framework-ec";
    license = licenses.bsd3;
    mainProgram = "ectool";
    platforms = [ "x86_64-linux" ];
  };
}
