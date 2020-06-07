CC=gcc
CFLAGS=-std=c99 -Wall -I. -Wno-main -g

all: minigw

tests: correct1 correct2 useless myprog prime

correct1: minigw
	$(CC) $(CFLAGS) -o correct1_c tests/correct1.c -lm
	./minigw tests/correct1.ms
	$(CC) $(CFLAGS) -o correct1_ms correct1.c -lm

correct2: minigw
	$(CC) $(CFLAGS) -o correct2_c tests/correct2.c -lm
	./minigw tests/correct2.ms
	$(CC) $(CFLAGS) -o correct2_ms correct2.c -lm

useless: minigw
	$(CC) $(CFLAGS) -o useless_c tests/useless.c -lm
	./minigw tests/useless.ms
	$(CC) $(CFLAGS) -o useless_ms useless.c -lm

myprog: minigw
	$(CC) $(CFLAGS) -o myprog_c tests/myprog.c -lm
	./minigw tests/myprog.ms
	$(CC) $(CFLAGS) -o myprog_ms myprog.c -lm

prime: minigw
	$(CC) $(CFLAGS) -o prime_c tests/prime.c -lm
	./minigw tests/prime.ms
	$(CC) $(CFLAGS) -o prime_ms prime.c -lm

minigw: bison flex
	$(CC) -o minigw lex.yy.c minison.tab.c cgen.c -lfl

bison: minison.y
	bison -d -v -r all minison.y

flex: minilex.l
	flex minilex.l

clean:
	rm minilex lex.yy.c || true
	rm minison.output minison.tab.c minison.tab.h minigw || true
	rm correct1.c correct1_c correct1_ms || true
	rm correct2.c correct2_c correct2_ms || true
	rm useless.c useless_c useless_ms || true
	rm myprog.c myprog_c myprog_ms || true
	rm prime.c prime_c prime_ms || true