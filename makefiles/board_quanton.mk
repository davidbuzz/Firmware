#
# Board-specific definitions for the PX4FMU
#

#
# Configure the toolchain
#
CONFIG_ARCH			 = CORTEXM4F
CONFIG_BOARD			 = Quanton

include $(PX4_MK_DIR)/toolchain_gnu-arm-eabi.mk