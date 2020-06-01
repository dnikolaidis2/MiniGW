
all: minilex minigw

minilex: bison flex
		gcc -o minilex lex.yy.c -lfl -g

minigw: bison flex
		gcc -o minigw lex.yy.c minison.tab.c -lfl -g

bison:
	bison -d -v -r all minison.y

flex:
	flex minilex.l

clean:
	rm minilex lex.yy.c || true
	rm minison.output minison.tab.c minison.tab.h minigw || true