#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NTHREADS      100
#define LOOPS         10000
int sum = 0;
pthread_mutex_t sum_mutex;

void *do_work()
{
    int i;

    // pthread_mutex_lock(&sum_mutex);

    for (i=0; i<LOOPS; i++)
        sum = sum + 1;

    // pthread_mutex_unlock(&sum_mutex);

    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    int i;
    pthread_t threads[NTHREADS];
    pthread_attr_t attr;

    pthread_mutex_init(&sum_mutex, NULL);
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    for (i=0; i<NTHREADS; i++)
        pthread_create(&threads[i], &attr, &do_work, NULL);

    for (i=0; i<NTHREADS; i++)
        pthread_join(threads[i], NULL);

    printf ("Thread sum: %d\n", sum);

    sum=0;

    for (i=0; i<NTHREADS * LOOPS; i++)
        sum = sum + 1;

    printf("Check sum:  %d\n",sum);

    pthread_attr_destroy(&attr);
    pthread_mutex_destroy(&sum_mutex);
    pthread_exit(NULL);
}
