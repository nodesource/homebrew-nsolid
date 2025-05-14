class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.8-ns5.7.1/artifacts/binaries/nsolid-v5.7.1-hydrogen-darwin-x64.tar.gz"
    sha256 "35d3f70211b6717843b5a8f97d6560ecf261a1b258a33414e8f9343aa87b3e9b"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.8-ns5.7.1/artifacts/binaries/nsolid-v5.7.1-hydrogen-darwin-arm64.tar.gz"
    sha256 "28846ad82617a8edbb77f3365f2556159b0647e9840e10b784151bcd75d1c224"
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
