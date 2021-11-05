#ifndef UART_H
#define UART_H

#include <stdint.h>
#include <stdbool.h>

/* Status register */
#define UART_PE   0x0001
#define UART_FE   0x0002
#define UART_BRK  0x0004
#define UART_ROE  0x0008
#define UART_TOE  0x0010
#define UART_TMT  0x0020
#define UART_TRDY 0x0040
#define UART_RRDY 0x0080
#define UART_E    0x0100
#define UART_BIT9 0x0200
#define UART_DCTS 0x0400
#define UART_CTS  0x0800
#define UART_EOP  0x1000

/* Control register */
#define UART_IPE  0x0001

typedef volatile struct {
  uint32_t rxdata;
  uint32_t txdata;
  uint32_t status;
  uint32_t control;
  uint32_t divisor;
  uint32_t eop;
} Uart;

void UartWriteInt(Uart* pUart, int32_t i, bool newline);
void UartWriteHex32(Uart* pUart, uint32_t ui, bool newline);
void UartWriteHex8(Uart* pUart, uint8_t byte, bool newline);
void UartWrite(Uart* pUart, const char* str);

void UartPut(Uart* pUart, char c);
char UartGet(Uart* pUart);
bool UartGetNonBlocking(Uart* pUart, char* c);

#endif // Uart_H
