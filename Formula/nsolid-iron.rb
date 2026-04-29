class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.3/artifacts/binaries/nsolid-v6.2.3-iron-darwin-x64.tar.gz"
    sha256 "b89ea742e79572ebc92f52e79ab602811eaeb9d60f5e017afd8b77c0563cbd84"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.3/artifacts/binaries/nsolid-v6.2.3-iron-darwin-arm64.tar.gz"
    sha256 "2ca3f67c498cdff72c4773e8c8fb4d8c4a786f5e4e20e4dad2507adbda0f61a0"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.3/artifacts/binaries/nsolid-v6.2.3-iron-darwin-arm64.tar.gz"
    sha256 "2ca3f67c498cdff72c4773e8c8fb4d8c4a786f5e4e20e4dad2507adbda0f61a0"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Iron replaces N|Solid Hydrogen"
  conflicts_with "nsolid-jod", because: "N|Solid Jod replaces N|Solid Iron"
  conflicts_with "nsolid-krypton", because: "N|Solid Krypton replaces N|Solid Iron"
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
