class NsolidJod < Formula
  desc "N|Solid Runtime Jod"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.22.2-ns6.2.5/artifacts/binaries/nsolid-v6.2.5-jod-darwin-x64.tar.gz"
    sha256 "bb4d8b2a3a1d44024494daa1c89f0be58c03e9ea5264f9bff431872cfe2b8c97"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.22.2-ns6.2.5/artifacts/binaries/nsolid-v6.2.5-jod-darwin-arm64.tar.gz"
    sha256 "12307390b77bc82c9cdb4da1e36dd57f4363ee793a7ed7316e0050cd7055ac27"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Jod replaces N|Solid Hydrogen"
  conflicts_with "nsolid-iron", because: "N|Solid Jod replaces N|Solid Iron"
  conflicts_with "nsolid-krypton", because: "N|Solid Jod replaces N|Solid Krypton"

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
