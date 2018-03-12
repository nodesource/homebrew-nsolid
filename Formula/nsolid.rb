class Nsolid < Formula
  desc "N|Solid Runtime"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.0.5/artifacts/bundles/nsolid-bundle-v3.0.5-darwin-x64/nsolid-v3.0.5-carbon-darwin-x64.tar.gz"
  sha256 "40ad9d789612d8c4ca428f8809183302c9c4f3c763389c91105ae7ba4132d72a"
  version "3.0.5"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  depends_on :macos => :yosemite

  bottle :unneeded

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    include.install Dir["include/*"]
    bin.install Dir["bin/*"]
  end

  def test
    system "nsolid", "-vv"
  end
end
