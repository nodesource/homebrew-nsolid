class NsolidIron < Formula
  desc "N|Solid Runtime Iron"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.6-ns6.1.0/artifacts/binaries/nsolid-v6.1.0-iron-darwin-x64.tar.gz"
    sha256 "077df18fef347aae8e70f2cfc5031bfdd686568feeefcfc53b17d8b027571f3b"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.6-ns6.1.0/artifacts/binaries/nsolid-v6.1.0-iron-darwin-arm64.tar.gz"
    sha256 "6a4b66b541250b9f6036d623615d4325e85f3f6aa391ad0cb9d513ca2e3fcca3"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/20.19.6-ns6.1.0/artifacts/binaries/nsolid-v6.1.0-iron-darwin-arm64.tar.gz"
    sha256 "6a4b66b541250b9f6036d623615d4325e85f3f6aa391ad0cb9d513ca2e3fcca3"
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
