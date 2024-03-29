class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.0-ns5.1.0/artifacts/binaries/nsolid-v5.1.0-hydrogen-darwin-x64.tar.gz"
    sha256 "9ae7d82ae6ce0d13746daf571cd9c3a4e4e1f2fc8ecf4503ebde74165ffa41f9"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.0-ns5.1.0/artifacts/binaries/nsolid-v5.1.0-hydrogen-darwin-arm64.tar.gz"
    sha256 "702f7c8c4e9ef71103fc55531ef24784a620b8ce5573a1bb2b539e0d9b2ebcd1"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-iron", because: "N|Solid Hydrogen replaces N|Solid Iron"
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
