CC = arm-none-eabi-g++
MACH = cortex-m7

SRCDIR = src
INCDIR = include
BUILDDIR = build

TARGET = $(BUILDDIR)/final.elf

# Find all .cpp files recursively
CPP_SOURCES := $(shell find $(SRCDIR) -name '*.cpp')


OBJECTS := $(CPP_SOURCES:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

CFLAGS = -c -mcpu=$(MACH) -mthumb -std=gnu++20 -Wall \
         -ffreestanding -fno-exceptions -fno-rtti \
         -g -O0 \
         -I$(INCDIR)

LDFLAGS = -mcpu=$(MACH) -mthumb \
          -T ls.ld \
          -Wl,-Map=$(BUILDDIR)/final.map \
          -Wl,--gc-sections \
          -nostartfiles \
          -g

all: $(BUILDDIR) $(TARGET)

# Ensure build directory exists
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Compile any src/**/file.cpp -> build/**/file.o
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Link everything
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

clean:
	rm -rf $(BUILDDIR) $(TARGET)

clean_all:
	rm -rf $(BUILDDIR) $(TARGET) *.map