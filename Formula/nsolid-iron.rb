class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"
  url "https://nodesource-rc-builds.s3.us-west-2.amazonaws.com/2023-10-24/18.18.2-ns4.9.5/artifacts/binaries/nsolid-v4.9.5-iron-darwin-x64.tar.gz"
  sha256 "NUEVO_SHA256_PARA_IRON"

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-gallium", because: "N|Solid Iron replaces N|Solid Gallium"
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
