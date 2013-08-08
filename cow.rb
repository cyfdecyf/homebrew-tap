require 'formula'

VERSION="0.7.6"

class Cow < Formula
  homepage 'http://github.com/cyfdecyf/cow/'
  url "http://dl.chenyufei.info/cow/cow-mac64-#{VERSION}.gz"
  sha1 'b048275c10fc89b6a0884116aab73e4dbe70cab2'

  def install
    FileUtils.mv "cow-mac64-#{VERSION}", "cow"
    bin.install "cow"

    docbase = 'https://github.com/cyfdecyf/cow/raw/master/doc'
    system "curl -s -L #{docbase}/sample-config/rc -o #{prefix}/rc"
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
        <dict>
          <key>NetworkState</key>
          <true/>
        </dict>
      </dict>
    </plist>
    EOS
  end
end

