class NsolidKrypton < Formula
  desc "N|Solid Runtime Krypton"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.18.1-ns6.3.5/artifacts/binaries/nsolid-v6.3.5-krypton-darwin-x64.tar.gz"
    sha256 "eb63592f1c1c6f0c47a35a77515a1b99f7296459172c582c0342634e7d4e9f6d"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.18.1-ns6.3.5/artifacts/binaries/nsolid-v6.3.5-krypton-darwin-arm64.tar.gz"
    sha256 "5f4c25bcd0d541e03b7a304190909319826158fc4c4ee80d3826b746bbb7b977"
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
