CC = gcc
CFLAGS = -g -Wall -Wextra -fPIC -I.
LIB_NAME = libFast3D.so
LIB_HEADER = Fast3D.h
LIB_DIR = /usr/local/lib
INC_DIR = /usr/local/include

all: $(LIB_NAME)

$(LIB_NAME): Fast3D.c Fast3D.h
	$(CC) $(CFLAGS) -shared -o $@ Fast3D.c -lm

clean:
	rm -f $(LIB_NAME)

install: $(LIB_NAME)
	install -d $(LIB_DIR)
	install -d $(INC_DIR)
	install -m 755 $(LIB_NAME) $(LIB_DIR)/
	install -m 644 $(LIB_HEADER) $(INC_DIR)/

uninstall:
	rm -f $(LIB_DIR)/$(LIB_NAME)
	rm -f $(INC_DIR)/$(LIB_HEADER)

.PHONY: all clean install uninstall