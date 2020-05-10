{ stdenv
, buildPythonPackage
, fetchPypi
, argh
, livereload
, sphinx
, port-for
, pyyaml
, watchdog
}:

buildPythonPackage rec {
  version = "0.7.1";
  pname = "sphinx-autobuild";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0kn753dyh3b1s0h77lbk704niyqc7bamvq6v3s1f6rj6i20qyf36";
  };

  propagatedBuildInputs = [ argh sphinx livereload port-for pyyaml watchdog ];

  doCheck = false;

  meta = {
    description = "Watch a Sphinx directory and rebuild the documentation when a change is detected";
    homepage = "https://github.com/GaretJax/sphinx-autobuild";
    license = stdenv.lib.licenses.mit;
  };
}
