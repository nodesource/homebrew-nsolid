class NsolidLithium < Formula
  desc "N|Solid Runtime Lithium"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/26.13.1-ns6.3.10/artifacts/binaries/nsolid-v6.3.10-lithium-darwin-x64.tar.gz"
    sha256 "b6e2e39d91ec39040897db6a8c768a74dc9a5bc8757eec84d18c38edf406c568"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/26.13.1-ns6.3.10/artifacts/binaries/nsolid-v6.3.10-lithium-darwin-arm64.tar.gz"
    sha256 "bbe335aaf2ac32d47b2b3ee0dbffe299efce12981270dc8f53e00dc7f13a109e"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Lithium replaces N|Solid Hydrogen"
  conflicts_with "nsolid-iron", because: "N|Solid Lithium replaces N|Solid Iron"
  conflicts_with "nsolid-jod", because: "N|Solid Lithium replaces N|Solid Jod"
  conflicts_with "nsolid-krypton", because: "N|Solid Lithium replaces N|Solid Krypton"

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
