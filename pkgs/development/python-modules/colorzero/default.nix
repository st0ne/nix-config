{ stdenv, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  version = "1.1";
  pname = "colorzero";

  src = fetchPypi {
    inherit pname version;
    sha256 = "16a532mgfwyr9l400g6cbhw82m6cdkz9mniw1ml5b1axkc8lgfmc";
  };

  propagatedBuildInputs = [];

  doCheck = false;

  meta = {
    description = "Yet another Python color library";
    #homepage = "";
    #license = stdenv.lib.licenses.mit;
  };
}
