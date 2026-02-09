LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := serd
LOCAL_MODULE_FILENAME := libserd

# Source files
LOCAL_SRC_FILES := \
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
LOCAL_UNINSTALLABLE_MODULE := false
LOCAL_MODULE_PATH := $(NDK_PROJECT_PATH)/static/$(TARGET_ARCH_ABI)

LOCAL_SRC_FILES := \
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
