MKDV_MK:=$(abspath $(lastword $(MAKEFILE_LIST)))
TEST_DIR := $(dir $(MKDV_MK))

MKDV_TOOL ?= icarus

MKDV_PLUGINS += cocotb pybfms
PYBFMS_MODULES += wishbone_bfms uart_bfms

MKDV_VL_SRCS += $(TEST_DIR)/fwuart_16550_tb.sv
TOP_MODULE = fwuart_16550_tb

MKDV_COCOTB_MODULE ?= fwuart_16550_tests.smoke

include $(TEST_DIR)/../common/defs_rules.mk

RULES := 1


include $(TEST_DIR)/../common/defs_rules.mk

check:
	echo "PYTHONPATH=$(PYTHONPATH)"
