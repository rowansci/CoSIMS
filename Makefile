UNAME_S := $(shell uname -s)

# Default compiler
CXX := g++ -g

# Common flags
CXXFLAGS := -std=c++11 -Isrc/ -MD -fopenmp

# OS-specific adjustments
ifeq ($(UNAME_S),Darwin)
    # macOS does not support fully static linking with system libraries
    # It's okay to do partial static for libgcc / libstdc++ if you want:
		CXX := g++-14 -g
    OS_FLAGS := -static-libgcc -static-libstdc++
else ifeq ($(UNAME_S),Linux)
    # On Linux, -static is fine if you want fully static linking:
    OS_FLAGS := -static
endif

# Merge OS-specific flags
CXXFLAGS += $(OS_FLAGS)

# Build directories
BUILD    := bin
OBJ_DIR  := $(BUILD)
APP_DIR  := $(BUILD)

# App name
TARGET   := cosims

# Source files
SRC      := $(wildcard src/*.cpp)
OBJECTS  := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# If config=debug => add debug flags
ifeq ($(config),debug)
    CXXFLAGS += -O1 -DDEBUG -g
    TARGET := $(TARGET)_debug
else
    CXXFLAGS += -O3
endif

all: build $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@echo "Building " $<
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $@ -c $<

$(APP_DIR)/$(TARGET): $(OBJECTS)
	@echo "\nLinking $(TARGET)"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJECTS)
	@echo "Done"

.PHONY: all build clean debug release

build:
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)

debug: config=debug
debug: all

release: config=release
release: all

clean:
	-@rm -rvf $(OBJ_DIR)/* $(APP_DIR)/*

-include $(OBJECTS:.o=.d)

