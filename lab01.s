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

_start:
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $input_len, %edx
int $SYSCALL32

mov %eax, %esp
dec %esp
mov $0, %ebp

petla:
od_A_do_N:
cmpb $'A', input(%ebp)
jl od_N_do_Z
cmpb $'N', input(%ebp)
jg od_N_do_Z
add $13, input(%ebp)


od_N_do_Z:

inc %ebp
cmp %esp, %ebp
jl petla

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $input, %ecx
int $SYSCALL32

mov $SYSEXIT32, %eax
mov $EXIT_SUCESS, %ebx
int $SYSCALL32
