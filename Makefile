
all: minilex minigw

minilex: bison flex lex.yy.c minison.tab.c
		gcc -o minilex lex.yy.c minison.tab.c cgen.c -lfl -g

minigw: bison flex lex.yy.c minison.tab.c
		gcc -o minigw lex.yy.c minison.tab.c cgen.c -lfl -g

bison: minison.y
	bison -d -v -r all minison.y

flex: minilex.l
	flex minilex.l

clean:
	rm minilex lex.yy.c || true
	rm minison.output minison.tab.c minison.tab.h minigw || true