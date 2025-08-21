# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Homebrew tap repository containing formulae for personal projects. The primary purpose is to distribute macOS applications and CLI tools through Homebrew's package management system.

## Repository Structure

```
homebrew-public/
├── README.md          # Documentation for users
├── CLAUDE.md         # This file - guidance for Claude Code
└── clipmon.rb        # Homebrew formula for ClipMon app
```

## Current Formulae

### ClipMon (`clipmon.rb`)
- **Purpose**: macOS clipboard monitoring tool with SQLite storage
- **Language**: Swift (built with xcodebuild)
- **Features**: Real-time monitoring, background service support, YAML configuration
- **Source**: https://github.com/svshevtsov/ClipMon

## Common Development Tasks

### Adding a New Formula
1. Create a new `.rb` file with the formula class
2. Follow Homebrew formula conventions (see [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook))
3. Update README.md to document the new formula
4. Test the formula locally before committing

### Formula Validation
```bash
# Check Ruby syntax
ruby -c formula_name.rb

# Test installation (requires the tap to be added)
brew install --build-from-source svshevtsov/public/formula_name
```

### Formula Structure
- Use `xcodebuild` for Swift/Xcode projects
- Include service blocks for background processes
- Add caveats for user permissions or setup requirements
- Use `post_install` for creating config directories

## Homebrew Tap Conventions

- Formula files should be lowercase with `.rb` extension
- Class names should be CamelCase matching the formula purpose
- Include proper dependencies (`:build`, `:macos`, etc.)
- Add comprehensive test blocks
- Document installation and usage in caveats

## Git Information

- **Main Branch**: master
- **Repository Type**: Homebrew tap
- **Target Platform**: macOS