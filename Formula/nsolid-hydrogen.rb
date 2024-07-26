class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.3.2/artifacts/binaries/nsolid-v5.3.2-hydrogen-darwin-x64.tar.gz"
    sha256 "1e090da893a7e01391cc2b4575ffe390030f13c9c6979ba950f9de2f12b83553"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.3.2/artifacts/binaries/nsolid-v5.3.2-hydrogen-darwin-arm64.tar.gz"
    sha256 "6161693602a68b9afe7293a70e27bc416311b2b8923d0ae01b5e5ef5da4ee8f1"
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
