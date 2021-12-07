module source.day7;

import std.array;
import std.stdio;
import std.conv;
import std.algorithm;
import std.format;
import std.math;

int[] parse_input(string[] input)
{
    return input[0]
        .split(",")
        .map!(num => to!int(num, 10))
        .array();
}

int findFuel(int target, int[] nums)
{
    auto answer = 0;
    foreach (num; nums)
    {
        answer += abs(num - target);
    }
    return answer;
}

int a(int[] input)
{
    auto maxNum = input.maxElement;
    auto answer = int.max;
    for (int i = 0; i < maxNum; i++)
    {
        answer = min(answer, findFuel(i, input));
    }
    return answer;
}
