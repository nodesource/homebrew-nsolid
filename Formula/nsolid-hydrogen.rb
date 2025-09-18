class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.8-ns5.7.2/artifacts/binaries/nsolid-v5.7.2-hydrogen-darwin-x64.tar.gz"
    sha256 "fd4c714c590cecbadca62e4cc0e418e4dc91e1074e2782256bac06a92bd5c53d"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.8-ns5.7.2/artifacts/binaries/nsolid-v5.7.2-hydrogen-darwin-arm64.tar.gz"
    sha256 "a6e4ca7891cca63d59ccb0dd262847d0af2ea039ecd514ede91b5dfb848a8bea"
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
