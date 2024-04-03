class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.12.1-ns5.1.1/artifacts/binaries/nsolid-v5.1.1-iron-darwin-x64.tar.gz"
    sha256 "a72b6df1d8b6a10a620ea58f480d7c8501ba80ccd932a7baf0e11a99acd177bd"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.12.1-ns5.1.1/artifacts/binaries/nsolid-v5.1.1-iron-darwin-arm64.tar.gz"
    sha256 "4e23f68fc96b7f5e31a8e2c9f748b009e3e2ee6eb558733573e05896d1aeaff1"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Iron replaces N|Solid Hydrogen"
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
