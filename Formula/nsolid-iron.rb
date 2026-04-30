class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.4/artifacts/binaries/nsolid-v6.2.4-iron-darwin-x64.tar.gz"
    sha256 "d51509de60d78ae72b4481da2b44bcee28363e8b4ab9001f7e362e9a2f946168"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.4/artifacts/binaries/nsolid-v6.2.4-iron-darwin-arm64.tar.gz"
    sha256 "42a7dcd4f0b458ea87d9415774761e651f4cfce3a44fb43a1e21f01ce2ec2040"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.20.2-ns6.2.4/artifacts/binaries/nsolid-v6.2.4-iron-darwin-arm64.tar.gz"
    sha256 "42a7dcd4f0b458ea87d9415774761e651f4cfce3a44fb43a1e21f01ce2ec2040"
  end

  conflicts_with "node", because: "N|Solid replaces NodeJS"
  conflicts_with "nsolid-hydrogen", because: "N|Solid Iron replaces N|Solid Hydrogen"
  conflicts_with "nsolid-jod", because: "N|Solid Jod replaces N|Solid Iron"
  conflicts_with "nsolid-krypton", because: "N|Solid Krypton replaces N|Solid Iron"
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
