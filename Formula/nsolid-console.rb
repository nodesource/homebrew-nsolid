class NsolidConsole < Formula
  desc "N|Solid Console"
  homepage "https://nodesource.com/products/nsolid"
  url "https://s3-us-west-2.amazonaws.com/nodesource-public-downloads/4.1.0/artifacts/bundles/nsolid-bundle-v4.1.0-darwin-x64/nsolid-console-v4.1.0-darwin-x64.tar.gz"
  sha256 "693162539ddfbfad33bf3dec4f310ab3268476b4372d446b7b21b29d7fd618c4"
  version "4.1.0"

  depends_on :macos => :yosemite
  depends_on "nsolid"

  bottle :unneeded

  def install
    bin.install "scripts/nsolid-console"
    prefix.install Dir["*"]
  end

  def caveats
    s = <<~EOS
      N|Solid Console installed successfully.

      To start the console run the command 'nsolid-console'

      After the console is running, you can view it at 'http://localhost:6753'
    EOS
    s
  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/nsolid-console</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardOutPath</key>
      <string>/tmp/nsolid-console.log</string>
      <key>StandardErrorPath</key>
      <string>/tmp/nsolid-console.log</string>
    </dict>
    </plist>
    EOS
  end

end
