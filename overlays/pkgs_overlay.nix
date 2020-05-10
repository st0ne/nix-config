self: super: {
  # WIP
  flashrom-coreboot = super.flashrom.overrideAttrs (
    old: rec {
      pname = "flashrom";
      version = "master";
      src = super.fetchgit {
        url = "https://review.coreboot.org/flashrom.git";
        rev = "0czbiwmm6krys43s13ppnkzmjyy2vcxxyxnbn7bvzvdy07vcwqzl";
        sha256 = "0fq0cl531nkyxbhghfzwb3h3yqncirfmm0pv6hd21vg5pc4rb8jv";
      };
    }
  );
  gnupg-libusb = super.gnupg.override { libusb = super.libusb1; };
  homer = super.fetchFromGitHub {
    owner = "sylv-io";
    repo = "homer";
    rev = "custom";
    sha256 = "0pd2nxznp6y5pb4gwxf1xw4gybmw2szagag75afawxgafj6gha89";
  };
  jlink = super.callPackage ../pkgs/development/tools/jlink {};
  # WIP
  openboardviewer = super.callPackage ../pkgs/applications/science/electronics/openboardviewer {};
}
