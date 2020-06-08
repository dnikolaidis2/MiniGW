CC=gcc
CFLAGS=-std=c99 -Wall -I. -Wno-main

all: mycompiler

tests: correct1 correct2

correct1: mycompiler
	$(CC) $(CFLAGS) -o correct1_c correct1.c -lm
	./mycompiler correct1.ms
	$(CC) $(CFLAGS) -o correct1_ms correct1_im.c -lm

correct2: mycompiler
	$(CC) $(CFLAGS) -o correct2_c correct2.c -lm
	./mycompiler correct2.ms
	$(CC) $(CFLAGS) -o correct2_ms correct2_im.c -lm

mycompiler: bison flex
	$(CC) -o mycompiler lex.yy.c myanalyzer.tab.c cgen.c -lfl

bison: myanalyzer.y
	bison -d -v -r all myanalyzer.y

flex: mylexer.l
	flex mylexer.l

clean:
	rm lex.yy.c || true
	rm myanalyzer.output myanalyzer.tab.c myanalyzer.tab.h || true
	rm correct1_im.c correct1_c correct1_ms || true
	rm correct2_im.c correct2_c correct2_ms || true