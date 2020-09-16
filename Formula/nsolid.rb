class Nsolid < Formula
  desc "N|Solid Runtime Erbium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.0.1/artifacts/bundles/nsolid-bundle-v4.0.1-darwin-x64/nsolid-v4.0.1-erbium-darwin-x64.tar.gz"
  sha256 "446f3f63b684c2ed893d868e0ed2fc2050ae6bcde79741333b400d7c21cf63e9"
  version "4.0.1"

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
