class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.3-ns5.2.3/artifacts/binaries/nsolid-v5.2.3-hydrogen-darwin-x64.tar.gz"
    sha256 "4fe34e6ee8ca503f83a79a6e4f8e37d8cf3728e12caa1952e41366fae7ede7b1"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.3-ns5.2.3/artifacts/binaries/nsolid-v5.2.3-hydrogen-darwin-arm64.tar.gz"
    sha256 "247511f710e431753c7c5446a95a556545b0a5ef1deaff9f797d52076b39001a"
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
