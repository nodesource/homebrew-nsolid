class NsolidJod < Formula
  desc "N|Solid Runtime Jod"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.23.2-ns6.3.4/artifacts/binaries/nsolid-v6.3.4-jod-darwin-x64.tar.gz"
    sha256 "5c9838738f35a3f516659c3471068c9ea4a505febbee303bf3392e2e6faf0563"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.23.2-ns6.3.4/artifacts/binaries/nsolid-v6.3.4-jod-darwin-arm64.tar.gz"
    sha256 "2ac10ff231a5af79272d327289b769e68c9ec209682ee0fcf1acf1e0ff307ff8"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Jod replaces N|Solid Hydrogen"
  conflicts_with "nsolid-iron", because: "N|Solid Jod replaces N|Solid Iron"
  conflicts_with "nsolid-krypton", because: "N|Solid Jod replaces N|Solid Krypton"

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
