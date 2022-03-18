class NsolidErbium < Formula
  desc "N|Solid Runtime Erbium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.7.1/artifacts/bundles/nsolid-bundle-v4.7.1-darwin-x64/nsolid-v4.7.1-erbium-darwin-x64.tar.gz"
  sha256 "924b8b7497e795d9d8773818691e5f5944880f60ec3f3748b7dae2ce2862a825"
  version "4.7.1"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid", :because => "N|Solid Gallium is a replacement for N|Solid Erbium"
  conflicts_with "nsolid-fermium", :because => "N|Solid Fermium is a replacement for N|Solid Erbium"
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
