class Nsolid < Formula
  desc "N|Solid Runtime"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.4.1/artifacts/bundles/nsolid-bundle-v3.4.1-darwin-x64/nsolid-v3.4.1-dubnium-darwin-x64.tar.gz"
  sha256 "a1dbf7e8d7fbd593fcbe36691f0df930a9954f36080336b705d37744aa32751c"
  version "3.4.1"

  conflicts_with "node", :because => "N|Solid is a replacement for NodeJS"
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
