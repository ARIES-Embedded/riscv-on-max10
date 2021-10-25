/* Copyright (C) 2021 ARIES Embedded GmbH

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE. */

#include "FreeRTOS/include/FreeRTOS.h"
#include "FreeRTOS/include/task.h"
#include "FreeRTOS/include/queue.h"
#include "FreeRTOS/include/timers.h"
#include "FreeRTOS/portable/Hal.h"

#include "FpgaConfig.h"

// FreeRTOS hook for when malloc fails, enable in FreeRTOSConfig.
void vApplicationMallocFailedHook(void);

// FreeRTOS hook for when FreeRtos is idling, enable in FreeRTOSConfig.
void vApplicationIdleHook(void);

// FreeRTOS hook for when a stack overflow occurs, enable in FreeRTOSConfig.
void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName);

// Tasks

void taskGPIOCounter(void* param);
void taskCounterMod(void* param);

// Interrupt Handlers

void IRQHandlerUart(void);

// Static Variables

static int counterMod = 1;

int main(void) {

	// Greetings
	UartWrite(g_Uart, "\n\n* * * VexRiscv FreeRTOS Demo  -  ");
	UartWrite(g_Uart, DBUILD_VERSION);
	UartWrite(g_Uart, "  - ");
	UartWrite(g_Uart, DBUILD_DATE);
	UartWrite(g_Uart, "  * * *\n");

	// Enable UART interrupt handling
	Hal_SetExtIrqHandler(IRQ_UART, IRQHandlerUart);
	Hal_EnableInterrupt(IRQ_UART);
	g_Uart->control |= UART_RRDY;

	// RTOS Tasks
	xTaskCreate(taskCounterMod, "CounterTimer", 100, 0, priorityHIGH, 0);
	xTaskCreate(taskGPIOCounter, "GPIOCounter", 100, 0, priorityMEDIUM, 0);

	/* Start the kernel.  From here on, only tasks and interrupts will run. */
	vTaskStartScheduler();

	/* Exit FreeRTOS */
	return 0;
}

// FreeRTOS hooks

void vApplicationMallocFailedHook(void) {
	/* vApplicationMallocFailedHook() will only be called if
	configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
	function that will get called if a call to pvPortMalloc() fails.
	pvPortMalloc() is called internally by the kernel whenever a task, queue,
	timer or semaphore is created.  It is also called by various parts of the
	demo application.  If heap_1.c or heap_2.c are used, then the size of the
	heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
	FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
	to query the size of free heap space that remains (although it does not
	provide information on how the memory might be fragmented).*/
}

void vApplicationIdleHook(void) {
	/* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
	to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
	task.  It is essential that code added to this hook function never attempts
	to block in any way (for example, call xQueueReceive() with a block time
	specified, or call vTaskDelay()).  If the application makes use of the
	vTaskDelete() API function (as this demo application does) then it is also
	important that vApplicationIdleHook() is permitted to return to its calling
	function, because it is the responsibility of the idle task to clean up
	memory allocated by the kernel to any task that has since been deleted. */
}

void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName) {
	(void) pcTaskName;
	(void) pxTask;
	/* Run time stack overflow checking is performed if
	configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
	function is called if a stack overflow is detected. */
	taskDISABLE_INTERRUPTS();
	while (true) {
		// TODO: Add failure recovery code
	}
}

void vApplicationTickHook(void) {}

// Tasks

void taskGPIOCounter(void* param) {
	g_Pio->direction = 0xffffffff;
	g_Pio->port = 0x0F;
	while (1) {
		vTaskDelay(configTICK_RATE_HZ / 32); // 32 Hz
		g_Pio->port += counterMod;
	}
}

void taskCounterMod(void* param){
	while (1) {
		vTaskDelay(configTICK_RATE_HZ);
		counterMod = -counterMod;
	}
}

// Interrupt Handlers

void IRQHandlerUart() {
	char c;
	if (g_Uart->status & UART_RRDY) {
		c = UartGet(g_Uart);
		UartPut(g_Uart, c);
	}
	g_Uart->status = 0;
}
