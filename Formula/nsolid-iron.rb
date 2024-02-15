class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.11.1-ns5.0.5/artifacts/binaries/nsolid-v5.0.5-iron-darwin-x64.tar.gz"
    sha256 "db3c25a2b41e3dd695f3ac4400672c061fae390739f7ce1be2fb4f0e04393cc4"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.11.1-ns5.0.5/artifacts/binaries/nsolid-v5.0.5-iron-darwin-arm64.tar.gz"
    sha256 "ffaea0230bf942b67ea8f2d9060aaed942a66b39b2e67e8ca64534007fae9f41"
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
