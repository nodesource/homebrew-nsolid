class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.1-ns5.5.0/artifacts/binaries/nsolid-v5.5.0-iron-darwin-x64.tar.gz"
    sha256 "f41dd017e5edc72a53285594b82599943eab672822d1dc33f5a3b26369c80c84"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.1-ns5.5.0/artifacts/binaries/nsolid-v5.5.0-iron-darwin-arm64.tar.gz"
    sha256 "b66594a73d270f707704e14f284f3620b1e4aed5ee123f0bc406ac2201ff9488"
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
