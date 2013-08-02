

#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

#define TRUE			1
#define TIEMPO_PRODUCCION	3
#define TIEMPO_CONSUMO		1

typedef int semaforo_t;

/**
 * semaforo que controla si en la cadena de producción
 * hay productos disponibles para ser consumidos.
 */
volatile semaforo_t cadena = 1;
int productos = 0;

void* productor(void*);
void* consumidor(void*);

void down(volatile semaforo_t * s);
void up(volatile semaforo_t * s);

int main()
{
    pthread_t hilo_productor, hilo_consumidor;

    pthread_create(&hilo_productor, NULL, productor, NULL);
    sleep(1);
    pthread_create(&hilo_consumidor, NULL, consumidor, NULL);

    pthread_join(hilo_productor, NULL);
    pthread_join(hilo_consumidor, NULL);
}


void* productor(void*)
{

    while(TRUE)
    {
        down(&cadena);
        if (productos == 0)
        {
            printf("Produciendo...\n");
            sleep(TIEMPO_PRODUCCION);
            productos++;
            printf("Unidad producida %d.\n", productos);
        }
        up(&cadena);
    }

    return NULL;
}

void* consumidor(void*)
{
    while(TRUE)
    {
        down(&cadena);
    
        if (productos != 0)
        {
            printf("Consumiendo...\n");
            sleep(TIEMPO_CONSUMO);
            productos--;
            printf("Consumimos una unidad %d.\n", productos);
        }
    
        up(&cadena);
    }

    return NULL;
}

void down(volatile semaforo_t * s)
{
    while (*s <= 0);
    (*s)--;
}

void up(volatile semaforo_t * s)
{
    (*s)++;
}

