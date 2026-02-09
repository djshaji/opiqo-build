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
LOCAL_UNINSTALLABLE_MODULE := false
LOCAL_MODULE_PATH := $(NDK_PROJECT_PATH)/static/$(TARGET_ARCH_ABI)

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
