module source.day6;

import std.array;
import std.stdio;
import std.conv;
import std.algorithm;
import std.format;

ulong[] parse_input(string[] lines)
{
    return lines[0]
        .split(",")
        .map!(line => to!ulong(line, 10))
        .array();
}

ulong simulate(ulong days, ulong[] ages)
{
    ulong[9] ageToChildren;
    foreach (age; ages)
    {
        ageToChildren[age]++;
    }

    for (int i = 0; i < days; i++)
    {
        auto babies = ageToChildren[0];
        ageToChildren[0] = ageToChildren[1];
        ageToChildren[1] = ageToChildren[2];
        ageToChildren[2] = ageToChildren[3];
        ageToChildren[3] = ageToChildren[4];
        ageToChildren[4] = ageToChildren[5];
        ageToChildren[5] = ageToChildren[6];
        ageToChildren[6] = ageToChildren[7] + babies;
        ageToChildren[7] = ageToChildren[8];
        ageToChildren[8] = babies;
    }

    ulong sum = 0;
    foreach (children; ageToChildren) {
        sum += children;
    }

    return sum;
}

ulong a(ulong[] ages)
{
    return simulate(80, ages);
}

ulong b(ulong[] ages)
{
    return simulate(256, ages);
}
