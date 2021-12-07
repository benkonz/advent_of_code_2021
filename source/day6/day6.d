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
    ulong[ulong] map;
    foreach (age; ages) {
        if (age in map) {
            map[age]++;
        } else {
            map[age] = 1;
        }
    }

    for (int i = 0; i < 9; i++) {
        if (!(i in map)) {
            map[i] = 0;
        }
    }

    for (ulong i = 0; i < days; i++)
    {
       auto babies = map[0];
       map[0] = map[1];
       map[1] = map[2];
       map[2] = map[3];
       map[3] = map[4];
       map[4] = map[5];
       map[5] = map[6];
       map[6] = map[7] + babies;
       map[7] = map[8];
       map[8] = babies;
    }

    ulong sum = 0;
    foreach (key, value; map) {
        sum += value;
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
