class NsolidFermium < Formula
  desc "N|Solid Runtime Fermium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.9.3/artifacts/bundles/nsolid-bundle-v4.9.3-darwin-x64/nsolid-v4.9.3-fermium-darwin-x64.tar.gz"
  sha256 "7c33865d154c3f4abf5cf397ae841ee4e29ea7af8652c054d779c943a68a0ce2"
  version "4.9.3"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid", :because => "N|Solid Gallium is a replacement for N|Solid Fermium"
  depends_on :macos => :yosemite

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
