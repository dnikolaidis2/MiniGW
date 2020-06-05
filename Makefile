
all: minigw

tests: correct1 useless myprog

correct1: minigw
	gcc -std=c99 -Wall -o correct1_c tests/correct1.c -I$(shell pwd)
	./minigw tests/correct1.ms
	gcc -std=c99 -Wall -o correct1_ms correct1.c -I$(shell pwd)

useless: minigw
	gcc -std=c99 -Wall -o useless_c tests/useless.c -I$(shell pwd)
	./minigw tests/useless.ms
	gcc -std=c99 -Wall -o useless_ms useless.c -I$(shell pwd)

myprog: minigw
	gcc -std=c99 -Wall -o myprog_c tests/myprog.c -I$(shell pwd)
	./minigw tests/myprog.ms
	gcc -std=c99 -Wall -o myprog_ms myprog.c -I$(shell pwd)

prime: minigw
	gcc -std=c99 -Wall -o prime_c tests/prime.c -I$(shell pwd)
	./minigw tests/prime.ms
	gcc -std=c99 -Wall -o prime_ms prime.c -I$(shell pwd)

minigw: bison flex
	gcc -o minigw lex.yy.c minison.tab.c cgen.c -lfl

bison: minison.y
	bison -d -v -r all minison.y

flex: minilex.l
	flex minilex.l

clean:
	rm minilex lex.yy.c || true
	rm minison.output minison.tab.c minison.tab.h minigw || true
	rm correct1.c correct1_c correct1_ms || true
	rm useless.c useless_c useless_ms || true
	rm myprog.c myprog_c myprog_ms || true
	rm prime.c prime_c prime_ms || true