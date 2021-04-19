#
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

ifneq ($(filter mako occam,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)

include $(call first-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

#A/B builds require us to create the mount points at compile time.
#Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(PRODUCT_OUT)/firmware
PERSIST_MOUNT_POINT := $(PRODUCT_OUT)/persist

$(FIRMWARE_MOUNT_POINT):
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(FIRMWARE_MOUNT_POINT)

$(PERSIST_MOUNT_POINT):
	@echo "Creating $(PERSIST_MOUNT_POINT)"
	@mkdir -p $(PERSIST_MOUNT_POINT)

# halium doesn't support 32-bit builds by default, so the patches sometime point directly to /system/lib64
# Make lib64 -> lib symlink to cover this situation easily
LIB64_SYMLINK := $(PRODUCT_OUT)/system/lib64
$(LIB64_SYMLINK):
	@echo "lib64 to lib symlink: $@"
	@mkdir -p $(PRODUCT_OUT)/system/lib
	$(hide) ln -sf lib $(LIB64_SYMLINK)

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) \
								 $(PERSIST_MOUNT_POINT)  \
								 $(LIB64_SYMLINK)

endif
