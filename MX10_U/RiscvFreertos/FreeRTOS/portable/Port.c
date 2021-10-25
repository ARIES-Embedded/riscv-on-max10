/*
 * FreeRTOS Kernel V10.4.5
 * Copyright (C) 2021 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * SPDX-License-Identifier: MIT
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * https://www.FreeRTOS.org
 * https://github.com/FreeRTOS
 *
 */


// -- includes -- //

#include "FreeRTOS/include/FreeRTOS.h"
#include "FreeRTOS/include/task.h"
#include "FreeRTOS/portable/portmacro.h"
#include "FreeRTOS/portable/Hal.h"
#include "FpgaConfig.h"

// -- global variables & function declarations -- //

static uint32_t l_CriticalNesting = 0xaaaaaaaa;
static uint32_t l_SchedulerStarted = 0;
void prvTaskExitError(void);

// -- function definitions -- //

void prvTaskExitError(void) {

	/*
	A function that implements a task must not exit or attempt to return to
	its caller as there is nothing to return to.  If a task wants to exit it
	should instead call vTaskDelete( NULL ).
	*/

	portDISABLE_INTERRUPTS();
	while (1) {
		// TODO: Add error handling code.
	}
}

void vPortYield(void) {
	Hal_RaiseSoftInterrupt();
}

void vPortEnterCritical(void) {
	portDISABLE_INTERRUPTS();
	l_CriticalNesting++;
}

void vPortExitCritical(void) {
	l_CriticalNesting--;
	if (l_CriticalNesting == 0) {
		portENABLE_INTERRUPTS();
	}
}

StackType_t *pxPortInitialiseStack(StackType_t* pxTopOfStack, TaskFunction_t pxCode, void* pvParameters) {
	// Simulate stack frame as if created by interrupt. Compare to Crt.S
	pxTopOfStack -= 29; // move by 29 * 4 Bytes (size of StackType_t)
	pxTopOfStack[0] = (StackType_t) prvTaskExitError; // x1, ra - return address
	pxTopOfStack[6] = (StackType_t) pvParameters; // x10, a0 - first parameter
	pxTopOfStack[28] = (StackType_t) pxCode; // mepc - return adress after interrupt
	return pxTopOfStack;
}

BaseType_t xPortStartScheduler(void) {
	l_SchedulerStarted = 1;
	l_CriticalNesting = 0;
	Hal_EnableMachineInterrupt(IRQ_M_EXT);
	Hal_EnableMachineInterrupt(IRQ_M_SOFT);
	Hal_TimerStart(configCPU_CLOCK_HZ / configTICK_RATE_HZ);
	Hal_GlobalEnableInterrupts();
	Hal_RaiseSoftInterrupt();
	// Scheduler should never return to this line
	return pdFALSE;
}

void vPortEndScheduler(void) {/* Do not implement. */}

// Important:
// The pxCurrentTCB variable as well as its type is hidden in tasks.c
// However the port needs to access it for task scheduling
// 2 function to access the variable were added to tasks.c and task.h

uintptr_t SystemInterruptHandler(uintptr_t stack, bool softInterrupt) {

	// The first time the scheduler has started no TaskControlBlock has to be saved.
	if (l_SchedulerStarted == 1){
		l_SchedulerStarted = 2;
	} else {
		StoreStackPointerInCurrentTCB(stack);
	}

	if (softInterrupt) {
		vTaskSwitchContext();
	} else {
		if (xTaskIncrementTick() != pdFALSE) {
			vTaskSwitchContext();
		}
		Hal_TimerStart(configCPU_CLOCK_HZ / configTICK_RATE_HZ);
	}

	return LoadStackPointerFromCurrentTCB();

}
