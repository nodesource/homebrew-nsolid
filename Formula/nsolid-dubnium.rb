class NsolidDubnium < Formula
  desc "N|Solid Runtime Dubnium"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.4.1/artifacts/bundles/nsolid-bundle-v4.4.1-darwin-x64/nsolid-v4.4.1-dubnium-darwin-x64.tar.gz"
  sha256 "da37f6f32f8b5ec5c8348eea9c3e2d94f3552b0688ccfd3010454a7bf0b69c17"
  version "4.4.1"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
  conflicts_with "nsolid", :because => "N|Solid Dubnium is a replacement for N|Solid Fermium"
  conflicts_with "nsolid-erbium", :because => "N|Solid Dubnium is a replacement for N|Solid Erbium"
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
