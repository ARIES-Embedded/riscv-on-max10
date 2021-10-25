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

#include <stdint.h>

#include "FpgaConfig.h"
#include "Hal.h"

static int counterMod = 1;

void IRQHandlerTimer(void) {
	// Invert direction of counter
	counterMod = -counterMod;
	// Rearm timer
	Hal_TimerStart(2 * CLK_FREQ); // 2 seconds
}

void IRQHandlerUart(void) {
	g_Uart->status = 0;
	char c;
	// With non latched interrupt, the UART interrupt is triggered twice,
	// so check whether receive register actually has data.
	if (UartGetNonBlocking(g_Uart, &c)) {
		UartPut(g_Uart, c);
	}
}

int main() {

	// Greetings
	UartWrite(g_Uart, "\n\n* * * PicoRV32 Demo  -  ");
	UartWrite(g_Uart, DBUILD_VERSION);
	UartWrite(g_Uart, "  - ");
	UartWrite(g_Uart, DBUILD_DATE);
	UartWrite(g_Uart, "  * * *\n");

	// Set GPIO to output.
	g_Pio->direction = 0xffffffff;

	// Enable interrupt on UART receive.
	Hal_SetExtIrqHandler(IRQ_UART, IRQHandlerUart);
	Hal_EnableInterrupt(IRQ_UART);
	g_Uart->control |= UART_RRDY;

	// Enable timer interrupt to trigger in 3 seconds.
	Hal_SetExtIrqHandler(IRQ_TIMER, IRQHandlerTimer);
	Hal_EnableInterrupt(IRQ_TIMER);
	Hal_TimerStart(3 * CLK_FREQ);

	// Binary counter that ticks 32 times per second
	uint32_t timeLast = Hal_ReadTime32();
	while (1) {
		uint32_t timeNow = Hal_ReadTime32();
		if ((timeNow - timeLast) > (CLK_FREQ / 32)) {
			timeLast = timeNow;
			g_Pio->port += counterMod;
		}
	}

}
