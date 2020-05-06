{ stdenv, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  version = "1.46";
  pname = "pigpio";

  src = fetchPypi {
    inherit pname version;
    sha256 = "17gmnbjbaln3hrh5qwnsxxiz1nxyf8g50pi3yxn0ravsiwpmdwpm";
  };

  propagatedBuildInputs = [];

  doCheck = false;

  meta = {
    description = "Raspberry Pi GPIO module";
    #homepage = "";
    #license = stdenv.lib.licenses.mit;
  };
}
