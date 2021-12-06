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

string hash(ulong age, ulong days)
{
    return format("%d_%d", age, days);
}

ulong rec(ulong age, ulong days, ulong[string] mem)
{
    auto hashed = hash(age, days);
    if (hashed in mem)
    {
        return mem[hashed];
    }
    else
    {
        ulong answer = 0;
        if (age > days || (age == 0 && days == 0))
        {
            answer = 1;
        }
        else if (age == 0)
        {
            answer = rec(6, days - 1, mem) + rec(8, days - 1, mem);
        }
        else
        {
            answer = rec(0, days - age, mem);
        }
        mem[hashed] = answer;
        return answer;
    }
}

ulong simulate(ulong days, ulong[] ages)
{
    ages.sort!("a < b");
    ulong sum = 0;
    ulong[string] mem;
    foreach (age; ages)
    {
        sum += rec(age, days, mem);
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
