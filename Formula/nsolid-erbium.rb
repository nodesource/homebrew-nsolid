class NsolidErbium < Formula
  desc "N|Solid Runtime Erbium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.6.2/artifacts/bundles/nsolid-bundle-v4.6.2-darwin-x64/nsolid-v4.6.2-erbium-darwin-x64.tar.gz"
  sha256 "e19341950080ff49c4b534f0854fd3457d1ee428c462fef091dec48408f2b9d1"
  version "4.6.2"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid", :because => "N|Solid Gallium is a replacement for N|Solid Erbium"
  conflicts_with "nsolid-fermium", :because => "N|Solid Fermium is a replacement for N|Solid Erbium"
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
