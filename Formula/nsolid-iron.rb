class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.2-ns5.6.1/artifacts/binaries/nsolid-v5.6.1-iron-darwin-x64.tar.gz"
    sha256 "431c894b25ff7036921190cafc430e4999077406e01aed549da46690cc905e5c"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.2-ns5.6.1/artifacts/binaries/nsolid-v5.6.1-iron-darwin-arm64.tar.gz"
    sha256 "1a4d009955fb757f4c919c1973cc476af9bf14af539199f2a3212aa2d49bbe74"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Iron replaces N|Solid Hydrogen"
  conflicts_with "nsolid-jod", because: "N|Solid Iron replaces N|Solid Jod"
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
