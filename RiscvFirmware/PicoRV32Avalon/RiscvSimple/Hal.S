#include "CustomOps.S"

.text

	.global Hal_EnableInterrupts
	.global Hal_DisableInterrupts
	.global Hal_TimerStart
	.global Hal_TimerRead
	.global Hal_TimerStop
	.global Hal_ReadTime32
	.global Hal_ReadTime64

	# maskirq is 0 enable - 1 disable, argument of these functions the other way round (1 enabled ...)
	Hal_EnableInterrupts:
		not t0, zero
		picorv32_maskirq_insn(t0, t0) # Load interrupts from register (also sets them to 1 / disabled)
		not a0, a0
		and t0, t0, a0
		picorv32_maskirq_insn(zero, t0) # Write back new value
		ret

	# same as above, a '1' in the argument means to disable the interrupt
	Hal_DisableInterrupts:
		not t0, zero
		picorv32_maskirq_insn(t0, t0) # Load interrupts from register (also sets them to 1 / disabled)
		or t0, t0, a0
		picorv32_maskirq_insn(zero, t0) # Write back new value
		ret

	Hal_TimerStart:
		picorv32_timer_insn(zero, a0)
		ret

	Hal_TimerRead:
		picorv32_timer_insn(a0, zero);
		picorv32_timer_insn(zero, a0);
		ret

	Hal_TimerStop:
		picorv32_timer_insn(zero, zero)
		ret

	Hal_ReadTime32:
		rdtime a0
		ret

	Hal_ReadTime64:
		rdtimeh a1
		rdtime a0
		rdtimeh t0
		bne a1, t0, Hal_ReadTime64
		ret
