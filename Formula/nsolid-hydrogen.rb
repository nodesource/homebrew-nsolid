class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.19.0-ns5.0.1/artifacts/binaries/nsolid-v5.0.1-hydrogen-darwin-x64.tar.gz"
  sha256 "e3562554e849a2e8c3456e3db010e73b621727ecdd7007942ddf71ab6dd58f36"

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
