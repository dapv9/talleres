

#include <unistd.h>
#include <stdio.h>

int main()
{
    printf("El ID del proceso es: %d\n", (int)getpid());
    printf("El ID del padre del proceso es: %d\n", (int)getppid());
    system("cal");
    system("ls -l .");
}
