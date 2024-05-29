class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.14.0-ns5.2.3/artifacts/binaries/nsolid-v5.2.3-iron-darwin-x64.tar.gz"
    sha256 "14660430045c3566bcf3555f82b58ac41ec4ae42706c9dad33078e79fa3d9c32"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.14.0-ns5.2.3/artifacts/binaries/nsolid-v5.2.3-iron-darwin-arm64.tar.gz"
    sha256 "109b3e5b8d97df31fd91e35fcef2e4c962802a6c6bd2ce4d700c5a2be4a2a246"
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
