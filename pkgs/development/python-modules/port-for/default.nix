{ stdenv, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  version = "0.3.1";
  pname = "port-for";

  src = fetchPypi {
    inherit pname version;
    sha256 = "073gb767blwhdg0xw61rwckrr735gjqkigi99js4v5f256xq8smi";
  };

  propagatedBuildInputs = [];

  doCheck = false;

  meta = {
    description = "Watch a Sphinx directory and rebuild the documentation when a change is detected";
    homepage = "https://github.com/kmike/port-for";
    license = stdenv.lib.licenses.mit;
  };
}
