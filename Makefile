CC = g++

CXXFLAGS = -Wall -std=c++17

ODINLINK =  -Ioidn/include \
			-Loidn/build/ \
			-lOpenImageDenoise
LDFLAGS = -pthread -lOpenImageIO -ltbb $(ODINLINK)

SRC = src/denoise.cpp
BIN = bin/denoise

all: build

build:
	@mkdir -p bin/
	$(CC) $(SRC) $(CXXFLAGS) $(LDFLAGS) -o $(BIN)

.PHONY: build