
VERILOG_DV_COMMONDIR := $(dir $(lastword $(MAKEFILE_LIST)))
FWUART_16550_DIR := $(abspath $(VERILOG_DV_COMMONDIR)/../../..)
PACKAGES_DIR := $(FWUART_16550_DIR)/packages

DV_MK := $(shell PATH=$(PACKAGES_DIR)/python/bin:$(PATH) python -m mkdv mkfile)

ifneq (1,$(RULES))

include $(FWUART_16550_DIR)/verilog/rtl/defs_rules.mk

MKDV_PYTHONPATH += $(VERILOG_DV_COMMONDIR)/python

include $(DV_MK)
else # Rules
include $(DV_MK)

include $(FWUART_16550_DIR)/verilog/rtl/defs_rules.mk

endif