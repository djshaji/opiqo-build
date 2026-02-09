# Android Build Instructions using ndk-build

This guide provides step-by-step instructions for creating Android.mk and Application.mk files to build the opiqo-build libraries (zix, serd, sord, sratom, lilv) for Android using ndk-build.

Target API Level 34

## Directory Structure

```
opiqo-build/
├── jni/
│   ├── Android.mk          # Top-level makefile
│   ├── Application.mk      # Global build configuration
│   ├── zix/
│   │   └── Android.mk      # zix library makefile
│   ├── serd/
│   │   └── Android.mk      # serd library makefile
│   ├── sord/
│   │   └── Android.mk      # sord library makefile
│   ├── sratom/
│   │   └── Android.mk      # sratom library makefile
│   └── lilv/
│       └── Android.mk      # lilv library makefile
├── libs/
│   └── core/               # Source code
│       ├── zix/
│       ├── serd/
│       ├── sord/
│       ├── sratom/
│       └── lilv/
└── build/
    ├── libs/{ABI}/         # Output shared libraries (.so)
    └── obj/local/{ABI}/    # Output static libraries (.a)
```

## Application.mk Configuration

Create `jni/Application.mk` with global build settings:

```makefile
# Application.mk - Global Android build configuration

# Target Android API level (minimum 21 for 64-bit support)
APP_PLATFORM := android-21

# Target ABIs (architectures)
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64

# STL library to use
APP_STL := c++_shared

# Build mode (release or debug)
APP_OPTIM := release

# Enable C++11 features
APP_CPPFLAGS := -std=c++11 -fexceptions -frtti

# Global compiler flags
APP_CFLAGS := -O2 -DANDROID -D_ANDROID_ -fPIC

# Short commands for better readability in build output
APP_SHORT_COMMANDS := true

# Allow undefined symbols (will be resolved at runtime)
APP_ALLOW_MISSING_DEPS := false
```

## Library Build Order

Build libraries in dependency order:
1. **zix** (no dependencies)
2. **serd** (depends on zix)
3. **sord** (depends on serd, zix)
4. **sratom** (depends on sord, serd, zix)
5. **lilv** (depends on all above)

## 1. ZIX Library

Create `jni/zix/Android.mk`:

```makefile
LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := zix
LOCAL_MODULE_FILENAME := libzix

# Source files
LOCAL_SRC_FILES := \
    ../../libs/core/zix/src/allocator.c \
    ../../libs/core/zix/src/btree.c \
    ../../libs/core/zix/src/bump_allocator.c \
    ../../libs/core/zix/src/digest.c \
    ../../libs/core/zix/src/environment.c \
    ../../libs/core/zix/src/filesystem.c \
    ../../libs/core/zix/src/hash.c \
    ../../libs/core/zix/src/path.c \
    ../../libs/core/zix/src/ring.c \
    ../../libs/core/zix/src/sem.c \
    ../../libs/core/zix/src/status.c \
    ../../libs/core/zix/src/string_util.c \
    ../../libs/core/zix/src/thread.c \
    ../../libs/core/zix/src/tree.c

# Include directories
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/zix/include \
    $(LOCAL_PATH)/../../libs/core/zix/src

# Compiler flags
LOCAL_CFLAGS := \
    -DZIX_INTERNAL \
    -DHAVE_POSIX_MEMALIGN \
    -DHAVE_MLOCK \
    -DHAVE_FILENO \
    -DHAVE_CLOCK_GETTIME \
    -Wall -Wextra -Wno-unused-parameter

# Export includes for dependent modules
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/zix/include

# Link libraries
LOCAL_LDLIBS := -llog -lm -lpthread

include $(BUILD_SHARED_LIBRARY)

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE := zix_static
LOCAL_MODULE_FILENAME := libzix

LOCAL_SRC_FILES := \
    ../../libs/core/zix/src/allocator.c \
    ../../libs/core/zix/src/btree.c \
    ../../libs/core/zix/src/bump_allocator.c \
    ../../libs/core/zix/src/digest.c \
    ../../libs/core/zix/src/environment.c \
    ../../libs/core/zix/src/filesystem.c \
    ../../libs/core/zix/src/hash.c \
    ../../libs/core/zix/src/path.c \
    ../../libs/core/zix/src/ring.c \
    ../../libs/core/zix/src/sem.c \
    ../../libs/core/zix/src/status.c \
    ../../libs/core/zix/src/string_util.c \
    ../../libs/core/zix/src/thread.c \
    ../../libs/core/zix/src/tree.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/zix/include \
    $(LOCAL_PATH)/../../libs/core/zix/src

LOCAL_CFLAGS := \
    -DZIX_INTERNAL \
    -DHAVE_POSIX_MEMALIGN \
    -DHAVE_MLOCK \
    -DHAVE_FILENO \
    -DHAVE_CLOCK_GETTIME \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/zix/include

include $(BUILD_STATIC_LIBRARY)
```

