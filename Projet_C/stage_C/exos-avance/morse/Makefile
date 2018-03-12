CC=clang
CFLAGS=-std=c99 -Wall -Wextra -g
LDFLAGS=
EXEC=test_morse

$(EXEC): morse.o test_morse.o
	$(CC) -o $@ $^ $(LDFLAGS)

morse.o: morse.c
	$(CC) -o $@ -c $< $(CFLAGS)

test_morse.o: test_morse.c morse.h
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f *~ *.o $(EXEC)
