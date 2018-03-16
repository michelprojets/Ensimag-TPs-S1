CC=clang
CFLAGS=-std=c99 -Wall -Wextra -g
LDFLAGS=
EXEC=test_annuaire

$(EXEC): annuaire.o test_annuaire.o
	$(CC) -o $@ $^ $(LDFLAGS)

annuaire.o: annuaire.c
	$(CC) -o $@ -c $< $(CFLAGS)

test_annuaire.o: test_annuaire.c annuaire.h
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f *~ *.o $(EXEC)
