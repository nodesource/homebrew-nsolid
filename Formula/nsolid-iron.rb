class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.0-ns6.2.0/artifacts/binaries/nsolid-v6.2.0-iron-darwin-x64.tar.gz"
    sha256 "a6c121268ca256ee248556f327735c861b99f431da0781ca94f91099509f9f62"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.0-ns6.2.0/artifacts/binaries/nsolid-v6.2.0-iron-darwin-arm64.tar.gz"
    sha256 "0f3a4b0466958a3f3fe49d52fc4662058e40472a1e1b8ca1e419e78f59616e1c"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.0-ns6.2.0/artifacts/binaries/nsolid-v6.2.0-iron-darwin-arm64.tar.gz"
    sha256 "0f3a4b0466958a3f3fe49d52fc4662058e40472a1e1b8ca1e419e78f59616e1c"
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
