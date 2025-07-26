# Audio Devices

[![Build Wheels](https://github.com/nohanaga/audio_devices/actions/workflows/build-wheels.yml/badge.svg)](https://github.com/nohanaga/audio_devices/actions/workflows/build-wheels.yml)

Cross-platform audio device enumeration library for Python.

## Features

- List audio input/output devices
- Cross-platform support (Windows, macOS, Linux)
- No external dependencies

## Installation

```bash
# From source
git clone https://github.com/nohanaga/audio_devices.git
cd audio_devices
pip install -e .

# Or install from wheel (download from GitHub Releases)
pip install audio_devices-0.1.0-cp39-cp39-macosx_10_9_x86_64.whl
```

## Usage

```python
import audio_devices

# List all audio devices
devices = audio_devices.list_audio_devices()
for device in devices:
    print(device)
```

## Supported Platforms

- ✅ **macOS**: CoreAudio API
- ✅ **Windows**: WASAPI  
- ⚠️ **Linux**: Coming soon

## Development

```bash
git clone https://github.com/nohanaga/audio_devices.git
cd audio_devices
pip install -e .
```

## Building Wheels

Wheels are automatically built for multiple platforms using GitHub Actions:

- **Windows**: `win32`, `win_amd64`
- **macOS**: `macosx_*_x86_64`, `macosx_*_arm64`  
- **Linux**: `linux_x86_64`

## License

MIT License
