class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.15.0-ns5.3.0/artifacts/binaries/nsolid-v5.3.0-iron-darwin-x64.tar.gz"
    sha256 "c79abc01f2213b6ac1fb8bbb986275921dfa7b31bce9ebc92ff077177862de4d"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.15.0-ns5.3.0/artifacts/binaries/nsolid-v5.3.0-iron-darwin-arm64.tar.gz"
    sha256 "3658fefc8b11a5d126338a96e00c0d0fc3752ea343ea58afe1d72445cb870ab5"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Iron replaces N|Solid Hydrogen"
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
