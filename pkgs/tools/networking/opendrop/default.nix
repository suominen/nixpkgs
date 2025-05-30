{
  lib,
  buildPythonApplication,
  fetchFromGitHub,
  fleep,
  ifaddr,
  libarchive-c,
  pillow,
  requests-toolbelt,
  setuptools,
  zeroconf,
  pytestCheckHook,
  writableTmpDirAsHomeHook,
  openssl,
}:

buildPythonApplication rec {
  pname = "opendrop";
  version = "0.13.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "seemoo-lab";
    repo = "opendrop";
    rev = "v${version}";
    hash = "sha256-4FeVQO7Z6t9mjIgesdjKx4Mi+Ro5EVGJpEFjCvB2SlA=";
  };

  nativeBuildInputs = [
    # Tests fail if I put it on buildInputs
    openssl
  ];

  propagatedBuildInputs = [
    fleep
    ifaddr
    libarchive-c
    pillow
    requests-toolbelt
    setuptools
    zeroconf
  ];

  makeWrapperArgs = [
    "--prefix PATH : ${lib.makeBinPath nativeBuildInputs}"
  ];

  checkInputs = [
    pytestCheckHook
  ];

  nativeCheckInputs = [ writableTmpDirAsHomeHook ];

  meta = with lib; {
    description = "Open Apple AirDrop implementation written in Python";
    homepage = "https://owlink.org/";
    changelog = "https://github.com/seemoo-lab/opendrop/releases/tag/${src.rev}";
    license = licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "opendrop";
    platforms = [ "x86_64-linux" ];
  };
}
