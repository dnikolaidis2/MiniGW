
// https://projecteuler.net/problem=9

// Correct output 31875000

function start() : void
{
    var a = 1, b = 2, c = 3: number;
    while (true)
    {
        while (a + b + c <= 1000)
        {
            while (a + b + c <= 1000)
            {
                if (a ** 2 + b ** 2 == c**2)
                {
                    if (a + b + c == 1000)
                    {
                        writeNumber(a * b * c);
                        return;
                    };
                };
                c = c + 1;
            };
            b = b + 1;
            c = b + 1;
        };
        a = a + 1;
        b = a + 1;
        c = b + 1;
    };
}