## 2. SERD Library

Create `jni/serd/Android.mk`:

```makefile
LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := serd
LOCAL_MODULE_FILENAME := libserd

# Source files
LOCAL_SRC_FILES := \
    ../../libs/core/serd/src/attributes.c \
    ../../libs/core/serd/src/base64.c \
    ../../libs/core/serd/src/byte_source.c \
    ../../libs/core/serd/src/env.c \
    ../../libs/core/serd/src/n3.c \
    ../../libs/core/serd/src/node.c \
    ../../libs/core/serd/src/reader.c \
    ../../libs/core/serd/src/string.c \
    ../../libs/core/serd/src/system.c \
    ../../libs/core/serd/src/uri.c \
    ../../libs/core/serd/src/writer.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/serd/include \
    $(LOCAL_PATH)/../../libs/core/serd/src

LOCAL_CFLAGS := \
    -DSERD_INTERNAL \
    -DHAVE_FILENO \
    -DHAVE_POSIX_FADVISE \
    -DHAVE_POSIX_MEMALIGN \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/serd/include

LOCAL_LDLIBS := -llog -lm

include $(BUILD_SHARED_LIBRARY)

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE := serd_static
LOCAL_MODULE_FILENAME := libserd

LOCAL_SRC_FILES := \
    ../../libs/core/serd/src/attributes.c \
    ../../libs/core/serd/src/base64.c \
    ../../libs/core/serd/src/byte_source.c \
    ../../libs/core/serd/src/env.c \
    ../../libs/core/serd/src/n3.c \
    ../../libs/core/serd/src/node.c \
    ../../libs/core/serd/src/reader.c \
    ../../libs/core/serd/src/string.c \
    ../../libs/core/serd/src/system.c \
    ../../libs/core/serd/src/uri.c \
    ../../libs/core/serd/src/writer.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/serd/include \
    $(LOCAL_PATH)/../../libs/core/serd/src

LOCAL_CFLAGS := \
    -DSERD_INTERNAL \
    -DHAVE_FILENO \
    -DHAVE_POSIX_FADVISE \
    -DHAVE_POSIX_MEMALIGN \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/serd/include

include $(BUILD_STATIC_LIBRARY)
```

## 3. SORD Library

Create `jni/sord/Android.mk`:

```makefile
LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := sord
LOCAL_MODULE_FILENAME := libsord

LOCAL_SRC_FILES := \
    ../../libs/core/sord/src/sord.c \
    ../../libs/core/sord/src/syntax.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/sord/include \
    $(LOCAL_PATH)/../../libs/core/sord/src

LOCAL_CFLAGS := \
    -DSORD_INTERNAL \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/sord/include

# Dependencies
LOCAL_SHARED_LIBRARIES := serd zix

LOCAL_LDLIBS := -llog -lm

include $(BUILD_SHARED_LIBRARY)

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE := sord_static
LOCAL_MODULE_FILENAME := libsord

LOCAL_SRC_FILES := \
    ../../libs/core/sord/src/sord.c \
    ../../libs/core/sord/src/syntax.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/sord/include \
    $(LOCAL_PATH)/../../libs/core/sord/src

LOCAL_CFLAGS := \
    -DSORD_INTERNAL \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/sord/include

LOCAL_STATIC_LIBRARIES := serd_static zix_static

include $(BUILD_STATIC_LIBRARY)
```

