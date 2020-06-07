#include <math.h>
#include <stdbool.h>
#include "mslib.h"

// https://projecteuler.net/problem=9

// Correct output 31875000

int main()
{
    double a = 1, b = 2, c = 3;
    while (true)
    {
        while (a + b + c <= 1000)
        {
            while (a + b + c <= 1000)
            {
                if (pow(a, 2) + pow(b, 2) == pow(c, 2))
                {
                    if (a + b + c == 1000)
                    {
                        writeNumber(a * b * c);
                        return 0;
                    }
                }

                c++;
            }
            b++;
            c = b + 1;
        }
        a++;
        b = a + 1;
        c = b + 1;
    }
}