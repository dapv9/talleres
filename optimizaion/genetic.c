
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define N	4

double drand48();

typedef struct __pair__
{
    float n1;
    float n2;
} pair;

float f_p(float x, float y) {
    return x * y;
}

float genetic(float (*f)(float, float), pair limit_x, pair limit_y, int n)
{
    srand48(time(NULL));

    int i;
    float w_x = limit_x.n2 - limit_x.n1;
    float w_y = limit_y.n2 - limit_y.n1;
    float popul_x[4];
    float popul_y[4];

    for(i = 0; i < N; i++)
    {
        popul_x[i] = (w_x * drand48()) + limit_x.n1;
        popul_y[i] = (w_y * drand48()) + limit_y.n1;
    }
}

int main()
{
    pair lx = {10.2f, 50.4f};
    pair ly = {60.1f, 90.2f};

    genetic(f_p, lx, ly, 5);
}
