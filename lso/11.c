#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <wait.h>


pid_t crear_hijo();
static int a = 9;

int main()
{
    int status_1;
    printf("\033[32mpid\tppid\n");

    // creo hijo 1
    if (crear_hijo() == 0)
    {
        // creo el nieto 1
        if (crear_hijo() == 0)
            exit(1);
        else
        {
            wait(&status_1);
            printf("\033[32mretorno nieto 1: %d\n", WEXITSTATUS(status_1));
            exit(2);
        }
    }

    // creo hijo 2
    if (crear_hijo() == 0)
    {
        // creo el nieto 2
        if (crear_hijo() == 0)
            exit(3);
        else
        {
            wait(&status_1);
            printf("\033[32mretorno nieto 1: %d\n", WEXITSTATUS(status_1));
            exit(4);
        }
    }

    wait(&status_1);
    printf("\033[32mretorno hijo 1: %d\n", WEXITSTATUS(status_1));
    wait(&status_1);
    printf("\033[32mretorno hijo 2: %d\n\033[37m", WEXITSTATUS(status_1));
}


pid_t crear_hijo()
{
    pid_t r;

    if((r = fork()) == 0)
        printf("\033[37m%d\t%d\n", getpid(), getppid());

    return r;
}

