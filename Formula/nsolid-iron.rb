class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.13.1-ns5.2.2/artifacts/binaries/nsolid-v5.2.2-iron-darwin-x64.tar.gz"
    sha256 "eb7483d2e06f2e7f719df387ba3608e47cbf3fe32c463d605dea750feb6be486"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.13.1-ns5.2.2/artifacts/binaries/nsolid-v5.2.2-iron-darwin-arm64.tar.gz"
    sha256 "2794ec3f764ca88b05a2cac6b95e56d366066e1fe4b2204e0fd35bd126f8691a"
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
