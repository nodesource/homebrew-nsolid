class Nsolid < Formula
  desc "N|Solid Runtime Erbium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.11.2/artifacts/bundles/nsolid-bundle-v3.11.2-darwin-x64/nsolid-v3.11.2-erbium-darwin-x64.tar.gz"
  sha256 "4dedb7bdb10ac5c0d2cee515f0c92184def5306b3f76acad36fa0b5ea1bebd51"
  version "3.11.2"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid-dubnium", :because => "N|Solid Erbium is a replacement for N|Solid Dubnium"
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
