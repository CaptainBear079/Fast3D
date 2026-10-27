CC = gcc
CFLAGS = -g -Wall -Wextra -fPIC -I.
LIB_NAME = libFast3D.so
LIB_HEADER = Fast3D.h
BUILD_DIR = build
LIB_DIR = /usr/local/lib
INC_DIR = /usr/local/include
PKGCONFIG_DIR = /usr/local/lib/pkgconfig

PREFIX ?= /usr/local

VERSION = 1.0.0

all: $(LIB_NAME) $(BUILD_DIR)/Fast3D.pc

$(LIB_NAME): Fast3D.c Fast3D.h
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -shared -o $(BUILD_DIR)/$@ Fast3D.c -lm

$(BUILD_DIR)/Fast3D.pc: Fast3D.pc.in
	sed \
		-e 's|@prefix@|$(PREFIX)|g' \
		-e 's|@VERSION@|$(VERSION)|g' \
		$< > $@

clean:
	rm -f $(BUILD_DIR)/*

install: $(LIB_NAME)
	sudo install -d $(LIB_DIR)
	sudo install -d $(INC_DIR)
	sudo install -d $(PKGCONFIG_DIR)
	sudo install -m 755 $(BUILD_DIR)/$(LIB_NAME) $(LIB_DIR)/$(LIB_NAME)
	sudo install -m 644 $(LIB_HEADER) $(INC_DIR)/$(LIB_HEADER)
	sudo install -m 644 $(BUILD_DIR)/Fast3D.pc $(PKGCONFIG_DIR)/Fast3D.pc

uninstall:
	rm -f $(LIB_DIR)/$(LIB_NAME)
	rm -f $(INC_DIR)/$(LIB_HEADER)
	rm -f $(PKGCONFIG_DIR)/Fast3D.pc

.PHONY: all clean install uninstall