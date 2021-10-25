C_SRC	:= $(wildcard *.c)
C_SRC	+= $(wildcard FreeRTOS/*.c)
C_SRC	+= $(wildcard FreeRTOS/portable/*.c)
A_SRC	:= $(wildcard *.S)
A_SRC	+= $(wildcard FreeRTOS/*.S)
A_SRC	+= $(wildcard FreeRTOS/portable/*.S)
LD_SCRIPT := link.ld
DIRS := out .obj .obj/FreeRTOS .obj/FreeRTOS/portable

# Filter out any source files to be not included in the build
C_FILTER :=

C_SRC := $(filter-out $(C_FILTER), $(C_SRC))
C_OUT := $(addprefix .obj/, $(C_SRC:.c=.o))
A_OUT := $(addprefix .obj/, $(A_SRC:.S=.S.o))

CROSS_COMPILE = riscv64-unknown-elf-

RM := rm -rf
CC := $(CROSS_COMPILE)gcc
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump
BIN2MIF := python3 bin2mif.py

ARCH := rv32im
ABI := ilp32

BUILD_VERSION := "$(shell git describe --abbrev=8 --dirty --always --tags)"
BUILD_DATE := "$(shell date '+%Y-%m-%d %H:%M:%S %:::z')"

CFLAGS  := -fno-delete-null-pointer-checks -g -march=$(ARCH) -mabi=$(ABI) -Wall -std=gnu99 -I. -ffunction-sections -fdata-sections -Os -flto -fno-strict-aliasing
CFLAGS += -DDBUILD_VERSION=\"$(BUILD_VERSION)\"
CFLAGS += -DDBUILD_DATE=\"$(BUILD_DATE)\"

LDFLAGS := -march=$(ARCH) -mabi=$(ABI) -static -nostartfiles -nostdlib -lgcc -lc -Wl,-print-memory-usage -Wl,-gc-sections

APP = out/bootrom

DUMP := $(APP).dump
ELF  := $(APP).elf
BIN  := $(APP).bin
HEX  := $(APP).hex
SREC := $(APP).s37
MIF  := $(APP).mif

all: $(MIF)

make_dirs:
	$(shell mkdir -p $(DIRS))

.obj/%.o: %.c make_dirs
	$(CC) $(CFLAGS) -c $< -o $@

.obj/%.S.o: %.S make_dirs
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(C_OUT) $(A_OUT) $(LD_SCRIPT)
	$(CC) -T $(LD_SCRIPT) $(A_OUT) $(C_OUT) -o $@ $(LDFLAGS)
	$(OBJDUMP) -D $@ > $(DUMP)

$(SREC): $(ELF)
	$(OBJCOPY) -I elf32-littleriscv -O srec --srec-forceS3 $< $@

$(MIF): $(BIN)
	$(BIN2MIF) $< 0x0 > $@

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex $< $@

.PHONY: all clean distclean print debug

clean:
	$(RM) $(DIRS)

print:
	@echo C_SRC $(C_SRC)
	@echo A_SRC $(A_SRC)
	@echo DIRS $(DIRS)
