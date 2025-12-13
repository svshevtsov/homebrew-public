# homebrew-public

A Homebrew tap containing formulae for personal projects.

## Installation

Add this tap to your Homebrew installation:

```bash
brew tap svshevtsov/public https://github.com/svshevtsov/homebrew-public
```

## Available Formulae

### ClipMon

A macOS command-line tool for monitoring and storing clipboard text entries in a SQLite database.

**Installation:**
```bash
brew install svshevtsov/public/clipmon
```

**Usage:**
```bash
# Start monitoring clipboard (one-time)
clipmon

# Start as a background service
brew services start svshevtsov/public/clipmon

# Stop the service
brew services stop svshevtsov/public/clipmon

# View help
clipmon --help
```

**Features:**
- Real-time clipboard monitoring
- SQLite database storage with metadata
- Configurable via YAML
- Background service support
- Language detection
- Source application tracking

**Configuration:**
The default configuration file is created at `~/.clipmon/config.yaml`. You can customize:
- Database path
- Log level
- Monitor interval
- Maximum entries

**Requirements:**
- macOS (requires accessibility permissions for clipboard monitoring)
- The app will prompt for accessibility permissions on first run

**Source:** [ClipMon on GitHub](https://github.com/svshevtsov/ClipMon)

### AirSync

A macOS GUI application that brings continuity features to Android devices, enabling seamless integration between your Mac and Android phone.

**Installation:**
```bash
brew install svshevtsov/public/airsync
```

**Usage:**
```bash
# Open the application
open $(brew --prefix)/opt/airsync/AirSync.app

# Or create a symlink to Applications for easier access
ln -s $(brew --prefix)/opt/airsync/AirSync.app ~/Applications/AirSync.app
```

**Features:**
- Continuity features between macOS and Android
- Seamless device integration
- Built-in HTTP server for device communication
- QR code pairing
- Media control integration

**Optional Dependencies:**
For enhanced functionality, you can install optional tools:
```bash
brew install scrcpy android-platform-tools media-control
```

**Requirements:**
- macOS 14.5 (Sonoma) or later
- Accessibility and notification permissions (prompted on first run)
- Android device with AirSync companion app

**Source:** [AirSync on GitHub](https://github.com/svshevtsov/airsync-mac)

## Development

This tap follows standard Homebrew formula conventions. For more information about creating formulae, see the [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook).
