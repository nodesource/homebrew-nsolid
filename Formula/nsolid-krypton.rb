class NsolidKrypton < Formula
  desc "N|Solid Runtime Krypton"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.21.0-ns6.3.8/artifacts/binaries/nsolid-v6.3.8-krypton-darwin-x64.tar.gz"
    sha256 "a0c03318ef790c1f190df24d4bb8e032d1698ac55b11b2e7e0fe22de925308e1"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.21.0-ns6.3.8/artifacts/binaries/nsolid-v6.3.8-krypton-darwin-arm64.tar.gz"
    sha256 "10231c79b1364eca5cabfcaed642cb9e40c7215158fde0acf158c79724f0d35c"
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
