class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.9.0-ns5.0.0/artifacts/binaries/nsolid-v5.0.0-iron-darwin-x64.tar.gz"
  sha256 "f46e85f9acadb46a54a3639fa6c3ff9a662b68701b0fb8cb7aebcdac1df46b5f"

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
