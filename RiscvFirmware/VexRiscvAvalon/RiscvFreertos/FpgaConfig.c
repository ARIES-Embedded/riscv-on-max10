#include "FpgaConfig.h"

Pio* g_Pio = (Pio*)(MEMADDR_PIO);
Uart* g_Uart = (Uart*)(MEMADDR_UART);
InterruptController* g_InterruptController = (InterruptController*)(MEMADDR_IRQCONTROLLER);
