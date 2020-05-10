{ stdenv
, buildPythonPackage
, fetchPypi
, colorzero
}:

buildPythonPackage rec {
  version = "1.5.1";
  pname = "gpiozero";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0k9f8azglr9wa30a0zrl8qn0a66jj0r8z5h0z7cgz4z7wv28s6mf";
  };

  propagatedBuildInputs = [ colorzero ];

  doCheck = false;

  meta = {
    description = "A simple interface to GPIO devices with Raspberry Pi";
    #homepage = "";
    #license = stdenv.lib.licenses.mit;
  };
}
