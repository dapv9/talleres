
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define SHMSZ	27

int main()
{
    char c;
    int shmid;
    key_t key;
    char *shm, *s;

    /* Nombre del segmento de memoria
       compartida = "1234". */
    key = 1234;

    /* Se crea el segmento de memoria */
    if ((shmid = shmget(key, SHMSZ, IPC_CREAT | 0666)) < 0)
    {
        perror("shmget");
        exit(1);
    }

    /* El programa se adhiere (attach) al segmento ya creado */
    if ((shm = shmat(shmid, NULL, 0)) == (char *) (-1))
    {
        perror("shmat");
        exit(1);
    }

    /* Se ponen algunos datos en el segmento para que el proceso
       cliente los lea. */
    s = shm;
    for (c = 'a'; c <= 'z'; c++) *s++ = c;

    *s = 0;

    /* Por último, se espera a que el proceso cliente
       cambie el primer caracter
       de la memoria compartida a '*' indicando que ya leyó la información. */

    while (*shm != '*') sleep(1);

    exit(0);
}