## 4. SRATOM Library

Create `jni/sratom/Android.mk`:

```makefile
LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := sratom
LOCAL_MODULE_FILENAME := libsratom

LOCAL_SRC_FILES := \
    ../../libs/core/sratom/src/sratom.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/sratom/include \
    $(LOCAL_PATH)/../../libs/core/sratom/src

LOCAL_CFLAGS := \
    -DSRATOM_INTERNAL \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/sratom/include

LOCAL_SHARED_LIBRARIES := sord serd zix

LOCAL_LDLIBS := -llog -lm

include $(BUILD_SHARED_LIBRARY)

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE := sratom_static
LOCAL_MODULE_FILENAME := libsratom

LOCAL_SRC_FILES := \
    ../../libs/core/sratom/src/sratom.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/sratom/include \
    $(LOCAL_PATH)/../../libs/core/sratom/src

LOCAL_CFLAGS := \
    -DSRATOM_INTERNAL \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/sratom/include

LOCAL_STATIC_LIBRARIES := sord_static serd_static zix_static

include $(BUILD_STATIC_LIBRARY)
```

## 5. LILV Library

Create `jni/lilv/Android.mk`:

```makefile
LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := lilv
LOCAL_MODULE_FILENAME := liblilv

LOCAL_SRC_FILES := \
    ../../libs/core/lilv/src/collections.c \
    ../../libs/core/lilv/src/instance.c \
    ../../libs/core/lilv/src/lib.c \
    ../../libs/core/lilv/src/node.c \
    ../../libs/core/lilv/src/plugin.c \
    ../../libs/core/lilv/src/pluginclass.c \
    ../../libs/core/lilv/src/port.c \
    ../../libs/core/lilv/src/query.c \
    ../../libs/core/lilv/src/scalepoint.c \
    ../../libs/core/lilv/src/state.c \
    ../../libs/core/lilv/src/ui.c \
    ../../libs/core/lilv/src/util.c \
    ../../libs/core/lilv/src/world.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/lilv/include \
    $(LOCAL_PATH)/../../libs/core/lilv/src

LOCAL_CFLAGS := \
    -DLILV_INTERNAL \
    -DLILV_NO_DEFAULT_CONFIG \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/lilv/include

LOCAL_SHARED_LIBRARIES := sratom sord serd zix

LOCAL_LDLIBS := -llog -lm -ldl

include $(BUILD_SHARED_LIBRARY)

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE := lilv_static
LOCAL_MODULE_FILENAME := liblilv

LOCAL_SRC_FILES := \
    ../../libs/core/lilv/src/collections.c \
    ../../libs/core/lilv/src/instance.c \
    ../../libs/core/lilv/src/lib.c \
    ../../libs/core/lilv/src/node.c \
    ../../libs/core/lilv/src/plugin.c \
    ../../libs/core/lilv/src/pluginclass.c \
    ../../libs/core/lilv/src/port.c \
    ../../libs/core/lilv/src/query.c \
    ../../libs/core/lilv/src/scalepoint.c \
    ../../libs/core/lilv/src/state.c \
    ../../libs/core/lilv/src/ui.c \
    ../../libs/core/lilv/src/util.c \
    ../../libs/core/lilv/src/world.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/lilv/include \
    $(LOCAL_PATH)/../../libs/core/lilv/src

LOCAL_CFLAGS := \
    -DLILV_INTERNAL \
    -DLILV_NO_DEFAULT_CONFIG \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/lilv/include

LOCAL_STATIC_LIBRARIES := sratom_static sord_static serd_static zix_static

include $(BUILD_STATIC_LIBRARY)
```

## 6. Top-Level Android.mk

Create `jni/Android.mk` to include all modules:

