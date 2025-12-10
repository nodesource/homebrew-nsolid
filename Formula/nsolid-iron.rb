class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.6-ns6.1.1/artifacts/binaries/nsolid-v6.1.1-iron-darwin-x64.tar.gz"
    sha256 "3f8cd69b6d2e848350bcd3128165e0d1f53b25e0dfae3185b89cc8f504bccf07"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.6-ns6.1.1/artifacts/binaries/nsolid-v6.1.1-iron-darwin-arm64.tar.gz"
    sha256 "4b67d677d7a72b3d40fa0f731bc9a0845e89eb7102843045836749d82b7447b3"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.6-ns6.1.1/artifacts/binaries/nsolid-v6.1.1-iron-darwin-arm64.tar.gz"
    sha256 "4b67d677d7a72b3d40fa0f731bc9a0845e89eb7102843045836749d82b7447b3"
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
