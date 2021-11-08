
# PicoRV32Avalon

## Interrupts

Interrupt handling on PicoRV32 is non standard, yet simple.
When an interrupt signal is active and the corresponding bit in the enable register *maskirq* is set, then the core is interrupted.
The HAL provides functions to enable/disable interrupts in the *maskirq* register, to set interrupt handler callbacks and to start the timer (based on clock cycles).

Interrupts 0-2 are reserved for the core. Connecting an interrupt for these bits may have side effects.

| IRQ    | Description         |
|--------|---------------------|
| 0      | Timer               |
| 1      | Illegal Instruction |
| 2      | Unaligned Access    |
| 3 - 31 | User Defined        |

# ServAvalon

## Interrupts

Interrupts are managed by a custom interrupt controller and combined to the single interrupt input signal of Serv, which was previously used for a timer.
Interrupts are enabled globally by setting the *mie*-bit in the *mstatus*-csr and the *mtie*-bit in the *mie*-csr.

The core then is interrupted if a bit in both registers *menable* and *mpending* is set. The *IRQ_M_SOFT* bit of *mpending* is set if the register *softinterrupt* holds a value equal to nonzero. The *IRQ_M_TIMER* bit is asserted, if the value of *mtime* is greater than or equal to *mtimecmp*. The *IRQ_M_EXT* bit is set, if an external interrupt is asserted and the corresponding bit is set in *ext_enable*. 

On interrupt the HAL will query the interrupt controller for the status and call the corresponding IRQ handlers. Serv does not have a rdtime register built in, instead the mtime register of the interrupt controller can be used. The HAL will also provide the neccessary functions for setting up the interrupts.

The interrupt controller for the demo files is located at address **0x00010000**.

### ServInterruptController Register Map
| Offset | Symbol | Description | RW |
|---|---|---|---|
| 0x00 | w_menable_set | A bit set to '1' enables the corresponding machine interrupt. Available are IRQ_M_SOFT (0x8), IRQ_M_TIMER (0x80) and IRQ_M_EXT (0x800). Bits written '0' are ignored. | W |
|  | r_menable | A bit set to '1' indicates that the machine interrupt is enabled. | R |
| 0x04 | w_menable_clr | A bit set to '1' disables the corresponding machine interrupt. Available are IRQ_M_SOFT, IRQ_M_TIMER and IRQ_M_EXT. Bits written '0' are ignored. | W |
|  | r_mpending | The core is interrupted when a machine interrupt is asserted and the r_menable bit is '1'. The corresponding r_mpending bit then is set to '1'. | R |
| 0x08 | ext_enable | A bit set to '1' enables the external interrupt. | RW |
| 0x0C | ext_pending | A bit set to '1' indicates that the external interrupt is asserted. If a bit in both ext_enable and ext_pending is '1', then the IRQ_M_EXT bit in r_mpending is asserted. | R |
| 0x10 | mtime | Lower 32 bits of the machine timer. When mtime is read, the actual value of mtimeh is loaded into its latch. The timer is initialized to 0 on reset or boot-up and incremented by 1 every clock cycle. | R |
| 0x14 | mtimeh | Latched upper 32 to 1 bits of the machine timer. mtimeh cannot be read directly, instead reading returns the latched value from when mtime was read. This makes it possible to read a snapshot of the entire 64 to 33 bit timer without alteration. | R |
| 0x18 | mtimecmp | Lower 32 bits of the timer compare-value. When mtimecmp is written to, the latched value of mtimecmph is written to the upper bits of the actual register. When the value of the entire mtime register is greater than or equal to the entire mtimecmp register, then the IRQ_M_SOFT bit is asserted in r_mpending. | RW |
| 0x1C | mtimecmph | Latched upper 32 to 1 bits of the machine timer. The actual register is not available for direct access. To write the upper bits of the timer, first write the upper bits to the latched mtimecmph and then write the lower 32 bits to mtimecmp. Reading mtimecmph returns the current latched value. | RW |
| 0x20 | softinterrupt | The IRQ_M_SOFT bit is asserted in r_mpending if the value of softinterrupt is nonzero. | RW |

# VexRiscvAvalon

## Interrupts

Interrupts are managed by a custom interrupt controller and forwarded to VexRiscv via three interrupt signals.
Interrupts are enabled globally by setting the *mie*-bit in the *mstatus*-csr.

The core then is interrupted if a bit in the csr *mie* is set and the corresponding interrupt signal from the controller is asserted. The *IRQ_M_SOFT* signal is active if the register *softinterrupt* holds a value equal to nonzero. The *IRQ_M_TIMER* signal is asserted, if the value of *mtime* is greater than or equal to *mtimecmp*. The *IRQ_M_EXT* signal is active, if an external interrupt is asserted to the controller and the corresponding bit is set in the *enabled* register. 

On external interrupt the HAL will query the interrupt controller for the status and call the corresponding IRQ handlers. The HAL will also provide the neccessary functions for setting up the interrupts.

The interrupt controller for the demo files is located at address **0x00010000**.

### VexInterruptController Register Map
| Offset | Symbol | Description | RW |
|---|---|---|---|
| 0x00 | pending | A bit is set to '1' if the correspoding IRQ is asserted. | R |
| 0x04 | enabled | An interrupt is enabled if the corresponding bit is '1'. The IRQ_M_EXT signal is asserted to the core if a bit in both pending and enabled is '1'. | RW |
| 0x08 | mtime | Lower 32 bits of machine timer. Reading this register sets mtimeh_latch to the current value of mtimeh. | RW |
| 0x0C | mtimeh | Upper 32 bits of machine timer. | RW |
| 0x10 | mtimeh_latch | Latched value of mtimeh whenever mtime is read. Utilized so the 32 bit core can read an unaltered snapshot of the entire 64 bit timer. | R |
| 0x14 | mtimecmp | Lower 32 bits of the compare-value for timer interrupts. The IRQ_M_TIMER signal is asserted to the core if the entire 64 bit value of mtime is greater than or equal to the 64 bit value of mtimecmp. | RW |
| 0x18 | mtimecmph | Upper 32 bits of the compare-value for timer interrupts. | RW |
| 0x1C | mtimecmp_latch | Latch trigger for mtimecmp, a write to this register writes the data to mtimecmp and copies the data from mtimecmph_latch to mtimecmph. This is utilized to write the entire 64 bit value in one cycle. | W |
| 0x20 | mtimecmph_latch | Latch for the upper 32 bit of mtimecmp. This register can be read and written normally and have no immediate effect. | RW |
| 0x24 | softinterrupt | The IRQ_M_SOFT signal is asserted to the core if the value of softinterrupt is nonzero. | RW |
