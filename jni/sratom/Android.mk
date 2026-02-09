LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := sratom
LOCAL_MODULE_FILENAME := libsratom

LOCAL_SRC_FILES := \
    ../../libs/core/sratom/src/sratom.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/sratom/include \
    $(LOCAL_PATH)/../../libs/core/sratom/src \
    $(LOCAL_PATH)/../../libs/core/lv2/include

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
LOCAL_UNINSTALLABLE_MODULE := false
LOCAL_MODULE_PATH := $(NDK_PROJECT_PATH)/static/$(TARGET_ARCH_ABI)

LOCAL_SRC_FILES := \
    ../../libs/core/sratom/src/sratom.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/sratom/include \
    $(LOCAL_PATH)/../../libs/core/sratom/src \
    $(LOCAL_PATH)/../../libs/core/lv2/include

LOCAL_CFLAGS := \
    -DSRATOM_INTERNAL \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/sratom/include

LOCAL_STATIC_LIBRARIES := sord_static serd_static zix_static

include $(BUILD_STATIC_LIBRARY)
