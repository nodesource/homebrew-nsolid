class NsolidConsole < Formula
  desc "N|Solid Console"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/3.0.5/artifacts/bundles/nsolid-bundle-v3.0.5-darwin-x64/nsolid-console-v3.0.5-darwin-homebrew.tar.gz"
  sha256 "dd887520087b223b38aa224a99a2adf937453d9bae0d055561d2d65f09bf2325"
  version "3.0.5"

  depends_on :macos => :yosemite
  depends_on "nsolid"

  bottle :unneeded

  def install
    bin.install "scripts/nsolid-console"
    prefix.install Dir["*"]
  end

  def post_install
    ohai "N|Solid Console installed successfully."
    ohai ""
    ohai "To start the console run the command 'nsolid-console'"
    ohai ""
    ohai "After the console is running, you can view it at 'http://localhost:6753'"
    ohai ""
  end
end
