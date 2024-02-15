class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.19.1-ns5.0.5/artifacts/binaries/nsolid-v5.0.5-hydrogen-darwin-x64.tar.gz"
    sha256 "be4c67e364293310533b1ca98a41a6e4aa9de9d47a24ae398d5f791219a9f1f8"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.19.1-ns5.0.5/artifacts/binaries/nsolid-v5.0.5-hydrogen-darwin-arm64.tar.gz"
    sha256 "ed8f9230804857cbd498479ec0c56f9c77bdac1bf0907cfe1530ab05a9cddbe2"
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
