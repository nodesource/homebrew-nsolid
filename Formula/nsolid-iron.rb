class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.17.0-ns5.3.3/artifacts/binaries/nsolid-v5.3.3-iron-darwin-x64.tar.gz"
    sha256 "ca5597a56dff6ec0007703cad3739cba5bedee1f2d1eb452f83cd47cd961b7c3"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.17.0-ns5.3.3/artifacts/binaries/nsolid-v5.3.3-iron-darwin-arm64.tar.gz"
    sha256 "7c4f0e0ccc0ddfb6033a423ddaacfb32873142837814a8e998558f9d23c98353"
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
