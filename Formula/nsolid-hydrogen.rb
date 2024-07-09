class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.3.1/artifacts/binaries/nsolid-v5.3.1-hydrogen-darwin-x64.tar.gz"
    sha256 "11908aa51e6f87c767625cc7fe24c22973b5081861dfb9b9e9f0f8375df1bb5a"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.3.1/artifacts/binaries/nsolid-v5.3.1-hydrogen-darwin-arm64.tar.gz"
    sha256 "3f6d1d2293b675998bfaeebf3b1f41a6e0ff0abedd43ff1b93a3835ad094098a"
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
