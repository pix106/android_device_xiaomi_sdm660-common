#
# Copyright (C) 2020-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter tulip jasmine_sprout wayne clover lavender platina jason whyred,$(TARGET_DEVICE)),)

LPFLASH := $(HOST_OUT_EXECUTABLES)/lpflash$(HOST_EXECUTABLE_SUFFIX)
INSTALLED_SUPERIMAGE_DUMMY_TARGET := $(PRODUCT_OUT)/super_dummy.img

$(INSTALLED_SUPERIMAGE_DUMMY_TARGET): $(PRODUCT_OUT)/super_empty.img $(LPFLASH)
	$(call pretty,"Target dummy super image: $@")
	$(hide) touch $@
	$(hide) echo $(CURDIR)
	$(hide) $(LPFLASH) $(CURDIR)/$@ $(CURDIR)/$(PRODUCT_OUT)/super_empty.img

.PHONY: super_dummyimage
super_dummyimage: $(INSTALLED_SUPERIMAGE_DUMMY_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_SUPERIMAGE_DUMMY_TARGET)

include $(CLEAR_VARS)

subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
$(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))
endif
