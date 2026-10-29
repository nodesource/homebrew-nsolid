class NsolidLithium < Formula
  desc "N|Solid Runtime Lithium"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/26.13.0-ns6.3.9/artifacts/binaries/nsolid-v6.3.9-lithium-darwin-x64.tar.gz"
    sha256 "30ae5897b69dea79349b7464c1a5f4f2e8bf61cd539416c17b42cd566442e0c7"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/26.13.0-ns6.3.9/artifacts/binaries/nsolid-v6.3.9-lithium-darwin-arm64.tar.gz"
    sha256 "b18698aea2d90bd71aeef8d6368d44298a1d090a91b4cd6c306402b359ed185c"
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
