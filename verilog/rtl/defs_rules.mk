
FWUART_16550_RTLDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

ifneq (1,$(RULES))

ifeq (,$(findstring $(FWUART_16550_RTLDIR),$(MKDV_INCLUDED_DEFS)))
MKDV_INCLUDED_DEFS += $(FWUART_16550_RTLDIR)
MKDV_VL_INCDIRS += $(FWUART_16550_RTLDIR)
MKDV_VL_SRCS += $(wildcard $(FWUART_16550_RTLDIR)/*.v)
endif

else # Rules

endif
