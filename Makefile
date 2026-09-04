CC = gcc
CFLAGS = -g -Wall -Wextra -fPIC -I.
LIB_NAME = libFast3D.so
LIB_HEADER = Fast3D.h
LIB_DIR = /usr/local/lib
INC_DIR = /usr/local/include

PREFIX ?= /usr/local

VERSION = 1.0.0

all: $(LIB_NAME)

$(LIB_NAME): Fast3D.c Fast3D.h
	$(CC) $(CFLAGS) -shared -o $@ Fast3D.c -lm

Fast3D.pc: Fast3D.pc.in
	sed \
		-e 's|@prefix@|$(PREFIX)|g' \
		-e 's|@VERSION@|$(VERSION)|g' \
		$< > $@

clean:
	rm -f $(LIB_NAME) Fast3D.pc

install: $(LIB_NAME)
	install -d $(LIB_DIR)
	install -d $(INC_DIR)
	install -d $(PKGCONFIG_DIR)
	install -m 755 $(LIB_NAME) $(LIB_DIR)/$(LIB_NAME)
	install -m 644 $(LIB_HEADER) $(INC_DIR)/$(LIB_HEADER)
	install -m 644 Fast3D.pc $(PKGCONFIG_DIR)/Fast3D.pc

uninstall:
	rm -f $(LIB_DIR)/$(LIB_NAME)
	rm -f $(INC_DIR)/$(LIB_HEADER)
	rm -f $(PKGCONFIG_DIR)/Fast3D.pc

.PHONY: all clean install uninstall