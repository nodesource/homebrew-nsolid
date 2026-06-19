class NsolidKrypton < Formula
  desc "N|Solid Runtime Krypton"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.17.0-ns6.3.1/artifacts/binaries/nsolid-v6.3.1-krypton-darwin-x64.tar.gz"
    sha256 "b907514f437263feeacd2301230a4313237fcbe46322c7420ccf7b698c9e5bb7"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.17.0-ns6.3.1/artifacts/binaries/nsolid-v6.3.1-krypton-darwin-arm64.tar.gz"
    sha256 "70af958271dc2cb7e8e4ca7275a9c677b63625b99c711c680bc20a5c942d9a67"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Krypton replaces N|Solid Hydrogen"
  conflicts_with "nsolid-iron", because: "N|Solid Krypton replaces N|Solid Iron"
  conflicts_with "nsolid-jod", because: "N|Solid Krypton replaces N|Solid Jod"

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
