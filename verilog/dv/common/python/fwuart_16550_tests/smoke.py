'''
Created on Apr 14, 2021

@author: mballance
'''

import cocotb
import pybfms
from wishbone_bfms.wb_initiator_bfm import WbInitiatorBfm
from uart_bfms.uart_bfm import UartBfm

@cocotb.test()
async def entry(dut):
    await pybfms.init()
    print("Hello")
    
    regbfm : WbInitiatorBfm = pybfms.find_bfm(".*regbfm")
    uartbfm : UartBfm = pybfms.find_bfm(".*uart_bfm")
    
    uartbfm.recv_cb = lambda data : print("Received data: " + hex(data))
    
    lcr = await regbfm.read(3 << 2)
    lcr |= 0x80
    await regbfm.write(3 << 2, lcr, 0xF)

    # Configure UART divisor
    await regbfm.write(0 << 2, 1, 0xF)
    await regbfm.write(1 << 2, 0, 0xF)
    
    uartbfm.set_divisor(1)
    
    # Back to regular mode
    lcr &= 0x7F
    await regbfm.write(3 << 2, lcr, 0xF)
    
    await regbfm.write(0 << 2, 0x5a, 0xF)
    await regbfm.write(0 << 2, 0xa5, 0xF)

    for i in range(4):    
        await uartbfm.xmit(20+i)
    