module source.day6;

import std.array;
import std.stdio;
import std.conv;
import std.algorithm;

int[] parse_input(string[] lines)
{
    return lines[0]
        .split(",")
        .map!(line => to!int(line, 10))
        .array();
}

int simulate(int days, int[] ages)
{
    auto curr_ages = ages.dup;
    for (int i = 0; i < days; i++)
    {
        int[] new_ages;
        foreach (age; curr_ages)
        {
            age--;
            if (age < 0)
            {
                age = 6;
                new_ages ~= 8;
            }
            new_ages ~= age;
        }
        curr_ages = new_ages;
    }
    return cast(int) curr_ages.length;
}

int a(int[] ages)
{
    return simulate(80, ages);
}

int b(int[] ages)
{
    return simulate(256, ages);
}
