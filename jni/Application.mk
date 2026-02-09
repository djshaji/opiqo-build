# Application.mk - Global Android build configuration

# Target Android API level (minimum 21 for 64-bit support)
APP_PLATFORM := android-34

# Target ABIs (architectures)
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64

# STL library to use
APP_STL := c++_shared

# Build mode (release or debug)
APP_OPTIM := release

# Build both shared and static libraries
APP_MODULES := \
	zix zix_static \
	serd serd_static \
	sord sord_static \
	sratom sratom_static \
	lilv lilv_static

# Enable C++17 features
APP_CPPFLAGS := -std=c++17 -fexceptions -frtti

# Global compiler flags
APP_CFLAGS := -O2 -DANDROID -D_ANDROID_ -fPIC

# Short commands for better readability in build output
APP_SHORT_COMMANDS := true

# Allow undefined symbols (will be resolved at runtime)
APP_ALLOW_MISSING_DEPS := false
