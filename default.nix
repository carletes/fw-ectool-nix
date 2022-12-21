{ pkgs }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "fw-ectool";
  version = "54c1403";

  src = fetchFromGitHub {
    owner = "DHowett";
    repo = "framework-ec";
    rev = "54c140399bbc3e6a3dce6c9f842727c4128367be";
    sha256 = "sha256-2teJFz4zcA+USpbVPXMEIHLdmMLem8ik7YrmrSxr/n0";
  };

  buildInputs = [
    libftdi
    libusb1
  ];

  nativeBuildInputs = [
    hostname
    pkg-config
  ];

  buildPhase = ''
    set -x

    ls -l

    make utils-host

    exit 42
  '';

  meta = with lib; {
    description = ''
      Command-line tool for the Embedded Controller firmware in the Framework Laptop.
    '';
    homepage = "https://github.com/DHowett/framework-ec";
    license = licenses.bsd3;
    mainProgram = "ectool";
    platforms = platforms.all;
  };
}
