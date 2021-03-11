class Nsolid < Formula
  desc "N|Solid Runtime Fermium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.5.0/artifacts/bundles/nsolid-bundle-v4.5.0-darwin-x64/nsolid-v4.5.0-fermium-darwin-x64.tar.gz"
  sha256 "25fcdbcc6e6749e64fd22c37db5f594da18e410f0b9928980b77d3f157abf70c"
  version "4.5.0"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid-dubnium", :because => "N|Solid Fermium is a replacement for N|Solid Dubnium"
  conflicts_with "nsolid-erbium", :because => "N|Solid Fermium is a replacement for N|Solid Erbium"
  depends_on :macos => :yosemite

  bottle :unneeded

  option "without-node", "Won't symlink node, npm, and npx in /usr/local/bin/ to the N|Solid versions"

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    include.install Dir["include/*"]
    if build.without? "node"
      bin.install Dir["bin/nsolid"]
      bin.install Dir["bin/nsolid-cli"]
    else
      bin.install Dir["bin/*"]
    end
  end

  def test
    system "nsolid", "-vv"
    system "nsolid-cli", "-v"
  end
end
