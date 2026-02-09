# Cross compile and test on Android 
Generate workspace instructions for cross compiling and testing on Android platform.

## Prerequisites
- Android NDK installed and configured in /home/djshaji/bin/android-ndk-r29/
- Create separate build scripts for Android under scripts/ directory
- Create Android.mk and Application.mk files for Android build system
- Core libraries in libs/core directory
- Create separate test scripts for Android under tests/ directory
- Use Android testing frameworks like JUnit or Espresso for testing on Android
- Create both static and shared libraries for Android
- Put shared libraries in build/libs/{ABI}/
- Put static libraries in build/obj/local/{ABI}/
- Put Android.mk in jni/{project name}/Android.mk for each project in libs/core

## Build Instructions
1. Use Android.mk and Application.mk to define the build configuration for Android
2. Use ndk-build command to build the libraries for Android
3. Specify the target ABI (armeabi-v7a, arm64-v8a, x86, x86_64) in the build scripts
4. Ensure that the built libraries are placed in the correct directories (build/libs/{ABI}/ for shared libraries and build/obj/local/{ABI}/ for static libraries)

## Implementation Status

✅ **README.md** - Updated with comprehensive project overview and build instructions
✅ **ANDROID_BUILD_INSTRUCTIONS.md** - Complete guide for creating Android.mk and Application.mk files

### Detailed Documentation

See [ANDROID_BUILD_INSTRUCTIONS.md](ANDROID_BUILD_INSTRUCTIONS.md) for:
- Complete Android.mk examples for each library (zix, serd, sord, sratom, lilv)
- Application.mk configuration with ABI and build settings
- Both static and shared library build configurations
- Build commands and usage examples
- Troubleshooting guide
- Integration with Android Studio projects

### Quick Start

```bash
# 1. Set up NDK environment
export NDK_HOME=/home/djshaji/bin/android-ndk-r29

# 2. Create jni/ directory structure and Android.mk files
# (See ANDROID_BUILD_INSTRUCTIONS.md for complete templates)

# 3. Build all libraries
cd /path/to/opiqo-build
ndk-build

# Output:
# - Shared libs: libs/{ABI}/lib*.so
# - Static libs: obj/local/{ABI}/lib*.a
```

### Library Dependencies
Build order (dependencies listed):
1. **zix** → No dependencies
2. **serd** → Depends on zix
3. **sord** → Depends on serd, zix
4. **sratom** → Depends on sord, serd, zix
5. **lilv** → Depends on sratom, sord, serd, zix
