.text

.global Hal_GlobalEnableInterrupts
.global Hal_GlobalDisableInterrupts

Hal_GlobalEnableInterrupts:
	# Only timer interrupt (MIE bit 7) is supported on SERV
	# M-level featured replacement is the ServInterruptController
	li t0, 0x80
	csrw mie, t0
	csrs mstatus, 8
	ret

Hal_GlobalDisableInterrupts:
	csrc mstatus, 8
	ret
