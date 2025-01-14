class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.5-ns5.6.0/artifacts/binaries/nsolid-v5.6.0-hydrogen-darwin-x64.tar.gz"
    sha256 "2b8c350da31038c921e1dc726d640b41ffcc20109dd8320c613e5a080717929e"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.5-ns5.6.0/artifacts/binaries/nsolid-v5.6.0-hydrogen-darwin-arm64.tar.gz"
    sha256 "11ec85e4406b3ef7ab90cf5b72a8263d96ddb5eea3d0488167e103eb1676c815"
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
