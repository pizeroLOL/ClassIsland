{
  stdenv,
  cmake,
}:
stdenv.mkDerivation {
  pname = "sound-flow-miniaudio";
  version = "1.2.1";
  src = fetchGit {
    url = "https://github.com/LSXPrime/SoundFlow.git";
    rev = "f6fff53e1b1786255b1e229057735dcdbb6e0b0b";
    submodules = true;
    shallow = true;
  };
  buildPhase = ''
    runHook preBuild

    cd Native
    ${cmake}/bin/cmake -S .
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp libminiaudio.so $out/lib

    runHook postInstall
  '';
}
