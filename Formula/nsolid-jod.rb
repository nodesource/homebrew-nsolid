class NsolidJod < Formula
  desc "N|Solid Runtime Jod"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.23.3-ns6.3.7/artifacts/binaries/nsolid-v6.3.7-jod-darwin-x64.tar.gz"
    sha256 "860e8ecc9f57ee9538b9c0652b3193130c102157f6575a40a5d07f51bbd1a87c"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/22.23.3-ns6.3.7/artifacts/binaries/nsolid-v6.3.7-jod-darwin-arm64.tar.gz"
    sha256 "7b36ddf0f1b86da176ba19ebee796fc791ad4995932fe184897ab94a22e6d2bb"
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
