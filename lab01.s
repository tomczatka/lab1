SYSEXIT32 = 1
SYSCALL32 = 0x80
EXIT_SUCESS = 0
SYSWRITE = 4
SYSREAD = 3
STDOUT = 1
STDIN = 0

input_len = 100

.global _start

.data
input: .space input_len

.text

_start
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $input_len, %edx
int $SYSCALL32

mov %eax, %esp
dec %esp

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $input, %ecx
int $SYSCALL32

mov $SYSEXIT32, %eax
mov $EXIT_SUCESS, %ebx
int SYSCALL32
