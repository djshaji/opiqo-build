LOCAL_PATH := $(call my-dir)

# Build shared library
include $(CLEAR_VARS)

LOCAL_MODULE := lilv
LOCAL_MODULE_FILENAME := liblilv

LOCAL_SRC_FILES := \
    ../../libs/core/lilv/src/collections.c \
    ../../libs/core/lilv/src/dylib.c \
    ../../libs/core/lilv/src/instance.c \
    ../../libs/core/lilv/src/lib.c \
    ../../libs/core/lilv/src/load_skimmer.c \
    ../../libs/core/lilv/src/node.c \
    ../../libs/core/lilv/src/node_hash.c \
    ../../libs/core/lilv/src/node_skimmer.c \
    ../../libs/core/lilv/src/plugin.c \
    ../../libs/core/lilv/src/pluginclass.c \
    ../../libs/core/lilv/src/port.c \
    ../../libs/core/lilv/src/query.c \
    ../../libs/core/lilv/src/scalepoint.c \
    ../../libs/core/lilv/src/state.c \
    ../../libs/core/lilv/src/string_util.c \
    ../../libs/core/lilv/src/syntax_skimmer.c \
    ../../libs/core/lilv/src/sys_util.c \
    ../../libs/core/lilv/src/type_skimmer.c \
    ../../libs/core/lilv/src/ui.c \
    ../../libs/core/lilv/src/uris.c \
    ../../libs/core/lilv/src/world.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/lilv/include \
    $(LOCAL_PATH)/../../libs/core/lilv/src \
    $(LOCAL_PATH)/../../libs/core/lv2/include

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
LOCAL_UNINSTALLABLE_MODULE := false
LOCAL_MODULE_PATH := $(NDK_PROJECT_PATH)/static/$(TARGET_ARCH_ABI)

LOCAL_SRC_FILES := \
    ../../libs/core/lilv/src/collections.c \
    ../../libs/core/lilv/src/dylib.c \
    ../../libs/core/lilv/src/instance.c \
    ../../libs/core/lilv/src/lib.c \
    ../../libs/core/lilv/src/load_skimmer.c \
    ../../libs/core/lilv/src/node.c \
    ../../libs/core/lilv/src/node_hash.c \
    ../../libs/core/lilv/src/node_skimmer.c \
    ../../libs/core/lilv/src/plugin.c \
    ../../libs/core/lilv/src/pluginclass.c \
    ../../libs/core/lilv/src/port.c \
    ../../libs/core/lilv/src/query.c \
    ../../libs/core/lilv/src/scalepoint.c \
    ../../libs/core/lilv/src/state.c \
    ../../libs/core/lilv/src/string_util.c \
    ../../libs/core/lilv/src/syntax_skimmer.c \
    ../../libs/core/lilv/src/sys_util.c \
    ../../libs/core/lilv/src/type_skimmer.c \
    ../../libs/core/lilv/src/ui.c \
    ../../libs/core/lilv/src/uris.c \
    ../../libs/core/lilv/src/world.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../../libs/core/lilv/include \
    $(LOCAL_PATH)/../../libs/core/lilv/src \
    $(LOCAL_PATH)/../../libs/core/lv2/include

LOCAL_CFLAGS := \
    -DLILV_INTERNAL \
    -DLILV_NO_DEFAULT_CONFIG \
    -Wall -Wextra -Wno-unused-parameter

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../libs/core/lilv/include

LOCAL_STATIC_LIBRARIES := sratom_static sord_static serd_static zix_static

include $(BUILD_STATIC_LIBRARY)
