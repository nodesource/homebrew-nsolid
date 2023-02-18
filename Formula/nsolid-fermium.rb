class NsolidFermium < Formula
  desc "N|Solid Runtime Fermium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.9.1/artifacts/bundles/nsolid-bundle-v4.9.1-darwin-x64/nsolid-v4.9.1-fermium-darwin-x64.tar.gz"
  sha256 "6d85193f0778e14d2412a8174f54d556c182ad97cdbfe3148c97e3d258188848"
  version "4.9.1"

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
