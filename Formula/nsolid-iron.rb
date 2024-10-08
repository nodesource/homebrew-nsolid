class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.0-ns5.3.4/artifacts/binaries/nsolid-v5.3.4-iron-darwin-x64.tar.gz"
    sha256 "e34c314ba4370f55722177da0ec50eb1d6339725bbfbd67fb3fb3b8465fb4aa9"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.18.0-ns5.3.4/artifacts/binaries/nsolid-v5.3.4-iron-darwin-arm64.tar.gz"
    sha256 "a0a28667c1f69e4fb070d367b764484d1217e3f5fa6d8682699ddf10ffe8519e"
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
