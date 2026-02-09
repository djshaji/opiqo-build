# Top-level Android.mk - Includes all library modules

ROOT_PATH := $(call my-dir)

# Include all library makefiles in dependency order
include $(ROOT_PATH)/zix/Android.mk
include $(ROOT_PATH)/serd/Android.mk
include $(ROOT_PATH)/sord/Android.mk
include $(ROOT_PATH)/sratom/Android.mk
include $(ROOT_PATH)/lilv/Android.mk
