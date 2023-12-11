class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.10.0-ns5.0.1/artifacts/binaries/nsolid-v5.0.1-iron-darwin-x64.tar.gz"
  sha256 "4a9e19eb14a1b0c707ed5c67105ba42f3ee367c70d5604c800aae50487290082"

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
