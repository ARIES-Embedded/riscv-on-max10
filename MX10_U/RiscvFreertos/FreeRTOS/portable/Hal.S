.text

.global Hal_EnableMachineInterrupt
.global Hal_DisableMachineInterrupt
.global Hal_GlobalEnableInterrupts
.global Hal_GlobalDisableInterrupts
.global Hal_ReadTime32
.global Hal_ReadTime64

Hal_EnableMachineInterrupt:
	li t0, 1
	sll a0, t0, a0
	csrs mie, a0
	ret

Hal_DisableMachineInterrupt:
	li t0, 1
	sll a0, t0, a0
	csrc mie, a0
	ret

Hal_GlobalEnableInterrupts:
	csrs mstatus, 8
	ret

Hal_GlobalDisableInterrupts:
	csrc mstatus, 8
	ret

Hal_ReadTime32:
	csrr a0, time
	ret

Hal_ReadTime64:
	csrr a1, timeh
	csrr a0, time
	csrr t0, timeh
	bne a1, t0, Hal_ReadTime64
	ret
