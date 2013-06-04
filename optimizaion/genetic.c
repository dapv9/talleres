
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

#define N	4
#define N_FLOAT		10000
#define N_FLOAT_D	10000.0
#define N_CROSS		16
#define INF		1 << 28

#define debug()		printf("%d - %s\n", __LINE__, __FILE__)
#define print_farr(X)	for(i = 0; i < N; i++) printf("%f\n", (X)[i])

// double drand48();

typedef struct __pair__f__
{
    double n1;
    double n2;
} pair_f;

typedef struct __pair__i__
{
    int n1;
    int n2;
} pair_i;

double function(double x, double y)
{
    return 20 + x*x + y*y - 10 * (cos(2 * M_PI * x) + cos(2 * M_PI * y));
}

int index_min(double * arr)
{
    int i, i_min = 0;

    for(i = 0; i < N; i++)
        if(arr[i] < arr[i_min])
            i_min = i;

    return i_min;
}

double cross(double n1, double n2, int cross)
{
    int i, a = 0;

    for(i = 0; i < cross; i++)
        a = (a << 1) | 1;

    // printf("cross: %d\ta: %d\tn1*10: %d\tn2*10: %d\n", cross, a, (int)(n1*N_FLOAT), (int)(n2*N_FLOAT));

    return (((int)(n1*N_FLOAT) & ~a) | ((int)(n2*N_FLOAT) & a)) / N_FLOAT_D;
}

void new_population(double * popul_x, double * popul_y, double * prob)
{
    int i, i_min = 0;
    int n_popul[N];
    double n_popul_x[N];
    double n_popul_y[N];
    double prob_cpy[N];

    // hago una copia del vector de probabilidad
    memcpy(prob_cpy, prob, sizeof(double)*N);

#warning "algoritmo de más"
    // encuentro la probabilidad menor dentro del arreglo.
    n_popul[0] = n_popul[1] = i_min = index_min(prob_cpy);
    prob_cpy[i_min] = INF;

    n_popul[2] = index_min(prob_cpy);
    prob_cpy[i_min] = INF;
    n_popul[3] = index_min(prob_cpy);

    for(i = 0; i < N; i++)
    {
        n_popul_x[i] = popul_x[n_popul[i]];
        n_popul_y[i] = popul_y[n_popul[i]];
    }

#warning "algoritmo de más"
    pair_i mating_order[N] = {0, 2, 1, 2, 2, 3, 0, 3};

    int o_cross[N];
    for(i = 0; i < N; i++)
        o_cross[i] = N_CROSS - (rand() % N_CROSS);

    printf("o_cross: %d - %d - %d - %d\n", o_cross[0], o_cross[1], o_cross[2], o_cross[3]);
    for(i = 0; i < N; i++)
    {
        popul_x[i] = cross(n_popul_x[mating_order[i].n1], n_popul_x[mating_order[i].n2], o_cross[i]);
        popul_y[i] = cross(n_popul_y[mating_order[i].n1], n_popul_y[mating_order[i].n2], o_cross[i]);
    }
}

double genetic(double (*f)(double, double), pair_f limit_x, pair_f limit_y, int n)
{
    srand(time(NULL));
    srand48(time(NULL));

    register int i;
    int ii;
    double w_x = limit_x.n2 - limit_x.n1;
    double w_y = limit_y.n2 - limit_y.n1;
    double popul_x[N];
    double popul_y[N];
    double p_total = 0.0;
    double p[N];

    for(i = 0; i < N; i++)
    {
        popul_x[i] = (w_x * drand48()) + limit_x.n1;
        popul_y[i] = (w_y * drand48()) + limit_y.n1;
    }

    for(i = 0 ; i < N; i++)
        printf("popul 0: (%.4f, %.4f) =\t%.4f\n", popul_x[i], popul_y[i], f(popul_x[i], popul_y[i]));
    puts("");

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

        puts("");
        for(i = 0 ; i < N; i++)
            printf("popul %d: (%.4f, %.4f) = \t%.4f\n", ii, popul_x[i], popul_y[i], f(popul_x[i], popul_y[i]));
    }
}

int main()
{
    pair_f lx = {0.0, 2.0};
    pair_f ly = {0.0, 2.0};

    genetic(function, lx, ly, 10);
}
