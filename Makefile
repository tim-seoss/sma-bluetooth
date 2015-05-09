ARCH := $(shell getconf LONG_BIT)
C_FLAGS_64 := -L/usr/lib64/mysql
C_FLAGS_32 := -L/usr/lib/mysql

C_FLAGS := -O2
#C_FLAGS := -g

smatool: smatool.o repost.o sma_mysql.o almanac.o
	gcc smatool.o repost.o sma_mysql.o almanac.o -O2 -fstack-protector-all -Wall $(C_FLAGS_$(ARCH)) -lmysqlclient -lbluetooth -lcurl -lm -o smatool 
smatool.o: smatool.c sma_mysql.h
	gcc $(C_FLAGS) -c smatool.c
repost.o: repost.c sma_mysql.h
	gcc $(C_FLAGS) -c repost.c
sma_mysql.o: sma_mysql.c
	gcc $(C_FLAGS) -c sma_mysql.c
almanac.o: almanac.c
	gcc $(C_FLAGS) -c almanac.c
sma_pvoutput.o: sma_pvoutput.c
	gcc $(C_FLAGS) -c sma_pvoutput.c
clean:
	rm *.o
install:
	install -m 755 smatool /usr/local/bin
	install -m 644 invcode.in /usr/local/bin

