class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.15.1-ns5.3.1/artifacts/binaries/nsolid-v5.3.1-iron-darwin-x64.tar.gz"
    sha256 "2aa6470ba468f49286c1831e713b2cc644d3ea8ad8a8aeaaec3c72a587d543b8"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.15.1-ns5.3.1/artifacts/binaries/nsolid-v5.3.1-iron-darwin-arm64.tar.gz"
    sha256 "7f48237baf0af776ef3cec2f2d4105d259210f76631563a4137b1703087a36cf"
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
