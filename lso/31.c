

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <wait.h>


pid_t crear_hijo();
static int a = 9;

int main()
{
    pid_t r1, r2, r3, r4, r5;
    int status_1;
    printf("\033[32mpid\tppid\n");

    // creo hijo 1
    if ((r1 = crear_hijo()) >= 0)
    {
        if(r1 == 0)
        {
            // creo el nieto 1
            if ((r3 = crear_hijo()) >= 0)
            {
                if(r3 == 0)
                    exit(0);
                else
                    wait(&status_1);
            }
            else
                perror("No se ha podido crear el hijo 3");

            if ((r4 = crear_hijo()) >= 0)
            {
                if(r4 == 0)
                    exit(0);
                else
                    wait(&status_1);
            }
            else
                perror("No se ha podido crear el hijo 4");
        }
        else
            wait(&status_1);
    }
    else
        perror("No se ha podido crear el hijo 1");

    // creo hijo 2
    if ((r2 = crear_hijo()) >= 0)
    {
        if(r2 > 0)
            wait(&status_1);
    }
    else
        perror("No se ha podido crear el hijo 2");
}


pid_t crear_hijo()
{
    pid_t r;

    if((r = fork()) == 0)
        printf("\033[37m%d\t%d\n", getpid(), getppid());

    return r;
}
