
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

#define N	4
#define N_CROSS		10
#define N_CROSS_D	10.0

#define debug()		printf("%d - %s\n", __LINE__, __FILE__)
#define print_farr(X)	for(i = 0; i < N; i++) printf("%f\n", (X)[i])

double drand48();

typedef struct __pair__f__
{
    float n1;
    float n2;
} pair_f;

typedef struct __pair__i__
{
    int n1;
    int n2;
} pair_i;

float f_p(float x, float y)
{
    return x * y;
}

int index_max(float * arr)
{
    int i, i_max = 0;

    for(i = 0; i < N; i++)
        if(arr[i] > arr[i_max])
            i_max = i;

    return i_max;
}

double cross(double n1, double n2, int cross)
{
    int i, a = 0;

    for(i = 0; i < cross; i++)
        a = (a << 1) | 1;

    // printf("cross: %d\ta: %d\tn1*10: %d\tn2*10: %d\n", cross, a, (int)(n1*N_CROSS), (int)(n2*N_CROSS));

    return (((int)(n1*N_CROSS) & ~a) | ((int)(n2*N_CROSS) & a)) / N_CROSS_D;
}

void new_population(float * popul_x, float * popul_y, float * prob)
{
    int i, i_max = 0;
    int n_popul[4];
    float n_popul_x[4];
    float n_popul_y[4];
    float prob_cpy[4];

    // hago una copia del vector de probabilidad
    memcpy(prob_cpy, prob, sizeof(float)*N);

    // encuentro la probabilidad mayor dentro del arreglo.
    n_popul[0] = n_popul[1] = i_max = index_max(prob_cpy);
    prob_cpy[i_max] = -1.0f;

    n_popul[2] = index_max(prob_cpy);
    prob_cpy[i_max] = -1.0f;
    n_popul[3] = index_max(prob_cpy);

    for(i = 0; i < N; i++)
    {
        n_popul_x[i] = popul_x[n_popul[i]];
        n_popul_y[i] = popul_y[n_popul[i]];
    }

    pair_i mating_order[4] = {0, 1, 1, 2, 2, 3, 0, 3};

    int o_cross[4];
    srand(time(NULL));
    o_cross[0] = rand() % 32;
    o_cross[1] = rand() % 32;
    o_cross[2] = rand() % 32;
    o_cross[3] = rand() % 32;

    for(i = 0; i < N; i++)
    {
        popul_x[i] = cross(n_popul_x[mating_order[i].n1], n_popul_x[mating_order[i].n2], o_cross[i]);
        popul_y[i] = cross(n_popul_y[mating_order[i].n1], n_popul_y[mating_order[i].n2], o_cross[i]);
    }
}

float genetic(float (*f)(float, float), pair_f limit_x, pair_f limit_y, int n)
{
    srand48(time(NULL));

    register int i;
    int ii;
    float w_x = limit_x.n2 - limit_x.n1;
    float w_y = limit_y.n2 - limit_y.n1;
    float popul_x[4];
    float popul_y[4];
    float p_total = 0.0f;
    float p[4];

    for(i = 0; i < N; i++)
    {
        popul_x[i] = (w_x * drand48()) + limit_x.n1;
        popul_y[i] = (w_y * drand48()) + limit_y.n1;
    }

    for(ii = 0; ii < n; ii++)
    {
        for(i = 0; i < N; i++)
        {
            p[i] = f(popul_x[i], popul_y[i]);
            p_total += p[i];
        }

        for(i = 0; i < N; i++)
            p[i] /= p_total;

        new_population(popul_x, popul_y, p);
    }

    for(i = 0 ; i < N; i++)
        printf("popul: (%.4f, %.4f)\n", popul_x[i], popul_y[i]);
}

int main()
{
    pair_f lx = {10.2f, 50.4f};
    pair_f ly = {60.1f, 90.2f};

    genetic(f_p, lx, ly, 5);
}
