class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.6-ns5.7.0/artifacts/binaries/nsolid-v5.7.0-hydrogen-darwin-x64.tar.gz"
    sha256 "2dac3609634b38bb57886c93041890c81e17012aa0b11f04d99a1ed985105669"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.6-ns5.7.0/artifacts/binaries/nsolid-v5.7.0-hydrogen-darwin-arm64.tar.gz"
    sha256 "a1e155848f7910fa9a56ecea27ff66e3b6f2b08f5dfdf2ec18bdd42febae1526"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-iron", because: "N|Solid Hydrogen replaces N|Solid Iron"
  conflicts_with "nsolid-jod", because: "N|Solid Hydrogen replaces N|Solid Jod"
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
