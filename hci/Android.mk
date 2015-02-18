LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CFLAGS += $(bdroid_CFLAGS)

LOCAL_SRC_FILES := \
	src/bt_hci_bdroid.c \
	src/btsnoop.c \
	src/btsnoop_net.c \
	src/lpm.c \
	src/utils.c \
	src/vendor.c

LOCAL_CFLAGS := -Wno-unused-parameter

ifeq ($(BLUETOOTH_HCI_USE_MCT),true)

LOCAL_CFLAGS += -DHCI_USE_MCT

ifeq ($(QCOM_BT_USE_SMD_TTY),true)

LOCAL_CFLAGS += -DQCOM_WCN_SSR

endif

LOCAL_SRC_FILES += \
	src/hci_mct.c \
	src/userial_mct.c

else

LOCAL_CFLAGS += -DHCI_H2

LOCAL_SRC_FILES += \
	src/hci_h4.c \
	src/usb.c

endif

LOCAL_CFLAGS += -std=c99

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/../osi/include \
	$(LOCAL_PATH)/../utils/include \
	external/libusb \
	$(bdroid_C_INCLUDES)

LOCAL_SHARED_LIBRARIES += \
	libcutils \
	liblog \
	libdl \
	libusb \
	libbt-utils

LOCAL_STATIC_LIBRARIES := libosi

LOCAL_MODULE := libbt-hci
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include $(BUILD_SHARED_LIBRARY)
