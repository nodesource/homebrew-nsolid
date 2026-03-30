class NsolidJod < Formula
  desc "N|Solid Runtime Jod"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.22.2-ns6.2.2/artifacts/binaries/nsolid-v6.2.2-jod-darwin-x64.tar.gz"
    sha256 "4fa5504e18ead84c3db2bccc443d140c0f07f784dee3b6ee7dd5e61fd2c87902"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.22.2-ns6.2.2/artifacts/binaries/nsolid-v6.2.2-jod-darwin-arm64.tar.gz"
    sha256 "d4c2e5588a9c5b395e68fdf346040e6b84de79c65a93fd4cd92594d2882e64a4"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Jod replaces N|Solid Hydrogen"
  conflicts_with "nsolid-iron", because: "N|Solid Jod replaces N|Solid Iron"
  conflicts_with "nsolid-krypton", because: "N|Solid Jod replaces N|Solid Krypton"
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
