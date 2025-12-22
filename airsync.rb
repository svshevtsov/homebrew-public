class Airsync < Formula
  desc "macOS application bringing continuity features to Android devices"
  homepage "https://github.com/svshevtsov/airsync-mac"
  url "https://github.com/svshevtsov/airsync-mac.git", branch: "r1"
  version "2.1.6-r1"
  license "MPL-2.0"

  depends_on xcode: ["26.0", :build]
  depends_on :macos => :tahoe

  depends_on "scrcpy" => :optional
  depends_on "media-control" => :optional

  def install
    # Build the app using xcodebuild
    system "xcodebuild", "-project", "AirSync.xcodeproj",
                         "-scheme", "AirSync Self Compiled",
                         "-configuration", "Self Compiled",
                         "-derivedDataPath", buildpath/"DerivedData",
                         "SYMROOT=#{buildpath}/build",
                         "DSTROOT=#{buildpath}/dst",
                         "OTHER_SWIFT_FLAGS=-disable-sandbox",
                         "MACOSX_DEPLOYMENT_TARGET=#{MacOS.version}",
                         "-IDEPackageSupportDisablePluginExecutionSandbox=1",
                         "-IDEPackageSupportDisableManifestSandbox=1",
                         "build"

    # Install the app bundle
    prefix.install buildpath/"build/Self Compiled/AirSync.app"
  end

  def caveats
    <<~EOS
      AirSync has been installed to:
        #{prefix}/AirSync.app

      To use AirSync, you can:
        1. Link tha app to your Applications folder: ln -s #{prefix}/AirSync.app ~/Applications/AirSync.app
        2. For enhanced functionality, install optional dependencies:
           brew install scrcpy android-platform-tools media-control

      Note: AirSync requires macOS accessibility and notification permissions
      to enable continuity features between your Mac and Android device.
      You may be prompted to grant these permissions when first running the application.
    EOS
  end

  test do
    assert_predicate prefix/"AirSync.app/Contents/MacOS/AirSync", :exist?
  end
end
