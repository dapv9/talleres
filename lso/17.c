

#include <stdio.h>
#include <unistd.h>

int main()
{
    pid_t pid;

    if((pid = fork()) >= 0)
    {
        if(pid == 0)
        {
            if(execl("/bin/no_existe", "no_existe", NULL) < 0)
                perror("No se ha podido ejecutar la orden");
        }
        else
        {
            if(execl("/bin/ls", "ls", "-la", NULL) < 0)
                perror("No se ha podido ejecutar la orden");
        }
    }
    else
    {
        perror("No se ha podido crear el proceso hijo");

        return -1;
    }
}
