class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.3-ns5.3.0/artifacts/binaries/nsolid-v5.3.0-hydrogen-darwin-x64.tar.gz"
    sha256 "39ba35a052ece43c09fb3f80dcfaa2677ff158f89ec53c7a2b40d985f6d87603"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.3-ns5.3.0/artifacts/binaries/nsolid-v5.3.0-hydrogen-darwin-arm64.tar.gz"
    sha256 "b0e34c0d285ebb257b558ba2d2e58aa9d0f32bf88af5286fa8ffff2070f00020"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-iron", because: "N|Solid Hydrogen replaces N|Solid Iron"
  depends_on macos: :el_capitan

  option "without-node", "Avoids symlinking node, npm, and npx in /usr/local/bin/ to the N|Solid versions"

  def install
    lib.install Dir["lib/*"]
    share.install Dir["share/*"]
    include.install Dir["include/*"]
    if build.without? "node"
      bin.install Dir["bin/nsolid"], Dir["bin/nsolid-cli"]
    else
      bin.install Dir["bin/*"]
    end
  end

  test do
    system "nsolid", "-vv"
    system "nsolid-cli", "-v"
  end
end
