class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.2/artifacts/binaries/nsolid-v6.2.2-iron-darwin-x64.tar.gz"
    sha256 "a51d349d98a7befa4056468d153c0222f6915de14b63732f6343ddccc6276df6"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.2/artifacts/binaries/nsolid-v6.2.2-iron-darwin-arm64.tar.gz"
    sha256 "6ece6190fb0b54cdeef0744719d7891509bb0bc11b3a47f543afd1cf35145217"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.2/artifacts/binaries/nsolid-v6.2.2-iron-darwin-arm64.tar.gz"
    sha256 "6ece6190fb0b54cdeef0744719d7891509bb0bc11b3a47f543afd1cf35145217"
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
