{ stdenv
, buildPythonPackage
, fetchPypi
, sphinx
}:

buildPythonPackage rec {
  version = "0.7";
  pname = "sphinxcontrib-ditaa";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0vr7f7z2v0w0gqbs76gjmksl87c0s0j4sbibpq26h76xv127lmhr";
  };

  propagatedBuildInputs = [ sphinx ];

  meta = {
    description = "A sphinx extension for embedding ditaa diagram";
    homepage = "https://github.com/stathissideris/ditaa";
    license = stdenv.lib.licenses.bsd3;
    broken = true;
    ### Broken for python3.7
    ## tested on:
    # - Debian GNU/Linux 10 (buster)
    # - Fedora 30 (Workstation Edition)
    ## Error:
    # class DitaaDirective(directives.images.Image):
    # AttributeError: module 'docutils.parsers.rst.directives' has no attribute 'images'
  };
}
