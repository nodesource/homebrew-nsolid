class NsolidJod < Formula
  desc "N|Solid Runtime Jod"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.22.2-ns6.2.4/artifacts/binaries/nsolid-v6.2.4-jod-darwin-x64.tar.gz"
    sha256 "0487154e24245a4330cba3caaef6bbf7e1513f6bdc8e499086af2835fafd1bf8"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.22.2-ns6.2.4/artifacts/binaries/nsolid-v6.2.4-jod-darwin-arm64.tar.gz"
    sha256 "33bbaddcb05acb1a4a65303501acf9af5f5e41f4507cc04e3893a24d8a9be45c"
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
