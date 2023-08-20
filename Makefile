# Compiler and compiler flags
CXX := g++
CXXFLAGS := -Wall -Wextra -std=c++17 -Iinclude

# Directories
SRCDIR = src
INCDIR = include
BUILDDIR = build

# Precompiled header
PCH = $(INCDIR)/pch.h
PCH_FLAGS = -include $(PCH)

# Source, header, and object files
SOURCES = $(wildcard $(SRCDIR)/*.cpp)
HEADERS = $(wildcard $(INCDIR)/*.h)
OBJECTS = $(patsubst $(SRCDIR)/%.cpp,$(BUILDDIR)/%.o,$(SOURCES))

# Binary name
TARGET = file_manager

# Determine the operating system
ifeq ($(OS),Windows_NT)
    RM = del /Q
    MKDIR = mkdir
else
    RM = rm -f
    MKDIR = mkdir -p
endif


# Rules
all: $(TARGET)

# Make main target (executable)
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(PCH_FLAGS) -o $@ $(OBJECTS)

# Build object files
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp | $(BUILDDIR)
	$(CXX) $(CXXFLAGS) $(PCH_FLAGS) -I$(INCDIR) -c $< -o $@

#Create build directory
$(BUILDDIR):
	$(MKDIR) $(BUILDDIR)

clean:
	$(RM) $(OBJECTS) $(TARGET)