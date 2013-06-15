

#include<unistd.h>
#include<stdio.h>

int main(int argc, char *argv[])
{
    printf("Ejecutable: \n");
    char *args[] = {"/bin/ls","-l",".",NULL};
    // Forma 1: Con execl
    printf("Forma 1: \n");
    execl("/bin/ls","/bin/ls","-l",".",NULL);
    // Forma 2: Con execv
    printf("Forma 2: \n");
    execv("/bin/ls",args);
    // Forma 3: Con execl
    printf("Forma 3: \n");
    execvp("/bin/ls",args);

    return 0;
}

