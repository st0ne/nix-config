self: super: {
  gnupg = super.gnupg.override { libusb = super.libusb1; };
  homer = super.fetchFromGitHub {
    owner = "sylv-io";
    repo = "homer";
    rev = "custom";
    sha256 = "0pd2nxznp6y5pb4gwxf1xw4gybmw2szagag75afawxgafj6gha89";
  };
  jlink = super.callPackage ../pkgs/development/tools/jlink {};
  openboardviewer = super.callPackage ../pkgs/applications/science/electronics/openboardviewer {};
}
