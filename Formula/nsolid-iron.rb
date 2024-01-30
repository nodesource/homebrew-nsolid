class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.11.0-ns5.0.1/artifacts/binaries/nsolid-v5.0.1-iron-darwin-x64.tar.gz"
    sha256 "eb9c9d546931ed7738b9af4cccf8318ae57e35c7e51f612408cf7c9a2b594e45"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.11.0-ns5.0.1/artifacts/binaries/nsolid-v5.0.1-iron-darwin-arm64.tar.gz"
    sha256 "c0e95e724ce0e957b82c2149dee75d2a4b83d42c837bf0a3ca0c2c082aa1f06f"
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
