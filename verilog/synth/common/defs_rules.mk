
FWUART_16550_VERILOG_SYNTH_COMMONDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
FWUART_16550_DIR := $(abspath $(FWUART_16550_VERILOG_SYNTH_COMMONDIR)/../../..)
PACKAGES_DIR := $(FWUART_16550_DIR)/packages
DV_MK := $(shell PATH=$(PACKAGES_DIR)/python/bin:$(PATH) python3 -m mkdv mkfile)

ifneq (1,$(RULES))

include $(FWUART_16550_DIR)/verilog/rtl/defs_rules.mk
# Must be included last
include $(DV_MK)
else # Rules

# Must be included first
include $(DV_MK)
include $(FWUART_16550_DIR)/verilog/rtl/defs_rules.mk
endif
