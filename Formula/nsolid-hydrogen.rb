class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.2-ns5.1.2/artifacts/binaries/nsolid-v5.1.2-hydrogen-darwin-x64.tar.gz"
    sha256 "60f46d29d5bba77dbe91c5a016c5707e00b1ad9264539993dc60d7bde08585a2"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.2-ns5.1.2/artifacts/binaries/nsolid-v5.1.2-hydrogen-darwin-arm64.tar.gz"
    sha256 "79a50813298076da8b3b2eaaadc1a49fcb89837cced8def2cb165c0b5f7ad8e0"
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
