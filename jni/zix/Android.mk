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
    ../../libs/core/zix/src/errno_status.c \
    ../../libs/core/zix/src/filesystem.c \
    ../../libs/core/zix/src/hash.c \
    ../../libs/core/zix/src/path.c \
    ../../libs/core/zix/src/ring.c \
    ../../libs/core/zix/src/status.c \
    ../../libs/core/zix/src/string_view.c \
    ../../libs/core/zix/src/system.c \
    ../../libs/core/zix/src/tree.c \
    ../../libs/core/zix/src/posix/environment_posix.c \
    ../../libs/core/zix/src/posix/filesystem_posix.c \
    ../../libs/core/zix/src/posix/system_posix.c \
    ../../libs/core/zix/src/posix/sem_posix.c \
    ../../libs/core/zix/src/posix/thread_posix.c

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
LOCAL_LDLIBS := -llog -lm

include $(BUILD_SHARED_LIBRARY)

# Build static library
include $(CLEAR_VARS)

LOCAL_MODULE := zix_static
LOCAL_MODULE_FILENAME := libzix
LOCAL_UNINSTALLABLE_MODULE := false
LOCAL_MODULE_PATH := $(NDK_PROJECT_PATH)/static/$(TARGET_ARCH_ABI)

LOCAL_SRC_FILES := \
    ../../libs/core/zix/src/allocator.c \
    ../../libs/core/zix/src/btree.c \
    ../../libs/core/zix/src/bump_allocator.c \
    ../../libs/core/zix/src/digest.c \
    ../../libs/core/zix/src/errno_status.c \
    ../../libs/core/zix/src/filesystem.c \
    ../../libs/core/zix/src/hash.c \
    ../../libs/core/zix/src/path.c \
    ../../libs/core/zix/src/ring.c \
    ../../libs/core/zix/src/status.c \
    ../../libs/core/zix/src/string_view.c \
    ../../libs/core/zix/src/system.c \
    ../../libs/core/zix/src/tree.c \
    ../../libs/core/zix/src/posix/environment_posix.c \
    ../../libs/core/zix/src/posix/filesystem_posix.c \
    ../../libs/core/zix/src/posix/system_posix.c \
    ../../libs/core/zix/src/posix/sem_posix.c \
    ../../libs/core/zix/src/posix/thread_posix.c

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
