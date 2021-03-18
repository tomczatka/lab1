all: lab01

lab01: lab01.o
  ld lab01.o -o lab01

lab01.o: lab01.s
	as lab01.s -o lab01.o

clean:
	rm lab01.o lab01
