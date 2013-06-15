

#include<unistd.h>
#include<stdio.h>

int main(int argc, char *argv[])
{
    printf("Ejecutable: \n");

    // Forma 1: Con execl
    printf("Forma 1: \n");
    execl("/bin/ls","/bin/ls","-l",".",NULL);

    return 0;
}

