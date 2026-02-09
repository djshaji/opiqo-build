# opiqo-build

Cross-compilation build system for core audio libraries (zix, serd, sord, sratom, lilv) targeting Android platform.

## Overview

This project provides build infrastructure to compile LV2 audio plugin host libraries for Android using the Android NDK and ndk-build system.

## Prerequisites

- **Android NDK**: Installed and configured at `/home/djshaji/bin/android-ndk-r29/`
- **Core Libraries**: Located in `libs/core/` directory
  - zix - Utility library
  - serd - RDF serialization
  - sord - RDF storage
  - sratom - Atom serialization
  - lilv - LV2 plugin host library

## Project Structure

```
opiqo-build/
├── libs/
│   └── core/          # Core library source code
│       ├── zix/
│       ├── serd/
│       ├── sord/
│       ├── sratom/
│       └── lilv/
├── scripts/
│   └── {project}/     # Build scripts for each library
│       └── Android.mk # Android makefile for each project
├── build/
│   ├── libs/{ABI}/    # Shared libraries output (.so files)
│   └── obj/local/{ABI}/ # Static libraries and object files
├── tests/
│   └── android/       # Android test scripts
└── Application.mk     # Global Android build configuration
```

## Build Instructions

### Using ndk-build

1. **Set up environment variables:**
   ```bash
   export NDK_HOME=/home/djshaji/bin/android-ndk-r29
   export PATH=$NDK_HOME:$PATH
   ```

2. **Configure target ABI** in `Application.mk`:
   - `armeabi-v7a` - 32-bit ARM (legacy devices)
   - `arm64-v8a` - 64-bit ARM (modern devices, recommended)
   - `x86` - 32-bit Intel (emulator)
   - `x86_64` - 64-bit Intel (emulator)

3. **Build all libraries:**
   ```bash
   ndk-build
   ```

4. **Build specific library:**
   ```bash
   ndk-build -C scripts/{library_name}
   ```

### Build Output

- **Shared libraries (.so)**: `build/libs/{ABI}/`
- **Static libraries (.a)**: `build/obj/local/{ABI}/`

Example output structure:
```
build/
├── libs/
│   └── arm64-v8a/
│       ├── libzix.so
│       ├── libserd.so
│       ├── libsord.so
│       ├── libsratom.so
│       └── liblilv.so
└── obj/
    └── local/
        └── arm64-v8a/
            ├── libzix.a
            ├── libserd.a
            ├── libsord.a
            ├── libsratom.a
            └── liblilv.a
```

## Android.mk Configuration

Each library in `scripts/{project_name}/Android.mk` defines:
- Source files
- Include directories
- Dependencies on other libraries
- Compiler flags
- Export configurations

## Application.mk Configuration

Top-level `Application.mk` defines:
- Target Android API level
- Target ABIs
- STL library selection
- Global compiler/linker flags
- Build mode (debug/release)

## Testing on Android

### Prerequisites
- Android device or emulator
- ADB (Android Debug Bridge)

### Running Tests

1. **Connect device/emulator:**
   ```bash
   adb devices
   ```

2. **Run test suite:**
   ```bash
   cd tests/android
   ./run_tests.sh
   ```

3. **Test with specific ABI:**
   ```bash
   ./run_tests.sh --abi arm64-v8a
   ```

### Testing Frameworks
- JUnit for Java-based tests
- Espresso for UI testing
- Native C/C++ tests via command line

## Integration with Android Apps

### Using in Android Studio Project

1. **Copy libraries** to your project:
   ```
   YourApp/app/src/main/jniLibs/{ABI}/lib*.so
   ```

2. **Load libraries** in Java/Kotlin:
   ```java
   static {
       System.loadLibrary("zix");
       System.loadLibrary("serd");
       System.loadLibrary("sord");
       System.loadLibrary("sratom");
       System.loadLibrary("lilv");
   }
   ```

3. **Link in native code** (Android.mk):
   ```makefile
   LOCAL_SHARED_LIBRARIES := libzix libserd libsord libsratom liblilv
   ```

## Dependencies

Library build order (dependencies must be built first):
1. **zix** (no dependencies)
2. **serd** (depends on zix)
3. **sord** (depends on serd, zix)
4. **sratom** (depends on sord, serd, zix)
5. **lilv** (depends on all above)

## Supported Android Versions

- **Minimum API Level**: 21 (Android 5.0 Lollipop)
- **Target API Level**: 28+ (Android 9.0 Pie or later)
- **Recommended**: API 28+ for best compatibility

## Build System

This project uses the Android NDK build system (`ndk-build`) with:
- **Android.mk**: Defines modules and build rules
- **Application.mk**: Defines application-wide settings
- Automatic dependency resolution
- Multi-ABI support
- Both static and shared library generation

## License

See individual library licenses in `libs/core/{library}/COPYING` or `LICENSE` files.

## References

- [Android NDK Documentation](https://developer.android.com/ndk)
- [ndk-build Guide](https://developer.android.com/ndk/guides/ndk-build)
- [LV2 Plugin Specification](https://lv2plug.in/)
- Individual library documentation in respective directories
