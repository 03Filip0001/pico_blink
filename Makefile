CC = arm-none-eabi-

GCC := $(CC)gcc
OBJCOPY := $(CC)objcopy
ELF2UF2=picotool

CFLAGS=-mcpu=cortex-m33 -mthumb -nostdlib -Wall -O2 -ffreestanding -fno-common
LDFLAGS=-T linker.ld

TARGET=firmware

BUILD_DIR := build
BIN_DIR := bin

SRC_C := $(wildcard *.c)
SRC_S := $(wildcard *.s)
SRC := $(SRC_C) $(SRC_S)

OBJ_C := $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC_C))
OBJ_S := $(patsubst %.s,$(BUILD_DIR)/%.o,$(SRC_S))
OBJ := $(OBJ_C) $(OBJ_S)

.PHONY: all clean

all: directories $(BIN_DIR)/$(TARGET).uf2

directories:
	clear
	mkdir -p $(BUILD_DIR) $(BIN_DIR)

# Link all object files into ELF
$(BIN_DIR)/$(TARGET).elf: $(OBJ)
	$(GCC) $(CFLAGS) $(LDFLAGS) -o $@ $^

# Compile .c to .o in build directory
$(BUILD_DIR)/%.o: %.c | directories
	$(GCC) $(CFLAGS) -c $< -o $@

# Assemble .s to .o in build directory
$(BUILD_DIR)/%.o: %.s | directories
	$(GCC) $(CFLAGS) -c $< -o $@

# Convert ELF to UF2 in bin directory
$(BIN_DIR)/$(TARGET).uf2: $(BIN_DIR)/$(TARGET).elf
	$(ELF2UF2) uf2 convert $< $@

clean:
	clear 
	rm -rf $(BUILD_DIR) $(BIN_DIR)