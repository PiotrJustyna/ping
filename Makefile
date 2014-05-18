# arm-none-eabi -> [ARCHITECTURE]-[NO_SPECIFIC_OS_TO_BUILD_FOR]-[EMBEDDED_APPLICATION_BINARY_INTERFACE]
TOOLCHAIN ?= arm-none-eabi
ASSEMBLER ?= $(TOOLCHAIN)-as
LINKER ?= $(TOOLCHAIN)-ld
OBJECTCOPY ?= $(TOOLCHAIN)-objcopy

BUILD = build/
SOURCE = source/

TARGET = kernel.img
LINKERSCRIPT = linker.ld

OBJECTS := $(patsubst $(SOURCE)%.s, $(BUILD)%.o, $(wildcard $(SOURCE)*.s))

all: $(TARGET)

$(BUILD):
	mkdir $@

# Assemble the object files. Every *.s file gets assembled as an *.o file
$(BUILD)%.o: $(SOURCE)%.s $(BUILD)
	$(ASSEMBLER) -I $(SOURCE) $< -o $@

# Link the object files to make the elf file.
$(BUILD)output.elf: $(OBJECTS) $(LINKERSCRIPT)
	$(LINKER) --no-undefined $(OBJECTS) -o $(BUILD)output.elf -T $(LINKERSCRIPT)

# Generate the image file from the elf file.
$(TARGET): $(BUILD)output.elf
	$(OBJECTCOPY) $(BUILD)output.elf -O binary $(TARGET)

rebuild: clean $(BUILD) all

clean: 
	-rm -rf $(BUILD)
	-rm -f $(TARGET)