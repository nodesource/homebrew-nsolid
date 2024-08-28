class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.3.3/artifacts/binaries/nsolid-v5.3.3-hydrogen-darwin-x64.tar.gz"
    sha256 "4cf22d929b726448695cf30ac1a6da85897ca43605d63c4a41a8b441235b920f"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.3.3/artifacts/binaries/nsolid-v5.3.3-hydrogen-darwin-arm64.tar.gz"
    sha256 "c593d241daef8f8740c52c8ea2d29b7d8061414c82218049734a606d1aa7df52"
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
