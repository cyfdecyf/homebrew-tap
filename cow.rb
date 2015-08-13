require 'formula'

VERSION="0.9.6"

class Cow < Formula
  homepage 'http://github.com/cyfdecyf/cow/'
  url "http://dl.chenyufei.info/cow/#{VERSION}/cow-mac64-#{VERSION}.gz"
  sha1 '5dbfadc6e9560e36b54e4b06e715c95e3c63b4ab'

  def install
    FileUtils.mv "cow-mac64-#{VERSION}", "cow"
    bin.install "cow"

    docbase = 'https://github.com/cyfdecyf/cow/raw/master/doc'
    system "curl -L #{docbase}/sample-config/rc -o #{prefix}/rc"
  end

  def caveats; <<-EOS.undent
    Example configuration file (with detailed comments): #{prefix}/rc
    Copy it to ~/.cow/rc to use.

    If you previously installed cow with the install script, please take
    a look at the launchd plist and check if path to cow is correct.
    EOS
  end

  # Override Formular#plist_name
  def plist_name; "info.chenyufei.cow" end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_prefix}/bin/cow</string>
        </array>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
    EOS
  end
end

