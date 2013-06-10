
#include <syscall.h>
#include <stdio.h>

int main()
{
    long ID1, ID2;
    /*-----------------------------*/
    /* direct system call          */
    /* SYS_getpid (func no. is 20) */
    /*-----------------------------*/
    ID1 = syscall(SYS_getpid);
    printf("syscall(%d)=%ld\n", SYS_getpid, ID1);

    /*-----------------------------*/
    /* "libc" wrapped system call  */
    /* SYS_getpid (Func No. is 20) */
    /*-----------------------------*/
    ID2 = getpid();
    printf("getpid()=%ld\n", ID2);
}

