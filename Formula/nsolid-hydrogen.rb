class NsolidHydrogen < Formula
  desc "N|Solid Runtime Hydrogen"
  homepage "https://nodesource.com/products/nsolid"

  if Hardware::CPU.intel?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.4.0/artifacts/binaries/nsolid-v5.4.0-hydrogen-darwin-x64.tar.gz"
    sha256 "c5ce950362b55964451029edfb4583890d5fba4dc8d7c1018106d8681adf7075"
  elsif Hardware::CPU.arm?
    url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/18.20.4-ns5.4.0/artifacts/binaries/nsolid-v5.4.0-hydrogen-darwin-arm64.tar.gz"
    sha256 "670acefcec3ab18bdb28210fd7f08ccccf5088215681fc092619ff27c63812eb"
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
