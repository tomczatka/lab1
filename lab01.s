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

buf: .ascii "Podaj zdanie do zaszyfrowania: "
buf_len = .-buf

buf1: .ascii "Zaszyfrowane zdanie to: "
buf1_len = .-buf1

.text

_start:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $buf, %ecx
mov $buf_len,%edx
int $SYSCALL32

mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $input_len, %edx
int $SYSCALL32

mov %eax, %esp
dec %esp
mov $0, %ebp

petla:
od_A_do_M:
cmpb $'A', input(%ebp)
jl koniec
cmpb $'M', input(%ebp)
jg od_N_do_Z
add $13, input(%ebp)
jmp koniec

od_N_do_Z:
cmpb $'N', input(%ebp)
jl od_a_do_m
cmpb  $'Z', input(%ebp)
jg od_a_do_m
sub $13, input(%ebp)
jmp koniec

od_a_do_m:
cmpb $'a', input(%ebp)
jl od_n_do_z
cmpb $'m', input(%ebp)
jg od_n_do_z
add $13, input(%ebp)
jmp koniec

od_n_do_z:
cmpb $'n', input(%ebp)
jl koniec
cmpb $'z', input(%ebp)
jg koniec
sub $13, input(%ebp)

koniec:
inc %ebp
cmp %esp, %ebp
jl petla

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $buf1, %ecx
mov $buf1_len,%edx
int $SYSCALL32

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $input, %ecx
int $SYSCALL32

mov $SYSEXIT32, %eax
mov $EXIT_SUCESS, %ebx
int $SYSCALL32