```makefile
# Top-level Android.mk - Includes all library modules

LOCAL_PATH := $(call my-dir)

# Include all library makefiles in dependency order
include $(LOCAL_PATH)/zix/Android.mk
include $(LOCAL_PATH)/serd/Android.mk
include $(LOCAL_PATH)/sord/Android.mk
include $(LOCAL_PATH)/sratom/Android.mk
include $(LOCAL_PATH)/lilv/Android.mk
```

## Building the Libraries

### Build All Libraries (All ABIs)

```bash
cd /path/to/opiqo-build
ndk-build
```

### Build Specific ABI

```bash
ndk-build APP_ABI=arm64-v8a
```

### Build Debug Version

```bash
ndk-build APP_OPTIM=debug
```

### Clean Build

```bash
ndk-build clean
```

### Verbose Build Output

```bash
ndk-build V=1
```

### Parallel Build

```bash
ndk-build -j8  # Use 8 parallel jobs
```

## Build Output Locations

After successful build:

### Shared Libraries (.so)
```
libs/armeabi-v7a/libzix.so
libs/armeabi-v7a/libserd.so
libs/armeabi-v7a/libsord.so
libs/armeabi-v7a/libsratom.so
libs/armeabi-v7a/liblilv.so

libs/arm64-v8a/libzix.so
libs/arm64-v8a/libserd.so
libs/arm64-v8a/libsord.so
libs/arm64-v8a/libsratom.so
libs/arm64-v8a/liblilv.so
```

### Static Libraries (.a)
```
obj/local/armeabi-v7a/libzix.a
obj/local/armeabi-v7a/libserd.a
obj/local/armeabi-v7a/libsord.a
obj/local/armeabi-v7a/libsratom.a
obj/local/armeabi-v7a/liblilv.a

obj/local/arm64-v8a/libzix.a
obj/local/arm64-v8a/libserd.a
obj/local/arm64-v8a/libsord.a
obj/local/arm64-v8a/libsratom.a
obj/local/arm64-v8a/liblilv.a
```

## Customization Options

### Adjust Source Files

If source file lists in the above examples don't match your actual source tree, use `find` to generate the list:

```bash
cd libs/core/zix/src
find . -name "*.c" | sed 's|^\./|    ../../libs/core/zix/src/|' | sed 's|$| \\|'
```

### Add Compiler Definitions

Add to `LOCAL_CFLAGS` in each Android.mk:

```makefile
LOCAL_CFLAGS += -DCUSTOM_DEFINE=1
```

### Link Additional Libraries

Add to `LOCAL_LDLIBS`:

```makefile
LOCAL_LDLIBS += -lz -lc
```

## Troubleshooting

### Undefined References

If you get undefined reference errors, ensure:
1. Libraries are built in correct dependency order
2. `LOCAL_SHARED_LIBRARIES` or `LOCAL_STATIC_LIBRARIES` are correctly specified
3. Source file lists are complete

### Include Path Issues

If headers can't be found:
1. Verify `LOCAL_C_INCLUDES` paths are correct relative to `LOCAL_PATH`
2. Check that `LOCAL_EXPORT_C_INCLUDES` is set for libraries used by others
3. Use absolute paths if needed: `$(LOCAL_PATH)/../../libs/core/zix/include`

### ABI-Specific Issues

To build only working ABIs:
```makefile
# In Application.mk
APP_ABI := arm64-v8a  # Start with one ABI
```

## Integration with Android Studio

To use these libraries in an Android Studio project:

1. Copy `libs/` folder to `app/src/main/jniLibs/`
2. Load libraries in Java:
```java
static {
    System.loadLibrary("zix");
    System.loadLibrary("serd");
    System.loadLibrary("sord");
    System.loadLibrary("sratom");
    System.loadLibrary("lilv");
}
```

3. Or use in native code by adding to your own Android.mk:
```makefile
LOCAL_SHARED_LIBRARIES := zix serd sord sratom lilv
```

## References

- [Android NDK Build System](https://developer.android.com/ndk/guides/build)
- [Android.mk Syntax](https://developer.android.com/ndk/guides/android_mk)
- [Application.mk Syntax](https://developer.android.com/ndk/guides/application_mk)
