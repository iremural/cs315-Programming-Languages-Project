parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: cs315f17_group09.y lex.yy.c
	yacc cs315f17_group09.y
lex.yy.c: cs315f17_group09.l
	lex cs315f17_group09.l
clean:
	rm -f lex.yy.c y.tab.c parser