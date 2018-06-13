class Nsolid < Formula
  desc "N|Solid Runtime"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.2.1/artifacts/bundles/nsolid-bundle-v3.2.1-darwin-x64/nsolid-v3.2.1-carbon-darwin-x64.tar.gz"
  sha256 "6585b28402889e88b885bd3d429f8e1ba884c88ea176c90374b162a78bf95be8"
  version "3.2.1"

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
