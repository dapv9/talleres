

#include<unistd.h>
#include<stdio.h>

int main(int argc, char *argv[])
{
    printf("Ejecutable: \n");
    char *args[] = {"ls","-l",".",NULL};

    // Forma 3: Con execvp
    printf("Forma 3: \n");
    execvp("ls",args);

    return 0;
}

