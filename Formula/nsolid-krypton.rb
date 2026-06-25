class NsolidKrypton < Formula
  desc "N|Solid Runtime Krypton"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.18.0-ns6.3.2/artifacts/binaries/nsolid-v6.3.2-krypton-darwin-x64.tar.gz"
    sha256 "2422b2c1db205fa80808ce950b0e02a673ab10fd6c729ba03bb1c23d3f1b6723"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.18.0-ns6.3.2/artifacts/binaries/nsolid-v6.3.2-krypton-darwin-arm64.tar.gz"
    sha256 "126ceb3081e9aeff8bfca58e0acb4bc6e5bd124ed77df1ce4fa27bcd0db36e5b"
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
