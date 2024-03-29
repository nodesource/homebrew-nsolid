class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.12.0-ns5.1.0/artifacts/binaries/nsolid-v5.1.0-iron-darwin-x64.tar.gz"
    sha256 "7c36b4731eab12671a47ea37b0bd90642abf4aca11742d305fd6d9c2056c0625"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.12.0-ns5.1.0/artifacts/binaries/nsolid-v5.1.0-iron-darwin-arm64.tar.gz"
    sha256 "ff9cc4eb87f75cfc06b7290e1a2aaef0b4a7564e9118a235c7c8bfff3ff5da7b"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Iron replaces N|Solid Hydrogen"
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
