

#include <stdio.h>
#include <unistd.h>

#define print(X)		printf(X); fflush(stdout)

int main()
{
    print("Hola");

    if(fork() == 0)
    {
        print("Mundo");
        return 0;
    }
    if(fork() == 0)
    {
        print("!");
        return 0;
    }
}
