# Project name
NAME = browsergame

# Compiler &- flags
COMPILER = clang
TARGET   = wasm32-unknown-unknown
CFLAGS   = -Isrc/lib -Wall -Wextra
LDFLAGS  =

# Default build mode
BUILD ?= release

# Adjustments for WASM target
ifneq ($(findstring wasm, $(TARGET)),)
	NAME    := $(NAME).wasm
	CFLAGS  += --no-standard-libraries
	LDFLAGS += -Wl,--no-entry
endif

# Compiler flags for "release" or "debug"
ifeq (release, $(BUILD))
	CFLAGS  += -Werror -Oz -flto
	LDFLAGS += -Wl,-strip-all
else
	CFLAGS  += -O0 -g
	LDFLAGS +=
endif

# Definition of phony targets
.PHONY: all build clean

# Main target, builds everything
all: target/$(TARGET)/$(BUILD)/$(NAME)

# Clean target
clean:
	rm -rf target

# Validation of the BUILD mode
ifneq ($(filter $(BUILD),debug release),$(BUILD))
	$(error "Invalid BUILD=$(BUILD), must be 'debug' or 'release'")
endif

# Finding source and object files
SOURCE_FILES = $(shell find src -type f -name *.c)
OBJECT_FILES = $(patsubst src/%.c, target/$(TARGET)/$(BUILD)/artifacts/%.o, $(SOURCE_FILES))

# Inclusion of dependency files
include $(wildcard $(patsubst %.o, %.d, $(OBJECT_FILES)))

# Creating directories for object files
$(sort $(dir $(OBJECT_FILES))):
	@mkdir -p $@

# Rule for compiling C files
target/$(TARGET)/$(BUILD)/artifacts/%.o: src/%.c | $(sort $(dir $(OBJECT_FILES))) makefile
	@$(COMPILER) --target=$(TARGET) $(CFLAGS) -MMD -c -o $@ $< \
		&& echo "\033[1;32m[INFO]\033[0m Compiled successfully:" $@

# Rule for linking object files and creating the binary
target/$(TARGET)/$(BUILD)/$(NAME): $(OBJECT_FILES) | makefile
	@$(COMPILER) --target=$(TARGET) $(CFLAGS) $(LDFLAGS) $(LG) -o $@ $^   \
		&& echo "\033[1;32m[INFO]\033[0m Compiled successfully:" $@       \
		&& printf "\033[1;32m[INFO]\033[0m Compilation completed (Size: " \
		&& wc -c < $@ | numfmt --to=iec-i --suffix=B --format="%f)"
