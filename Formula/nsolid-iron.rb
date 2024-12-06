class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.1-ns5.5.0/artifacts/binaries/nsolid-v5.5.0-iron-darwin-x64.tar.gz"
    sha256 "3c16684e6ae9a6b54d689552e54aea28e0f0a9a8168b9ed5f2913a80926a9d59"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.1-ns5.5.0/artifacts/binaries/nsolid-v5.5.0-iron-darwin-arm64.tar.gz"
    sha256 "2ec871bf26ce67d8856ead489a596e5d5914bfd5f195cf33fc3c7fc153c6014d"
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
