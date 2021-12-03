module source.day3;

import std.algorithm;
import std.conv;
import std.array;
import std.stdio;

struct Input
{
    ulong line_length;
    int[] numbers;
}

Input parse_input(string[] lines)
{
    auto numbers = lines
        .map!(line => to!int(line, 2))
        .array();
    auto line_length = lines[0].length;
    Input input = {line_length: line_length,
    numbers: numbers};
    return input;
}

int a(Input input)
{
    auto numbers = input.numbers.dup;
    auto line_length = input.line_length;
    auto gamma_rate_reversed = 0;
    auto epsilon_rate_reversed = 0;
    auto col = 0;

    for (ulong i = 0; i < line_length; i++)
    {
        auto one_count = 0;
        auto zero_count = 0;
        foreach (ref number; numbers)
        {
            auto bit = number & 1;
            if (bit == 1)
            {
                one_count++;
            }
            else
            {
                zero_count++;
            }
            number >>= 1;
        }

        if (one_count > zero_count)
        {
            gamma_rate_reversed <<= 1;
            gamma_rate_reversed |= 1;

            epsilon_rate_reversed <<= 1;
        }
        else
        {
            gamma_rate_reversed <<= 1;

            epsilon_rate_reversed <<= 1;
            epsilon_rate_reversed |= 1;
        }
        col++;
    }

    auto gamma_rate = 0;
    auto epsilon_rate = 0;
    for (ulong i = 0; i < line_length; i++)
    {
        gamma_rate <<= 1;
        gamma_rate |= (gamma_rate_reversed & 1);
        gamma_rate_reversed >>= 1;

        epsilon_rate <<= 1;
        epsilon_rate |= (epsilon_rate_reversed & 1);
        epsilon_rate_reversed >>= 1;
    }

    return gamma_rate * epsilon_rate;
}

int b_helper(int[] numbers, ulong line_length, bool o2)
{
    bool[int] map;
    foreach (num; numbers)
    {
        map[num] = true;
    }

    for (ulong i = 0; i < line_length; i++)
    {
        auto ones = 0;
        auto zeros = 0;
        foreach (num, value; map)
        {
            auto bit = (num & (1 << (line_length - i - 1))) == (1 << (line_length - i - 1));
            if (bit == true)
            {
                ones++;
            }
            else
            {
                zeros++;
            }
        }

        foreach (num, value; map)
        {
            auto bit = (num & (1 << (line_length - i - 1))) == (1 << (line_length - i - 1));
            if (o2)
            {
                if ((ones >= zeros && bit == false) || (zeros > ones && bit == true))
                {
                    map.remove(num);
                }
            }
            else
            {
                if ((ones < zeros && bit == false) || (zeros <= ones && bit == true))
                {
                    map.remove(num);
                }
            }
        }

        if (map.length == 1)
        {
            foreach (num, value; map)
            {
                return num;
            }
        }
    }

    return 0;
}

int b(Input input)
{
    auto numbers = input.numbers;
    auto line_length = input.line_length;

    auto oxygen = b_helper(numbers, line_length, true);
    auto co2 = b_helper(numbers, line_length, false);
    return oxygen * co2;
}
