#include "FpgaConfig.h"

InterruptController* g_InterruptController = (InterruptController*)(MEMADDR_INTERRUPTCONTROLLER);
Pio* g_Pio = (Pio*)(MEMADDR_PIO);
Uart* g_Uart = (Uart*)(MEMADDR_UART);
