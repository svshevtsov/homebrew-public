class Clipmon < Formula
  desc "macOS command-line tool for monitoring and storing clipboard text entries"
  homepage "https://github.com/svshevtsov/ClipMon"
  url "https://github.com/svshevtsov/ClipMon.git", tag: "v1.0.0"
  license "MIT"

  depends_on "swift" => :build
  depends_on xcode: ["12.0", :build]
  depends_on :macos

  def install
    # Build the app using xcodebuild
    system "xcodebuild", "-project", "ClipMon.xcodeproj",
                         "-scheme", "ClipMon",
                         "-configuration", "Release",
                         "-derivedDataPath", buildpath/"DerivedData",
                         "SYMROOT=#{buildpath}/build",
                         "DSTROOT=#{buildpath}/dst",
                         "MACOSX_DEPLOYMENT_TARGET=#{MacOS.version}",
                         "build"

    # Install the binary
    app_path = buildpath/"build/Release/ClipMon.app"
    bin.install app_path/"Contents/MacOS/ClipMon" => "clipmon"
    
    # Create config directory
    (etc/"clipmon").mkpath
    
    # Install example config if it exists
    if File.exist?("config.yaml.example")
      (etc/"clipmon").install "config.yaml.example"
    end
  end

  def post_install
    # Create user config directory
    (var/"log/clipmon").mkpath
    config_dir = Pathname.new(Dir.home)/".clipmon"
    config_dir.mkpath unless config_dir.exist?
    
    # Create default config if it doesn't exist
    config_file = config_dir/"config.yaml"
    unless config_file.exist?
      config_file.write <<~EOS
        database_path: "~/.clipmon/clipboard_history.db"
        log_level: "info"
        monitor_interval: 1.0
        max_entries: 10000
      EOS
    end
  end

  service do
    run [opt_bin/"clipmon"]
    environment_variables PATH: std_service_path_env
    keep_alive true
    log_path var/"log/clipmon/clipmon.log"
    error_log_path var/"log/clipmon/clipmon.log"
    working_dir var/"log/clipmon"
  end

  test do
    # Test that the binary runs and shows help
    system bin/"clipmon", "--help"
  end

  def caveats
    <<~EOS
      ClipMon has been installed as a service that can be started with:
        brew services start clipmon

      Configuration file is located at:
        ~/.clipmon/config.yaml

      To customize settings, edit the config file before starting the service.

      Note: ClipMon requires macOS accessibility permissions to monitor the clipboard.
      You may be prompted to grant these permissions when first running the application.

      Database will be stored at:
        ~/.clipmon/clipboard_history.db (by default)

      View logs with:
        tail -f $(brew --prefix)/var/log/clipmon/clipmon.log
    EOS
  end
end