class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.4-ns6.0.1/artifacts/binaries/nsolid-v6.0.1-iron-darwin-x64.tar.gz"
    sha256 "7e58a987442e55ed4277050717bc451a32950d36f6c3e4cb11f603c04c7b6f59"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.4-ns6.0.1/artifacts/binaries/nsolid-v6.0.1-iron-darwin-arm64.tar.gz"
    sha256 "86dd685b1d4cdd97a2a777b249b75896d17f4f727552fde9c03bff76eac90868"
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
