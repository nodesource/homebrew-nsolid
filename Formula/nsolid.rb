class Nsolid < Formula
  desc "N|Solid Runtime Erbium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.12.1/artifacts/bundles/nsolid-bundle-v3.12.1-darwin-x64/nsolid-v3.12.1-erbium-darwin-x64.tar.gz"
  sha256 "3c8cd95f948051c30a64c39bb0177d850afa7b73a6c4835527e6e500afa1b8e1"
  version "3.12.1"

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
