class Nsolid < Formula
  desc "N|Solid Runtime"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.1.1/artifacts/bundles/nsolid-bundle-v3.1.1-darwin-x64/nsolid-v3.1.1-carbon-darwin-x64.tar.gz"
  sha256 "bd32366f9a9691536d3746042ed631519871fd8f3c620ece1d8a68b9fbadb875"
  version "3.1.1"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
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
