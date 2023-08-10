class Nsolid < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.10.1/artifacts/bundles/nsolid-bundle-v4.10.1-darwin-x64/nsolid-v4.10.1-hydrogen-darwin-x64.tar.gz"
  sha256 "78c9f7276886ac6037b192670320749cd2c7236c470ecdcc07cb9cfe2f7dcfe2"
  version "4.10.1"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid-gallium", :because => "N|Solid Hydrogen is a replacement for N|Solid Gallium"
  depends_on :macos => :el_capitan

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
