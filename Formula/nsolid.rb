class Nsolid < Formula
  desc "N|Solid Runtime Gallium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.6.2/artifacts/bundles/nsolid-bundle-v4.6.2-darwin-x64/nsolid-v4.6.2-gallium-darwin-x64.tar.gz"
  sha256 "62f6d352b3ab29d00cfd7bf1560f033a2ee76256072c41c7012a83cdce59bdce"
  version "4.6.2"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid-erbium", :because => "N|Solid Gallium is a replacement for N|Solid Erbium"
  conflicts_with "nsolid-fermium", :because => "N|Solid Gallium is a replacement for N|Solid Fermium"
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
