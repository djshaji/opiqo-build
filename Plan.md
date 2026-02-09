# Cross compile and test on Android 
Generate workspace instructions for cross compiling and testing on Android platform.
## Prerequisites
- Android NDK installed and configured in /home/djshaji/bin/android-ndk-r29/
- Create separate build scripts for Android under scripts/ directory
- Create Android.mk and Application.mk files for Android build system
- Core libraries in lib/core directory
- Create separate test scripts for Android under tests/ directory
- Use Android testing frameworks like JUnit or Espresso for testing on Android
- Create both static and shared libraries for Android
- Put shared libraries in build/libs/{ABI}/
- Put static libraries in build/obj/local/{ABI}/
- Put Android.mk in scripts/{project name}/Android.mk for each project in libs/core


## Build Instructions
1. Use Android.mk and Application.mk to define the build configuration for Android
2. Use ndk-build command to build the libraries for Android
3. Specify the target ABI (armeabi-v7a, arm64-v8a, x86, x86_64) in the build scripts
4. Ensure that the built libraries are placed in the correct directories (build/libs/{ABI}/ for shared libraries and build/obj/local/{ABI}/ for static libraries)
