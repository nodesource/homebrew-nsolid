class NsolidKrypton < Formula
  desc "N|Solid Runtime Krypton"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.11.1-ns6.1.1/artifacts/binaries/nsolid-v6.1.1-krypton-darwin-x64.tar.gz"
    sha256 "009849364aac9d4bad286d108995e7fae1d29e0067323dc3a7c42435118cb603"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/24.11.1-ns6.1.1/artifacts/binaries/nsolid-v6.1.1-krypton-darwin-arm64.tar.gz"
    sha256 "8471c5b94e1ae150e5d3ebf5eaf356e456f2306769627b112e9d18dc9c743630"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Krypton replaces N|Solid Hydrogen"
  conflicts_with "nsolid-iron", because: "N|Solid Krypton replaces N|Solid Iron"
  conflicts_with "nsolid-jod", because: "N|Solid Krypton replaces N|Solid Jod"
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
