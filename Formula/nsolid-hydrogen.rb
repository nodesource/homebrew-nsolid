class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.8.1-ns4.9.4/artifacts/binaries/nsolid-v4.9.4-hydrogen-darwin-x64.tar.gz"
  sha256 "43f5423851e33c8fe6526557c7656c35481abfcc12c6925a2f76b1713d06d942"

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-gallium", because: "N|Solid Hydrogen replaces N|Solid Gallium"
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
